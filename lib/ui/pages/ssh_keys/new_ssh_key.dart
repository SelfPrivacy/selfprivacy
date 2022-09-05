part of 'ssh_keys.dart';

class NewSshKey extends StatelessWidget {
  const NewSshKey(this.user, {final super.key});
  final User user;

  @override
  Widget build(final BuildContext context) => BrandBottomSheet(
        child: BlocProvider(
          create: (final context) {
            final jobCubit = context.read<JobsCubit>();
            final jobState = jobCubit.state;
            if (jobState is JobsStateWithJobs) {
              final jobs = jobState.clientJobList;
              for (final job in jobs) {
                if (job is CreateSSHKeyJob && job.user.login == user.login) {
                  user.sshKeys.add(job.publicKey);
                }
              }
            }
            return SshFormCubit(
              jobsCubit: jobCubit,
              user: user,
            );
          },
          child: Builder(
            builder: (final context) {
              final formCubitState = context.watch<SshFormCubit>().state;

              return BlocListener<SshFormCubit, FormCubitState>(
                listener: (final context, final state) {
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
                    const SizedBox(width: 14),
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
                          const SizedBox(height: 30),
                          BrandButton.rised(
                            onPressed: formCubitState.isSubmitting
                                ? null
                                : () =>
                                    context.read<SshFormCubit>().trySubmit(),
                            text: 'ssh.create'.tr(),
                          ),
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
