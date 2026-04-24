import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/job.dart';

class SshFormCubit extends FormCubit {
  SshFormCubit({required this.jobsCubit, required this.user}) {
    final RegExp keyRegExp = RegExp(
      r'^(ecdsa-sha2-nistp256 AAAAE2VjZH|ssh-rsa AAAAB3NzaC1yc2|ssh-ed25519 AAAAC3NzaC1lZDI1NTE5)[0-9A-Za-z+/]+[=]{0,3}( .*)?$',
    );

    key = FieldCubit(
      initalValue: '',
      validations: [
        ValidationModel(
          (final String newKey) =>
              user.sshKeys.any((final String key) => key == newKey),
          'validations.already_exist'.tr(),
        ),
        RequiredStringValidation('validations.required'.tr()),
        ValidationModel<String>(
          (final String s) => !keyRegExp.hasMatch(s),
          'validations.invalid_format_ssh'.tr(),
        ),
      ],
    );

    super.addFields([key]);
  }

  @override
  void onSubmit() {
    jobsCubit.addJob(
      CreateSSHKeyJob(user: user, publicKey: key.state.value.trim()),
    );
  }

  late FieldCubit<String> key;

  final JobsCubit jobsCubit;
  final User user;
}

class JoblessSshFormCubit extends FormCubit {
  JoblessSshFormCubit(this.serverInstallationCubit) {
    final RegExp keyRegExp = RegExp(
      r'^(ecdsa-sha2-nistp256 AAAAE2VjZH|ssh-rsa AAAAB3NzaC1yc2|ssh-ed25519 AAAAC3NzaC1lZDI1NTE5)[0-9A-Za-z+/]+[=]{0,3}( .*)?$',
    );

    key = FieldCubit(
      initalValue: '',
      validations: [
        RequiredStringValidation('validations.required'.tr()),
        ValidationModel<String>(
          (final String s) => !keyRegExp.hasMatch(s),
          'validations.invalid_format_ssh'.tr(),
        ),
      ],
    );

    super.addFields([key]);
  }

  @override
  Future<void> onSubmit() async {
    await serverInstallationCubit.setCustomSshKey(key.state.value);
  }

  final ServerInstallationCubit serverInstallationCubit;

  late FieldCubit<String> key;
}
