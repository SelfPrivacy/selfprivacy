import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/logic/cubit/jobs/jobs_cubit.dart';
import 'package:selfprivacy/ui/components/brand_bottom_sheet/brand_bottom_sheet.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/ui/components/jobs_content/jobs_content.dart';
import 'package:selfprivacy/ui/helpers/modals.dart';

part 'close.dart';
part 'flash.dart';

class PreStyledButtons {
  static Widget close({
    required final VoidCallback onPress,
  }) =>
      _CloseButton(onPress: onPress);

  static Widget flash() => _BrandFlashButton();
}
