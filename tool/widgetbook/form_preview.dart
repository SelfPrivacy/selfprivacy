import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/logic/forms/checks/credential_validation_result.dart';

import 'catalog_case.dart';

class FormPreviewScope {
  final List<VoidCallback> _disposers = [];
  bool _isDisposed = false;

  void _record(final String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isDisposed) {
        catalogActions.record(message);
      }
    });
  }

  void onDispose(final VoidCallback dispose) => _disposers.add(dispose);

  Future<T> hold<T>(final T result) {
    final completer = Completer<T>();
    onDispose(() => completer.complete(result));
    return completer.future;
  }

  Future<void> submit(final String variant) {
    _record('Form submitted (preview)');
    return variant == 'Submitting' ? hold<void>(null) : Future<void>.value();
  }

  Future<CredentialValidationResult> check(final String variant) {
    _record('Credentials checked (preview)');
    return switch (variant) {
      'Checking' => hold<CredentialValidationResult>(
        const CredentialValidationValid(),
      ),
      'Rejected' => Future.value(const CredentialValidationRejected()),
      'Unavailable' => Future.value(
        const CredentialValidationUnavailable(
          providerMessage: 'The provider is temporarily unavailable.',
        ),
      ),
      _ => Future.value(const CredentialValidationValid()),
    };
  }

  void dispose() {
    _isDisposed = true;
    for (final dispose in _disposers.reversed) {
      dispose();
    }
  }
}

void prepareForm(
  final FormGroup form,
  final String variant,
  final Map<String, Object?> values,
) {
  if (!['Empty', 'Required'].contains(variant)) {
    form.patchValue(values);
  }
  if (variant != 'Empty') {
    form.markAllAsTouched();
  }
}

class FormPreview<T> extends StatefulWidget {
  const FormPreview({
    required this.create,
    required final Widget Function(BuildContext context, T form) builder,
    super.key,
  }) : _builder = builder;
  final T Function(FormPreviewScope scope) create;
  // Only the matching _FormPreviewState<T> calls this with its own form.
  // ignore: unsafe_variance
  final Widget Function(BuildContext context, T form) _builder;

  @override
  State<FormPreview<T>> createState() => _FormPreviewState<T>();
}

class _FormPreviewState<T> extends State<FormPreview<T>> {
  final scope = FormPreviewScope();
  late final T form = widget.create(scope);

  @override
  Widget build(final BuildContext context) => widget._builder(context, form);

  @override
  void dispose() {
    scope.dispose();
    super.dispose();
  }
}
