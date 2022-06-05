import 'package:flutter/material.dart';

Route materialRoute(final Widget widget) => MaterialPageRoute(
      builder: (final BuildContext context) => widget,
    );

Route noAnimationRoute(final Widget widget) => PageRouteBuilder(
      pageBuilder: (
        final BuildContext context,
        final Animation<double> animation1,
        final Animation<double> animation2,
      ) =>
          widget,
    );
