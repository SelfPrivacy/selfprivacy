import 'dart:async';

import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void showPopUpDialog(final AlertDialog dialog) {
    final BuildContext? context = navigatorKey.currentContext;

    if (context == null) {
      showSnackBar(
        'Could not show dialog. This should not happen, please report this.',
      );
      return;
    }

    unawaited(showDialog(context: context, builder: (final _) => dialog));
  }

  void showSnackBar(final String text, {final SnackBarBehavior? behavior}) {
    final ScaffoldMessengerState state = scaffoldMessengerKey.currentState!;
    final SnackBar snack = SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 2),
      behavior: behavior,
    );
    state.showSnackBar(snack);
  }
}
