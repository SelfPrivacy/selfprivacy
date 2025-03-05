import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/cubit/forms/user/reset_password_bloc.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/utils/platform_adapter.dart';

class ResetPasswordTile extends StatelessWidget {
  const ResetPasswordTile({required this.user, super.key});

  final User user;

  @override
  Widget build(final BuildContext context) => BlocProvider<ResetPasswordBloc>(
        create: (final BuildContext context) => ResetPasswordBloc(user: user),
        child: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
          listener:
              (final BuildContext context, final ResetPasswordState state) {
            /// check on error
            if (state.errorMessage != '') {
              getIt<NavigationService>().showSnackBar(state.errorMessage);
            }

            /// check on success
            if (state.passwordResetLink != null) {
              showDialog(
                context: context,
                builder: (final BuildContext context) =>
                    _ResetPasswordLinkDialog(state: state),
              );
            }
          },
          builder:
              (final BuildContext context, final ResetPasswordState state) =>
                  _Tile(state: state),
        ),
      );
}

class _ResetPasswordLinkDialog extends StatelessWidget {
  const _ResetPasswordLinkDialog({required this.state});
  final ResetPasswordState state;

  @override
  Widget build(final BuildContext context) => AlertDialog(
        title: Text(state.passwordResetMessage),
        content: Text(
          state.passwordResetLink.toString(),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('basis.copy'.tr()),
            onPressed: () {
              PlatformAdapter.setClipboard(state.passwordResetLink.toString());
              getIt<NavigationService>().showSnackBar(
                'basis.copied_to_clipboard'.tr(),
              );
            },
          ),
          TextButton(
            child: Text(
              'basis.close'.tr(),
            ),
            onPressed: () {
              context.router.maybePop();
            },
          ),
        ],
      );
}

class _Tile extends StatelessWidget {
  const _Tile({required this.state});
  final ResetPasswordState state;

  @override
  Widget build(final BuildContext context) => ListTile(
        iconColor: Theme.of(context).colorScheme.onSurface,
        onTap: state.isLoading
            ? null
            : () {
                context
                    .read<ResetPasswordBloc>()
                    .add(const RequestNewPassword());
              },
        leading: const Icon(Icons.lock_reset_outlined),
        trailing: state.isLoading ? const CircularProgressIndicator() : null,
        title: Text(
          'users.request_password_reset_link'.tr(),
        ),
      );
}
