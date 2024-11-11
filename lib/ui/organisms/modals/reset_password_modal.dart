import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/cubit/forms/user/user_form_cubit.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';

class ResetPasswordModal extends StatelessWidget {
  const ResetPasswordModal({
    required this.user,
    required this.scrollController,
    super.key,
  });

  final User user;
  final ScrollController scrollController;

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final BuildContext context) => UserFormCubit(
          jobsCubit: context.read<JobsCubit>(),
          fieldFactory: FieldCubitFactory(context),
          initialUser: user,
        ),
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
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                children: [
                  const Gap(16),
                  Text(
                    'users.reset_password'.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(16),
                  CubitFormTextField(
                    autofocus: true,
                    formFieldCubit: context.read<UserFormCubit>().password,
                    decoration: InputDecoration(
                      alignLabelWithHint: false,
                      labelText: 'basis.password'.tr(),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: IconButton(
                          icon: Icon(
                            Icons.refresh,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          onPressed:
                              context.read<UserFormCubit>().genNewPassword,
                        ),
                      ),
                    ),
                  ),
                  const Gap(16),
                  BrandButton.filled(
                    onPressed: formCubitState.isSubmitting
                        ? null
                        : () => context.read<UserFormCubit>().trySubmit(),
                    title: 'basis.apply'.tr(),
                  ),
                ],
              ),
            );
          },
        ),
      );
}
