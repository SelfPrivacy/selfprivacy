import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/backblaze_form_cubit.dart';
import 'package:selfprivacy/ui/components/buttons/brand_button.dart';
import 'package:selfprivacy/ui/layouts/responsive_layout_with_infobox.dart';

class BackupProviderPicker extends StatelessWidget {
  const BackupProviderPicker({
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
            const SizedBox(height: 32),
            BrandButton.rised(
              onPressed: () => context.read<BackblazeFormCubit>().trySubmit(),
              text: 'basis.connect'.tr(),
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
}
