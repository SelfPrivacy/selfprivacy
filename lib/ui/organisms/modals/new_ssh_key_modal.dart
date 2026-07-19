import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/forms/ssh_key_form.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/ui/forms/ssh_key_form_view.dart';

class NewSshKeyModal extends StatefulWidget {
  const NewSshKeyModal({
    required this.user,
    required this.scrollController,
    super.key,
  });

  final User user;
  final ScrollController scrollController;

  @override
  State<NewSshKeyModal> createState() => _NewSshKeyModalState();
}

class _NewSshKeyModalState extends State<NewSshKeyModal> {
  late final JobsCubit _jobsCubit = context.read<JobsCubit>();
  late final SshKeyForm form = SshKeyForm(
    existingKeys: _existingKeys(),
    onSubmit: (final key) async {
      _jobsCubit.addJob(CreateSSHKeyJob(user: widget.user, publicKey: key));
      if (mounted) {
        Navigator.pop(context);
      }
    },
  );

  List<String> _existingKeys() {
    final pendingKeys = <String>[];
    final jobState = _jobsCubit.state;
    if (jobState is JobsStateWithJobs) {
      for (final job in jobState.clientJobList) {
        if (job is CreateSSHKeyJob && job.user.login == widget.user.login) {
          pendingKeys.add(job.publicKey);
        }
      }
    }
    return [...widget.user.sshKeys, ...pendingKeys];
  }

  @override
  void dispose() {
    form.form.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => ListView(
    controller: widget.scrollController,
    padding: const EdgeInsets.all(16),
    children: [
      const Gap(16),
      Text(
        widget.user.login,
        style: Theme.of(context).textTheme.headlineSmall,
        textAlign: TextAlign.center,
      ),
      const Gap(16),
      SshKeyFormView(sshKeyForm: form),
    ],
  );
}
