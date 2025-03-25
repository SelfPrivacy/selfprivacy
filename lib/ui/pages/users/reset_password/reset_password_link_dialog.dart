import 'package:auto_route/auto_route.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/cubit/forms/user/reset_password_bloc.dart';
import 'package:selfprivacy/utils/app_logger.dart';
import 'package:selfprivacy/utils/platform_adapter.dart';
import 'package:url_launcher/url_launcher.dart';

const _key = ValueKey('reset_password_link_dialog');

final _log = const AppLogger(name: 'ResetPasswordLinkDialog').log;

class ResetPasswordLinkDialog extends StatelessWidget {
  const ResetPasswordLinkDialog({required this.bloc, super.key});
  final ResetPasswordBloc bloc;

  static const _resizeDuration = Duration(milliseconds: 300);

  @override
  Widget build(final BuildContext context) => BlocProvider.value(
        value: bloc,
        child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(builder: (
          final BuildContext context,
          final ResetPasswordState state,
        ) {
          late final Widget content;
          if (state.passwordResetMessage.isNotEmpty) {
            content = ListTile(
              onTap: () {
                launchUrl(
                  state.passwordResetLink!,
                  mode: LaunchMode.externalApplication,
                );
              },
              title: Text(
                'users.password_reset_link'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            );
          } else if (state.errorMessage.isNotEmpty) {
            content = Text(
              state.errorMessage,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.error,
              ),
            );
          } else {
            // loading state
            content = const SizedBox(
              height: 52,
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return PopScope(
            onPopInvokedWithResult: (final bool isPopped, final _) {
              _log('Pop scope: isPopped: $isPopped');

              _log('Pop scope: cancel reset password ');
              if (state.isLoading) {
                context.read<ResetPasswordBloc>().add(
                      const CancelNewPasswordRequest(),
                    );
              }
            },
            child: AlertDialog(
              key: _key,
              title: AnimatedSize(
                duration: _resizeDuration,
                child: Text(
                  (state.errorMessage.isNotEmpty
                          ? 'basis.error'
                          : state.passwordResetMessage.isNotEmpty
                              ? state.passwordResetMessage
                              : 'users.creating_password_reset_link')
                      .tr(),
                ),
              ),
              content: AnimatedSize(
                duration: _resizeDuration,
                child: content,
              ),
              actions: [
                if (state.isLinkValid)
                  TextButton(
                    child: Text('basis.copy'.tr()),
                    onPressed: () {
                      PlatformAdapter.setClipboard(
                        state.passwordResetLink.toString(),
                      );
                      getIt<NavigationService>().showSnackBar(
                        'basis.copied_to_clipboard'.tr(),
                      );
                    },
                  ),
                const _CloseButton(),
              ],
            ),
          );
        }),
      );
}

class _CloseButton extends StatelessWidget {
  const _CloseButton() : super(key: const ValueKey('close_button'));

  @override
  Widget build(final BuildContext context) => TextButton(
        key: const ValueKey('close_button'),
        onPressed: context.router.maybePop,
        child: Text('basis.close'.tr()),
      );
}
