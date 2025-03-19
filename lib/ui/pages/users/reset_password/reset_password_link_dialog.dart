import 'package:auto_route/auto_route.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/cubit/forms/user/reset_password_bloc.dart';
import 'package:selfprivacy/utils/platform_adapter.dart';
import 'package:url_launcher/url_launcher.dart';

const _key = ValueKey('reset_password_link_dialog');

class ResetPasswordLinkDialog extends StatelessWidget {
  const ResetPasswordLinkDialog({required this.bloc, super.key});
  final ResetPasswordBloc bloc;

  @override
  Widget build(final BuildContext context) => BlocProvider.value(
        value: bloc,
        child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(builder:
            (final BuildContext context, final ResetPasswordState state) {
          final String title = state.errorMessage.isNotEmpty
              ? 'basis.error'.tr()
              : state.passwordResetMessage.isNotEmpty
                  ? state.passwordResetMessage.tr()
                  : 'users.creating_password_reset_link'.tr();

          late final Widget content;
          late final List<Widget> actions;

          if (state.errorMessage.isNotEmpty) {
            content = Text(
              state.errorMessage,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.error,
              ),
            );
            actions = <Widget>[
              TextButton(
                key: const ValueKey('close_button'),
                child: Text(
                  'basis.close'.tr(),
                ),
                onPressed: () {
                  context.router.maybePop();
                },
              ),
            ];
          } else if (state.isLoading) {
            content = const SizedBox(
                height: 52, child: Center(child: CircularProgressIndicator()));
            actions = <Widget>[
              TextButton(
                key: const ValueKey('close_button'),
                child: Text(
                  'basis.close'.tr(),
                ),
                onPressed: () {
                  context.router.maybePop();
                },
              ),
            ];
          } else {
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
            actions = <Widget>[
              TextButton(
                child: Text('basis.copy'.tr()),
                onPressed: () {
                  PlatformAdapter.setClipboard(
                      state.passwordResetLink.toString());
                  getIt<NavigationService>().showSnackBar(
                    'basis.copied_to_clipboard'.tr(),
                  );
                },
              ),
              TextButton(
                key: const ValueKey('close_button'),
                child: Text(
                  'basis.close'.tr(),
                ),
                onPressed: () {
                  context.router.maybePop();
                },
              ),
            ];
          }

          return AlertDialog(
            key: _key,
            title: Text(title),
            content: AnimatedSize(
              key: const ValueKey('animatedSize'),
              duration: const Duration(milliseconds: 300),
              child: content,
            ),
            actions: actions,
          );
        }),
      );
}
