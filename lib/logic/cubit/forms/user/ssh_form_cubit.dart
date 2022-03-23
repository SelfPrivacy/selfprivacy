import 'dart:async';

import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/logic/cubit/jobs/jobs_cubit.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/logic/models/user.dart';

class SshFormCubit extends FormCubit {
  SshFormCubit({
    required this.jobsCubit,
    required this.user,
  }) {
    var keyRegExp = RegExp(
        r"^(ssh-rsa AAAAB3NzaC1yc2|ssh-ed25519 AAAAC3NzaC1lZDI1NTE5)[0-9A-Za-z+/]+[=]{0,3}( .*)?$");

    key = FieldCubit(
      initalValue: '',
      validations: [
        ValidationModel(
          (newKey) => user.sshKeys.any((key) => key == newKey),
          'validations.key_already_exists'.tr(),
        ),
        RequiredStringValidation('validations.required'.tr()),
        ValidationModel<String>((s) {
          print(s);
          print(keyRegExp.hasMatch(s));
          return !keyRegExp.hasMatch(s);
        }, 'validations.invalid_format'.tr()),
      ],
    );

    super.addFields([key]);
  }

  @override
  FutureOr<void> onSubmit() {
    print(key.state.isValid);
    jobsCubit.addJob(CreateSSHKeyJob(user: user, publicKey: key.state.value));
  }

  late FieldCubit<String> key;

  final JobsCubit jobsCubit;
  final User user;
}
