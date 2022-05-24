import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/backblaze_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/brand_bottom_sheet/brand_bottom_sheet.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/ui/components/brand_md/brand_md.dart';

class RecoveryConfirmBackblaze extends StatelessWidget {
  const RecoveryConfirmBackblaze({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appConfig = context.watch<ServerInstallationCubit>();

    return BlocProvider(
      create: (context) => BackblazeFormCubit(appConfig),
      child: Builder(builder: (context) {
        var formCubitState = context.watch<BackblazeFormCubit>().state;

        return BrandHeroScreen(
          heroTitle: 'recovering.confirm_backblaze'.tr(),
          heroSubtitle: 'recovering.confirm_backblaze_description'.tr(),
          hasBackButton: true,
          hasFlashButton: false,
          children: [
            CubitFormTextField(
              formFieldCubit: context.read<BackblazeFormCubit>().keyId,
              textAlign: TextAlign.center,
              scrollPadding: const EdgeInsets.only(bottom: 70),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'KeyID',
              ),
            ),
            const SizedBox(height: 18),
            CubitFormTextField(
              formFieldCubit: context.read<BackblazeFormCubit>().applicationKey,
              textAlign: TextAlign.center,
              scrollPadding: const EdgeInsets.only(bottom: 70),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Master Application Key',
              ),
            ),
            const SizedBox(height: 18),
            BrandButton.rised(
              onPressed: formCubitState.isSubmitting
                  ? null
                  : () => context.read<BackblazeFormCubit>().trySubmit(),
              text: 'basis.connect'.tr(),
            ),
            const SizedBox(height: 18),
            BrandButton.text(
              onPressed: () => showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return const BrandBottomSheet(
                    isExpended: true,
                    child: Padding(
                      padding: paddingH15V0,
                      child: BrandMarkdown(
                        fileName: 'how_backblaze',
                      ),
                    ),
                  );
                },
              ),
              title: 'initializing.how'.tr(),
            ),
          ],
        );
      }),
    );
  }
}
