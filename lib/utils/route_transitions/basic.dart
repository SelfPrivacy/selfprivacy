import 'package:flutter/material.dart';

Route materialRoute(Widget widget) => MaterialPageRoute(
      builder: (context) => widget,
    );

Route noAnimationRoute(Widget widget) => PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => widget,
    );
