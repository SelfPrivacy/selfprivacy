import 'package:auto_route/auto_route.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/cubit/forms/user/user_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/utils/platform_adapter.dart';
import 'package:selfprivacy/utils/ui_helpers.dart';

@RoutePage()
class NewUserPage extends StatelessWidget {
  const NewUserPage({super.key});

  @override
  Widget build(final BuildContext context) {
    final ServerInstallationState config =
        context.watch<ServerInstallationCubit>().state;

    final String domainName = UiHelpers.getDomainName(config);

    return BlocProvider(
      create: (final BuildContext context) {
        final jobCubit = context.read<JobsCubit>();

        // final jobsState = jobCubit.state;
        // final users = <User>[
        //   ...context.read<UsersBloc>().state.users,
        //   if (jobsState is JobsStateWithJobs)
        //     ...jobsState.clientJobList
        //         .whereType<CreateUserJob>()
        //         .map((final job) => job.user),
        // ];

        return UserFormCubit(
          jobsCubit: jobCubit,
          fieldFactory: FieldCubitFactory(context),
        );
      },
      child: Builder(
        builder: (final BuildContext context) {
          final FormCubitState formCubitState =
              context.watch<UserFormCubit>().state;

          return BlocListener<UserFormCubit, FormCubitState>(
            listener: (final BuildContext context, final FormCubitState state) {
              if (state.isSubmitted) {
                context.router.maybePop();
              }
            },
            child: BrandHeroScreen(
              heroTitle: 'users.new_user'.tr(),
              heroIcon: Icons.person_add_outlined,
              children: [
                if (formCubitState.isErrorShown)
                  Text(
                    'users.username_rule'.tr(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                const SizedBox(width: 14),
                IntrinsicHeight(
                  child: CubitFormTextField(
                    autofocus: true,
                    formFieldCubit: context.read<UserFormCubit>().login,
                    decoration: InputDecoration(
                      labelText: 'users.login'.tr(),
                      suffixText: '@$domainName',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CubitFormTextField(
                  formFieldCubit: context.read<UserFormCubit>().password,
                  decoration: InputDecoration(
                    alignLabelWithHint: false,
                    labelText: 'basis.password'.tr(),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.copy,
                              size: 24.0,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            onPressed: () {
                              final String currentPassword = context
                                  .read<UserFormCubit>()
                                  .password
                                  .state
                                  .value;
                              PlatformAdapter.setClipboard(currentPassword);
                              getIt<NavigationService>().showSnackBar(
                                'basis.copied_to_clipboard'.tr(),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.refresh,
                              size: 24.0,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            onPressed:
                                context.read<UserFormCubit>().genNewPassword,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                BrandButton.filled(
                  onPressed: formCubitState.isSubmitting
                      ? null
                      : () => context.read<UserFormCubit>().trySubmit(),
                  title: 'basis.create'.tr(),
                ),
                const SizedBox(height: 40),
                Text('users.new_user_info_note'.tr()),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}
