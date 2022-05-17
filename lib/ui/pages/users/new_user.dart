part of 'users.dart';

class _NewUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var config = context.watch<ServerInstallationCubit>().state;

    var domainName = UiHelpers.getDomainName(config);

    return BrandBottomSheet(
      child: BlocProvider(
        create: (context) {
          var jobCubit = context.read<JobsCubit>();
          var jobState = jobCubit.state;
          var users = <User>[];
          users.addAll(context.read<UsersCubit>().state.users);
          if (jobState is JobsStateWithJobs) {
            var jobs = jobState.jobList;
            jobs.forEach((job) {
              if (job is CreateUserJob) {
                users.add(job.user);
              }
            });
          }
          return UserFormCubit(
            jobsCubit: jobCubit,
            fieldFactory: FieldCubitFactory(context),
          );
        },
        child: Builder(builder: (context) {
          var formCubitState = context.watch<UserFormCubit>().state;

          return BlocListener<UserFormCubit, FormCubitState>(
            listener: (context, state) {
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
                SizedBox(width: 14),
                Padding(
                  padding: paddingH15V0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IntrinsicHeight(
                        child: CubitFormTextField(
                          formFieldCubit: context.read<UserFormCubit>().login,
                          decoration: InputDecoration(
                            labelText: 'users.login'.tr(),
                            suffixText: '@$domainName',
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      CubitFormTextField(
                        formFieldCubit: context.read<UserFormCubit>().password,
                        decoration: InputDecoration(
                          alignLabelWithHint: false,
                          labelText: 'basis.password'.tr(),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: IconButton(
                              icon: Icon(
                                BrandIcons.refresh,
                                color: BrandColors.blue,
                              ),
                              onPressed:
                                  context.read<UserFormCubit>().genNewPassword,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      BrandButton.rised(
                        onPressed: formCubitState.isSubmitting
                            ? null
                            : () => context.read<UserFormCubit>().trySubmit(),
                        text: 'basis.create'.tr(),
                      ),
                      SizedBox(height: 40),
                      Text('users.new_user_info_note'.tr()),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
