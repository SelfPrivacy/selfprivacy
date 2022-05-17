import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/recovering/recovery_domain_form_cubit.dart';
import 'package:selfprivacy/ui/components/brand_button/FilledButton.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';

class RecoveryDomain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appConfig = context.watch<AppConfigCubit>();

    return BlocProvider(
      create: (context) =>
          RecoveryDomainFormCubit(appConfig, FieldCubitFactory(context)),
      child: Builder(
        builder: (context) {
          var formCubitState = context.watch<RecoveryDomainFormCubit>().state;

          return BrandHeroScreen(
            heroTitle: "recovering.recovery_main_header".tr(),
            heroSubtitle: "recovering.domain_recovery_description".tr(),
            hasBackButton: true,
            hasFlashButton: false,
            children: [
              CubitFormTextField(
                formFieldCubit:
                    context.read<RecoveryDomainFormCubit>().serverDomainField,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "recovering.domain_recover_placeholder".tr(),
                ),
              ),
              SizedBox(height: 16),
              FilledButton(
                title: "more.continue".tr(),
                onPressed: formCubitState.isSubmitting
                    ? null
                    : () => context.read<RecoveryDomainFormCubit>().trySubmit(),
              )
            ],
          );
        },
      ),
    );
  }
}
