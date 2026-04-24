import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/utils/named_font_weight.dart';

class BrandTimer extends StatefulWidget {
  const BrandTimer({
    required this.startDateTime,
    required this.duration,
    super.key,
  });

  final DateTime startDateTime;
  final Duration duration;

  @override
  State<BrandTimer> createState() => _BrandTimerState();
}

class _BrandTimerState extends State<BrandTimer> {
  String? _timeString;
  late Timer timer;

  @override
  void initState() {
    _timerStart();
    super.initState();
  }

  void _timerStart() {
    _timeString = differenceFromStart;
    timer = Timer.periodic(const Duration(seconds: 1), (final Timer t) {
      final Duration timePassed = DateTime.now().difference(
        widget.startDateTime,
      );
      if (timePassed > widget.duration) {
        t.cancel();
      } else {
        _getTime();
      }
    });
  }

  @override
  void didUpdateWidget(final BrandTimer oldWidget) {
    if (timer.isActive) {
      timer.cancel();
    }
    _timerStart();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(final BuildContext context) => Text(
    _timeString ?? '',
    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontWeight: NamedFontWeight.demiBold,
      color: Theme.of(context).colorScheme.onSurface,
    ),
  );

  void _getTime() {
    setState(() {
      _timeString = differenceFromStart;
    });
  }

  String get differenceFromStart =>
      _durationToString(DateTime.now().difference(widget.startDateTime));

  String _durationToString(final Duration duration) {
    final Duration timeLeft = widget.duration - duration;
    String twoDigits(final int n) => n.toString().padLeft(2, '0');
    final String twoDigitSeconds = twoDigits(timeLeft.inSeconds);

    return 'timer.sec'.tr(args: [twoDigitSeconds]);
  }

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
    }
    super.dispose();
  }
}
