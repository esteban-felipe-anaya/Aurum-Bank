import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/error_mapper.dart';
import '../../../core/providers/providers.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/payment_request.dart';
import '../../../shared/widgets/max_width_body.dart';
import '../../accounts/application/accounts_providers.dart';

/// Creates a shareable "request money" link with an amount and optional note.
class RequestMoneyScreen extends ConsumerStatefulWidget {
  const RequestMoneyScreen({super.key});

  @override
  ConsumerState<RequestMoneyScreen> createState() => _RequestMoneyScreenState();
}

class _RequestMoneyScreenState extends ConsumerState<RequestMoneyScreen> {
  final _amount = TextEditingController();
  final _note = TextEditingController();
  String? _error;
  bool _saving = false;
  PaymentRequest? _result;

  @override
  void dispose() {
    _amount.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    final amount = double.tryParse(_amount.text.trim().replaceAll(',', ''));
    if (amount == null || amount <= 0) {
      setState(() => _error = 'Enter a valid amount');
      return;
    }
    setState(() {
      _error = null;
      _saving = true;
    });
    final currency = ref.read(primaryCurrencyProvider);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final request = await ref.read(paymentsRepositoryProvider).requestMoney(
        amount: amount,
        currency: currency,
        note: _note.text.trim().isEmpty ? null : _note.text.trim(),
      );
      setState(() {
        _result = request;
        _saving = false;
      });
    } catch (e) {
      setState(() => _saving = false);
      messenger.showSnackBar(SnackBar(content: Text(mapDioError(e).message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request money')),
      body: MaxWidthBody(
        maxWidth: 520,
        child: _result == null ? _form(context) : _success(context, _result!),
      ),
    );
  }

  Widget _form(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(Spacing.lg),
      children: [
        Text(
          'How much are you requesting?',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: Spacing.xl),
        TextField(
          controller: _amount,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
          ],
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800),
          onChanged: (_) {
            if (_error != null) setState(() => _error = null);
          },
          decoration: InputDecoration(
            prefixText: '\$ ',
            hintText: '0.00',
            errorText: _error,
            filled: false,
            border: InputBorder.none,
          ),
        ),
        const SizedBox(height: Spacing.xl),
        TextField(
          controller: _note,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            labelText: 'What\'s it for? (optional)',
            prefixIcon: Icon(Icons.notes_rounded),
          ),
        ),
        const SizedBox(height: Spacing.xxl),
        FilledButton(
          onPressed: _saving ? null : _create,
          child: _saving
              ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                )
              : const Text('Create request'),
        ),
      ],
    );
  }

  Widget _success(BuildContext context, PaymentRequest request) {
    final scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(Spacing.lg),
      children: [
        const SizedBox(height: Spacing.lg),
        Center(
          child: Container(
            padding: const EdgeInsets.all(Spacing.xl),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [scheme.primary, scheme.tertiary],
              ),
              borderRadius: Radii.cardLg,
            ),
            child: Column(
              children: [
                Text(
                  'Request for',
                  style: TextStyle(
                    color: scheme.onPrimary.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(height: Spacing.xs),
                Text(
                  Formatters.money(request.amount, request.currency),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: scheme.onPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (request.note != null) ...[
                  const SizedBox(height: Spacing.xs),
                  Text(
                    request.note!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: scheme.onPrimary.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: Spacing.xl),
        Card(
          child: ListTile(
            leading: const Icon(Icons.tag_rounded),
            title: const Text('Reference code'),
            subtitle: Text(request.code),
            trailing: IconButton(
              tooltip: 'Copy code',
              icon: const Icon(Icons.copy_rounded),
              onPressed: () => _copy(context, request.code, 'Code copied'),
            ),
          ),
        ),
        const SizedBox(height: Spacing.sm),
        Card(
          child: ListTile(
            leading: const Icon(Icons.link_rounded),
            title: const Text('Payment link'),
            subtitle: Text(
              request.shareLink,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              tooltip: 'Copy link',
              icon: const Icon(Icons.copy_rounded),
              onPressed: () => _copy(context, request.shareLink, 'Link copied'),
            ),
          ),
        ),
        const SizedBox(height: Spacing.xxl),
        FilledButton.icon(
          onPressed: () =>
              _copy(context, request.shareLink, 'Link copied — share it!'),
          icon: const Icon(Icons.ios_share_rounded),
          label: const Text('Share request'),
        ),
        const SizedBox(height: Spacing.sm),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Done'),
        ),
      ],
    );
  }

  Future<void> _copy(BuildContext context, String text, String message) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
