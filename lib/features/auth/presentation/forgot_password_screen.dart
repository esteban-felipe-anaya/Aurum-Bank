import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../shared/widgets/max_width_body.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _sent = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Reset password')),
      body: SafeArea(
        child: MaxWidthBody(
          maxWidth: 440,
          child: Padding(
            padding: const EdgeInsets.all(Spacing.xl),
            child: AnimatedSwitcher(
              duration: Motion.medium,
              child: _sent
                  ? _buildSuccess(context, scheme)
                  : _buildForm(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Enter the email linked to your account and we will send a reset link.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: Spacing.xl),
          TextFormField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            onFieldSubmitted: (_) => _submit(),
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.alternate_email_rounded),
            ),
            validator: (v) =>
                (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
          ),
          const SizedBox(height: Spacing.xl),
          FilledButton(
            onPressed: _submit,
            child: const Text('Send reset link'),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, ColorScheme scheme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.mark_email_read_rounded, size: 72, color: scheme.primary),
        const SizedBox(height: Spacing.xl),
        Text('Check your inbox', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: Spacing.sm),
        Text(
          'If ${_email.text.trim()} matches an account, a reset link is on its way.',
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: Spacing.xxl),
        FilledButton.tonal(
          onPressed: () => context.pop(),
          child: const Text('Back to sign in'),
        ),
      ],
    );
  }
}
