import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/error_mapper.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/color_utils.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/account.dart';
import '../../../data/models/beneficiary.dart';
import '../../../shared/widgets/async_value_view.dart';
import '../../../shared/widgets/max_width_body.dart';
import '../../accounts/application/accounts_providers.dart';
import '../application/transfer_controller.dart';
import '../application/transfer_validation.dart';

class TransferFlowScreen extends ConsumerStatefulWidget {
  const TransferFlowScreen({super.key});

  @override
  ConsumerState<TransferFlowScreen> createState() => _TransferFlowScreenState();
}

class _TransferFlowScreenState extends ConsumerState<TransferFlowScreen> {
  int _step = 0; // 0 beneficiary, 1 amount, 2 review
  final _amountController = TextEditingController();
  String? _amountError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(transferControllerProvider.notifier).reset();
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _back() {
    if (_step == 0) {
      Navigator.of(context).pop();
    } else {
      setState(() => _step -= 1);
    }
  }

  void _validateAndContinueAmount() {
    final state = ref.read(transferControllerProvider);
    final balance = state.fromAccount?.balance;
    final error = TransferValidation.validateAmount(
      _amountController.text,
      balance: balance,
    );
    setState(() => _amountError = error);
    if (error == null) {
      final amount = TransferValidation.parseAmount(_amountController.text)!;
      ref.read(transferControllerProvider.notifier).setAmount(amount);
      setState(() => _step = 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(transferControllerProvider);
    final submission = state.submission;

    // Show success once a transfer has been created.
    if (submission.value != null) {
      return _SuccessView(
        beneficiary: state.beneficiary!,
        amount: state.amount,
      );
    }

    ref.listen(transferControllerProvider.select((s) => s.submission), (
      prev,
      next,
    ) {
      if (next.hasError && !next.isLoading) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(mapDioError(next.error!).message)),
          );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Send money'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: _back,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(value: (_step + 1) / 3),
        ),
      ),
      body: MaxWidthBody(
        maxWidth: 560,
        child: AnimatedSwitcher(
          duration: Motion.medium,
          child: switch (_step) {
            0 => _BeneficiaryStep(
              key: const ValueKey(0),
              onSelected: (b) {
                ref
                    .read(transferControllerProvider.notifier)
                    .selectBeneficiary(b);
                setState(() => _step = 1);
              },
            ),
            1 => _AmountStep(
              key: const ValueKey(1),
              controller: _amountController,
              errorText: _amountError,
              onContinue: _validateAndContinueAmount,
            ),
            _ => _ReviewStep(
              key: const ValueKey(2),
              state: state,
              submitting: submission.isLoading,
              onConfirm: () =>
                  ref.read(transferControllerProvider.notifier).submit(),
            ),
          },
        ),
      ),
    );
  }
}

class _BeneficiaryStep extends ConsumerWidget {
  const _BeneficiaryStep({super.key, required this.onSelected});
  final ValueChanged<Beneficiary> onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final beneficiaries = ref.watch(beneficiariesProvider);
    return Padding(
      padding: const EdgeInsets.all(Spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Who are you paying?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: Spacing.lg),
          Expanded(
            child: AsyncValueView<List<Beneficiary>>(
              value: beneficiaries,
              onRetry: () => ref.invalidate(beneficiariesProvider),
              data: (list) => ListView.separated(
                itemCount: list.length,
                separatorBuilder: (_, _) => const SizedBox(height: Spacing.sm),
                itemBuilder: (context, i) {
                  final b = list[i];
                  return Card(
                    child: ListTile(
                      onTap: () => onSelected(b),
                      leading: CircleAvatar(
                        backgroundColor: colorFromHex(b.avatarColor),
                        child: Text(
                          b.name.isNotEmpty ? b.name[0] : '?',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        b.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text('${b.bank} • ${b.accountNumberMasked}'),
                      trailing: const Icon(Icons.chevron_right_rounded),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AmountStep extends ConsumerWidget {
  const _AmountStep({
    super.key,
    required this.controller,
    required this.errorText,
    required this.onContinue,
  });
  final TextEditingController controller;
  final String? errorText;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(accountsProvider);
    final transfer = ref.watch(transferControllerProvider);

    return Padding(
      padding: const EdgeInsets.all(Spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('How much?', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: Spacing.xl),
          TextField(
            controller: controller,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800),
            decoration: InputDecoration(
              prefixText: '\$ ',
              hintText: '0.00',
              errorText: errorText,
              filled: false,
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: Spacing.xl),
          Text('From account', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: Spacing.sm),
          AsyncValueView<List<Account>>(
            value: accounts,
            loading: const SizedBox(height: 60),
            onRetry: () => ref.invalidate(accountsProvider),
            data: (list) {
              final selected =
                  transfer.fromAccount ?? (list.isNotEmpty ? list.first : null);
              if (selected != null && transfer.fromAccount == null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref
                      .read(transferControllerProvider.notifier)
                      .selectFromAccount(selected);
                });
              }
              return Column(
                children: [
                  for (final a in list)
                    Card(
                      child: ListTile(
                        onTap: () => ref
                            .read(transferControllerProvider.notifier)
                            .selectFromAccount(a),
                        title: Text(a.name),
                        subtitle: Text(
                          '${a.accountNumberMasked} • ${Formatters.money(a.balance, a.currency)}',
                        ),
                        trailing: Icon(
                          selected?.id == a.id
                              ? Icons.radio_button_checked_rounded
                              : Icons.radio_button_unchecked_rounded,
                          color: selected?.id == a.id
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const Spacer(),
          FilledButton(
            onPressed: onContinue,
            child: const Text('Review transfer'),
          ),
        ],
      ),
    );
  }
}

class _ReviewStep extends StatelessWidget {
  const _ReviewStep({
    super.key,
    required this.state,
    required this.submitting,
    required this.onConfirm,
  });
  final TransferState state;
  final bool submitting;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final currency = state.fromAccount?.currency ?? 'USD';
    return Padding(
      padding: const EdgeInsets.all(Spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Review', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: Spacing.lg),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
              child: Column(
                children: [
                  _Row(label: 'To', value: state.beneficiary?.name ?? '—'),
                  _Row(label: 'Bank', value: state.beneficiary?.bank ?? '—'),
                  _Row(label: 'From', value: state.fromAccount?.name ?? '—'),
                  _Row(
                    label: 'Amount',
                    value: Formatters.money(state.amount, currency),
                  ),
                  _Row(
                    label: 'Fee',
                    value: state.fee == 0
                        ? 'Free'
                        : Formatters.money(state.fee, currency),
                  ),
                  _Row(
                    label: 'Total',
                    value: Formatters.money(state.total, currency),
                    emphasize: true,
                    isLast: true,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          FilledButton(
            onPressed: submitting ? null : onConfirm,
            child: submitting
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  )
                : Text('Send ${Formatters.money(state.total, currency)}'),
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.label,
    required this.value,
    this.emphasize = false,
    this.isLast = false,
  });
  final String label;
  final String value;
  final bool emphasize;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Spacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(color: scheme.onSurfaceVariant)),
              Text(
                value,
                style: TextStyle(
                  fontWeight: emphasize ? FontWeight.w800 : FontWeight.w600,
                  fontSize: emphasize ? 18 : null,
                ),
              ),
            ],
          ),
        ),
        if (!isLast) const Divider(height: 1),
      ],
    );
  }
}

class _SuccessView extends ConsumerStatefulWidget {
  const _SuccessView({required this.beneficiary, required this.amount});
  final Beneficiary beneficiary;
  final double amount;

  @override
  ConsumerState<_SuccessView> createState() => _SuccessViewState();
}

class _SuccessViewState extends ConsumerState<_SuccessView> {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: Motion.slow,
                curve: Curves.elasticOut,
                builder: (context, v, child) =>
                    Transform.scale(scale: v, child: child),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(Spacing.xl),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00B894).withValues(alpha: 0.16),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      size: 64,
                      color: Color(0xFF00B894),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: Spacing.xl),
              Text(
                'Transfer sent',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: Spacing.sm),
              Text(
                'You sent ${Formatters.money(widget.amount, 'USD')} to ${widget.beneficiary.name}.',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: Spacing.xxxl),
              FilledButton(
                onPressed: () {
                  ref.read(transferControllerProvider.notifier).reset();
                  Navigator.of(context).pop();
                },
                child: const Text('Done'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
