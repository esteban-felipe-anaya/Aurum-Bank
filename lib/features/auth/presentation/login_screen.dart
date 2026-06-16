import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';

import '../../../core/error/error_mapper.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../shared/widgets/max_width_body.dart';
import '../application/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController(text: 'alex@demo.app');
  final _password = TextEditingController(text: 'demo1234');
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ref
          .read(authControllerProvider.notifier)
          .login(_email.text.trim(), _password.text);
    }
  }

  Future<void> _biometricUnlock() async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final auth = LocalAuthentication();
      final supported =
          await auth.isDeviceSupported() && await auth.canCheckBiometrics;
      if (!supported) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Biometrics unavailable on this device'),
          ),
        );
        return;
      }
      final ok = await auth.authenticate(
        localizedReason: 'Unlock Aurum Bank',
        persistAcrossBackgrounding: true,
      );
      if (ok) {
        await ref
            .read(authControllerProvider.notifier)
            .login('alex@demo.app', 'demo1234');
      }
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Biometrics unavailable')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    ref.listen(authControllerProvider, (prev, next) {
      if (next.hasError && !next.isLoading) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(mapDioError(next.error!).message)),
          );
      }
    });

    return Scaffold(
      body: SafeArea(
        child: MaxWidthBody(
          maxWidth: 440,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(Spacing.xl),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: Spacing.xxxl),
                  Icon(
                    Icons.account_balance_rounded,
                    size: 56,
                    color: scheme.primary,
                  ),
                  const SizedBox(height: Spacing.lg),
                  Text(
                    'Welcome back',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: Spacing.xs),
                  Text(
                    'Sign in to your Aurum account',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: Spacing.xxxl),
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'alex@demo.app',
                      prefixIcon: Icon(Icons.alternate_email_rounded),
                    ),
                    validator: (v) => (v == null || !v.contains('@'))
                        ? 'Enter a valid email'
                        : null,
                  ),
                  const SizedBox(height: Spacing.lg),
                  TextFormField(
                    controller: _password,
                    obscureText: _obscure,
                    autofillHints: const [AutofillHints.password],
                    onFieldSubmitted: (_) => _submit(),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                    validator: (v) => (v == null || v.length < 4)
                        ? 'Password is too short'
                        : null,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.push(AppRoutes.forgotPassword),
                      child: const Text('Forgot password?'),
                    ),
                  ),
                  const SizedBox(height: Spacing.sm),
                  FilledButton(
                    onPressed: isLoading ? null : _submit,
                    child: isLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(strokeWidth: 2.5),
                          )
                        : const Text('Sign in'),
                  ),
                  const SizedBox(height: Spacing.md),
                  OutlinedButton.icon(
                    onPressed: isLoading ? null : _biometricUnlock,
                    icon: const Icon(Icons.fingerprint_rounded),
                    label: const Text('Unlock with biometrics'),
                  ),
                  const SizedBox(height: Spacing.xl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'New here?',
                        style: TextStyle(color: scheme.onSurfaceVariant),
                      ),
                      TextButton(
                        onPressed: () => context.push(AppRoutes.register),
                        child: const Text('Create account'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
