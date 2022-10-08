part of 'users.dart';

class NewUser extends StatelessWidget {
  const NewUser({final super.key});

  @override
  Widget build(final BuildContext context) {
    final ServerInstallationState config =
        context.watch<ServerInstallationCubit>().state;

    final String domainName = UiHelpers.getDomainName(config);

    return BrandBottomSheet(
      child: BlocProvider(
        create: (final BuildContext context) {
          final jobCubit = context.read<JobsCubit>();
          final jobState = jobCubit.state;
          final users = <User>[];
          users.addAll(context.read<UsersCubit>().state.users);
          if (jobState is JobsStateWithJobs) {
            final jobs = jobState.clientJobList;
            for (final job in jobs) {
              if (job is CreateUserJob) {
                users.add(job.user);
              }
            }
          }
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
              listener:
                  (final BuildContext context, final FormCubitState state) {
                if (state.isSubmitted) {
                  Navigator.pop(context);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  BrandHeader(
                    title: 'users.new_user'.tr(),
                  ),
                  const SizedBox(width: 14),
                  Padding(
                    padding: paddingH15V0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                            formFieldCubit: context.read<UserFormCubit>().login,
                            decoration: InputDecoration(
                              labelText: 'users.login'.tr(),
                              suffixText: '@$domainName',
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CubitFormTextField(
                          formFieldCubit:
                              context.read<UserFormCubit>().password,
                          decoration: InputDecoration(
                            alignLabelWithHint: false,
                            labelText: 'basis.password'.tr(),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: IconButton(
                                icon: Icon(
                                  BrandIcons.refresh,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: context
                                    .read<UserFormCubit>()
                                    .genNewPassword,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        BrandButton.rised(
                          onPressed: formCubitState.isSubmitting
                              ? null
                              : () => context.read<UserFormCubit>().trySubmit(),
                          text: 'basis.create'.tr(),
                        ),
                        const SizedBox(height: 40),
                        Text('users.new_user_info_note'.tr()),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
