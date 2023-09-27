import 'package:auto_route/auto_route.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/backblaze_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/ui/components/buttons/brand_button.dart';
import 'package:selfprivacy/ui/layouts/responsive_layout_with_infobox.dart';

@RoutePage()
class BackupProviderPickerPage extends StatelessWidget {
  const BackupProviderPickerPage({
    super.key,
  });

  @override
  Widget build(final BuildContext context) => ResponsiveLayoutWithInfobox(
        topChild: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${'initializing.connect_to_server_provider'.tr()}Backblaze',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        primaryColumn: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CubitFormTextField(
              autofocus: true,
              formFieldCubit: context.read<BackblazeFormCubit>().keyId,
              textAlign: TextAlign.center,
              scrollPadding: const EdgeInsets.only(bottom: 70),
              decoration: const InputDecoration(
                hintText: 'KeyID',
              ),
            ),
            const SizedBox(height: 16),
            CubitFormTextField(
              formFieldCubit: context.read<BackblazeFormCubit>().applicationKey,
              textAlign: TextAlign.center,
              scrollPadding: const EdgeInsets.only(bottom: 70),
              decoration: const InputDecoration(
                hintText: 'Master Application Key',
              ),
            ),
            const SizedBox(height: 32),
            BrandButton.rised(
              onPressed: () => context.read<BackblazeFormCubit>().trySubmit(),
              text: 'basis.connect'.tr(),
            ),
            const SizedBox(height: 10),
            BrandButton.text(
              onPressed: () {
                context.read<SupportSystemCubit>().showArticle(
                      article: 'how_backblaze',
                      context: context,
                    );
                Scaffold.of(context).openEndDrawer();
              },
              title: 'initializing.how'.tr(),
            ),
          ],
        ),
      );
}
