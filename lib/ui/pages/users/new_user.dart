import 'package:auto_route/auto_route.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/cubit/forms/user/user_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/utils/ui_helpers.dart';

@RoutePage()
class NewUserPage extends StatelessWidget {
  const NewUserPage({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final BuildContext context) => UserFormCubit(
          fieldFactory: FieldCubitFactory(context),
          initialUser: null,
        ),
        child: BlocConsumer<UserFormCubit, FormCubitState>(
          listener: (
            final BuildContext context,
            final FormCubitState state,
          ) {
            if (state.isSubmitted) {
              context.router.maybePop();
            }
          },
          builder: (
            final BuildContext context,
            final FormCubitState state,
          ) =>
              NewUserScreen(state: state),
        ),
      );
}

class NewUserScreen extends StatelessWidget {
  const NewUserScreen({required this.state, super.key});
  final FormCubitState state;

  @override
  Widget build(final BuildContext context) {
    final ServerInstallationState config =
        context.watch<ServerInstallationCubit>().state;

    final String domainName = UiHelpers.getDomainName(config);

    return BrandHeroScreen(
      heroTitle: 'users.new_user'.tr(),
      heroIcon: Icons.person_add_outlined,
      children: [
        if (state.isErrorShown)
          Text(
            'users.username_rule'.tr(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        const Gap(14),
        IntrinsicHeight(
          child: CubitFormTextField(
            /// should make this read-only when the user is created
            autofocus: true,
            formFieldCubit: context.read<UserFormCubit>().login,
            decoration: InputDecoration(
              labelText: 'users.login'.tr(),
              suffixText: '@$domainName',
            ),
          ),
        ),
        // if (state.userCreated) ...[
        //   const Gap(20),
        //   Text('users.generate_password_reset_link'.tr()),
        // ],
        const Gap(30),
        BrandButton.filled(
          onPressed: state.isSubmitting
              ? null
              : () => context.read<UserFormCubit>().trySubmit(),
          title: 'basis.create'.tr(),
        ),
        const SizedBox(height: 40),
        Text('users.new_user_info_note'.tr()),
        const SizedBox(height: 30),
      ],
    );
  }
}
