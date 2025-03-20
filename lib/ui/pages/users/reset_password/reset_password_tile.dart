import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/cubit/forms/user/reset_password_bloc.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/pages/users/reset_password/reset_password_link_dialog.dart';

class ResetPasswordTile extends StatelessWidget {
  const ResetPasswordTile({required this.user, super.key});

  final User user;

  @override
  Widget build(final BuildContext context) => BlocProvider<ResetPasswordBloc>(
        create: (final BuildContext context) => ResetPasswordBloc(user: user),
        child: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
          listener:
              (final BuildContext context, final ResetPasswordState state) {
            final bloc = context.read<ResetPasswordBloc>();

            /// check on success
            if (state.isLoading) {
              showDialog(
                context: context,
                builder: (final BuildContext context) =>
                    ResetPasswordLinkDialog(
                  bloc: bloc,
                ),
              );
            }
          },
          builder: (
            final BuildContext context,
            final ResetPasswordState state,
          ) =>
              _Tile(isLoading: state.isLoading),
        ),
      );
}

class _Tile extends StatelessWidget {
  const _Tile({required this.isLoading});
  final bool isLoading;

  @override
  Widget build(final BuildContext context) => ListTile(
        iconColor: Theme.of(context).colorScheme.onSurface,
        onTap: () =>
            context.read<ResetPasswordBloc>().add(const RequestNewPassword()),
        leading: const Icon(Icons.lock_reset_outlined),
        title: Text(
          'users.request_password_reset_link'.tr(),
        ),
      );
}
