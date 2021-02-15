import 'dart:async';

import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/utils/named_font_weight.dart';

class BrandTimer extends StatefulWidget {
  const BrandTimer({
    Key key,
    @required this.startDateTime,
    @required this.duration,
  }) : super(key: key);

  final DateTime startDateTime;
  final Duration duration;

  @override
  _BrandTimerState createState() => _BrandTimerState();
}

class _BrandTimerState extends State<BrandTimer> {
  String _timeString;
  Timer timer;

  @override
  void initState() {
    _timerStart();
    super.initState();
  }

  _timerStart() {
    _timeString = diffenceFromStart;
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      var timePassed = DateTime.now().difference(widget.startDateTime);
      if (timePassed > widget.duration) {
        t.cancel();
      } else {
        _getTime();
      }
    });
  }

  @override
  void didUpdateWidget(BrandTimer oldWidget) {
    if (timer.isActive) {
      timer.cancel();
    }
    _timerStart();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BrandText.medium(
      _timeString,
      style: TextStyle(
        fontWeight: NamedFontWeight.demiBold,
      ),
    );
  }

  void _getTime() {
    setState(() {
      _timeString = diffenceFromStart;
    });
  }

  String get diffenceFromStart =>
      _durationToString(DateTime.now().difference(widget.startDateTime));

  String _durationToString(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitSeconds =
        twoDigits(widget.duration.inSeconds - duration.inSeconds.remainder(60));

    return "$twoDigitSeconds cек";
  }

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
    }
    super.dispose();
  }
}
