part of 'ssh_keys.dart';

class _NewSshKey extends StatelessWidget {
  final User user;

  _NewSshKey(this.user);

  @override
  Widget build(BuildContext context) {
    return BrandBottomSheet(
      child: BlocProvider(
        create: (context) {
          var jobCubit = context.read<JobsCubit>();
          var jobState = jobCubit.state;
          if (jobState is JobsStateWithJobs) {
            var jobs = jobState.jobList;
            jobs.forEach((job) {
              if (job is CreateSSHKeyJob && job.user.login == user.login) {
                user.sshKeys.add(job.publicKey);
              }
            });
          }
          return SshFormCubit(
            jobsCubit: jobCubit,
            user: user,
          );
        },
        child: Builder(builder: (context) {
          var formCubitState = context.watch<SshFormCubit>().state;

          return BlocListener<SshFormCubit, FormCubitState>(
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
                  title: user.login,
                ),
                SizedBox(width: 14),
                Padding(
                  padding: paddingH15V0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IntrinsicHeight(
                        child: CubitFormTextField(
                          formFieldCubit: context.read<SshFormCubit>().key,
                          decoration: InputDecoration(
                            labelText: 'ssh.input_label'.tr(),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      BrandButton.rised(
                        onPressed: formCubitState.isSubmitting
                            ? null
                            : () => context.read<SshFormCubit>().trySubmit(),
                        text: 'ssh.create'.tr(),
                      ),
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
