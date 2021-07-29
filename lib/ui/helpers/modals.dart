import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<T?> showBrandBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) =>
    showCupertinoModalBottomSheet<T>(
      builder: builder,
      barrierColor: Colors.black45,
      context: context,
      shadow: BoxShadow(color: Colors.transparent),
      backgroundColor: Colors.transparent,
    );
