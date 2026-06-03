import 'package:cookie/core/widgets/adaptive/adaptive_scaffold.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_app_bar.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_button.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_progress_indicator.dart';
import 'package:cookie/features/auth/providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isSubmitting = false;
  String? _errorText;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final valid = context.useIos
        ? _usernameController.text.trim().isNotEmpty &&
              _passwordController.text.isNotEmpty
        : _formKey.currentState!.validate();
    if (!valid) return;
    setState(() {
      _isSubmitting = true;
      _errorText = null;
    });
    try {
      await ref
          .read(authProvider.notifier)
          .login(_usernameController.text.trim(), _passwordController.text);
      if (!mounted) return;
      // If pushed on top of another screen (e.g. from AuthGate), pop back.
      // Otherwise navigate to home.
      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/');
      }
    } on DioException catch (e) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
        _errorText = _resolveError(e);
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
        _errorText = context.l10n.errorGeneric;
      });
    }
  }

  String _resolveError(DioException e) {
    return switch (e.response?.statusCode) {
      401 => context.l10n.loginErrorInvalid,
      403 => context.l10n.loginErrorSuspended,
      _ => context.l10n.errorGeneric,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(title: Text(l10n.loginTitle)),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    if (_errorText != null) ...[
                      _ErrorBanner(message: _errorText!),
                      const SizedBox(height: 24),
                    ],
                    if (context.useIos) ...[
                      Builder(
                        builder: (context) {
                          final cs = Theme.of(context).colorScheme;
                          final textStyle = TextStyle(color: cs.onSurface);
                          final hintStyle = TextStyle(
                            color: cs.onSurface.withValues(alpha: 0.5),
                          );
                          final iconColor = cs.onSurfaceVariant;
                          return Column(
                            children: [
                              GlassTextField(
                                controller: _usernameController,
                                placeholder: l10n.loginUsernameLabel,
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: iconColor,
                                ),
                                textStyle: textStyle,
                                placeholderStyle: hintStyle,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) =>
                                    setState(() => _errorText = null),
                              ),
                              const SizedBox(height: 16),
                              GlassTextField(
                                controller: _passwordController,
                                placeholder: l10n.loginPasswordLabel,
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: iconColor,
                                ),
                                suffixIcon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: iconColor,
                                ),
                                onSuffixTap: () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                                textStyle: textStyle,
                                placeholderStyle: hintStyle,
                                obscureText: _obscurePassword,
                                textInputAction: TextInputAction.done,
                                onSubmitted: (_) => _submit(),
                                onChanged: (_) =>
                                    setState(() => _errorText = null),
                              ),
                            ],
                          );
                        },
                      ),
                    ] else ...[
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: l10n.loginUsernameLabel,
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.username],
                        onChanged: (_) => setState(() => _errorText = null),
                        validator: (v) =>
                            (v == null || v.trim().isEmpty) ? ' ' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: l10n.loginPasswordLabel,
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                          ),
                        ),
                        obscureText: _obscurePassword,
                        textInputAction: TextInputAction.done,
                        autofillHints: const [AutofillHints.password],
                        onFieldSubmitted: (_) => _submit(),
                        onChanged: (_) => setState(() => _errorText = null),
                        validator: (v) => (v == null || v.isEmpty) ? ' ' : null,
                      ),
                    ],
                    const SizedBox(height: 16),
                    AdaptiveFilledButton(
                      onPressed: _isSubmitting ? null : _submit,
                      child: _isSubmitting
                          ? const SizedBox.square(
                              dimension: 20,
                              child: AdaptiveProgressIndicator(strokeWidth: 2),
                            )
                          : Text(l10n.loginButton),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(l10n.loginRegisterPrompt),
                        const SizedBox(width: 4),
                        AdaptiveTextButton(
                          onPressed: () => launchUrl(
                            Uri.parse('https://discuit.org/'),
                            mode: LaunchMode.externalApplication,
                          ),
                          child: Text(l10n.loginRegisterLink),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: colorScheme.onErrorContainer),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: colorScheme.onErrorContainer),
            ),
          ),
        ],
      ),
    );
  }
}
