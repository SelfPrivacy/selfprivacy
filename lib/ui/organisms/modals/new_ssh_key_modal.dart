import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/user/ssh_form_cubit.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';

class NewSshKeyModal extends StatelessWidget {
  const NewSshKeyModal({
    required this.user,
    required this.scrollController,
    super.key,
  });

  final User user;
  final ScrollController scrollController;

  @override
  Widget build(final BuildContext context) => BlocProvider(
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
      return SshFormCubit(jobsCubit: jobCubit, user: user);
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
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            children: [
              const Gap(16),
              Text(
                user.login,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const Gap(16),
              IntrinsicHeight(
                child: CubitFormTextField(
                  autofocus: true,
                  formFieldCubit: context.read<SshFormCubit>().key,
                  decoration: InputDecoration(
                    labelText: 'ssh.input_label'.tr(),
                    filled: true,
                  ),
                ),
              ),
              const Gap(16),
              BrandButton.filled(
                onPressed:
                    formCubitState.isSubmitting
                        ? null
                        : () => context.read<SshFormCubit>().trySubmit(),
                title: 'ssh.create'.tr(),
              ),
            ],
          ),
        );
      },
    ),
  );
}
