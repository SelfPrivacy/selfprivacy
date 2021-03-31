import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/text_themes.dart';
import 'package:selfprivacy/logic/cubit/app_settings/app_settings_cubit.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';

class ProgressBar extends StatefulWidget {
  ProgressBar({
    Key? key,
    required this.steps,
    required this.activeIndex,
  }) : super(key: key);

  final int activeIndex;

  final List<String> steps;

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    double progress = 1 / widget.steps.length * (widget.activeIndex + 0.3);
    var isDark = context.watch<AppSettingsCubit>().state.isDarkModeOn;
    var style = isDark ? progressTextStyleDark : progressTextStyleLight;

    var allSteps = widget.steps.asMap().map(
      (i, step) {
        var value = _stepTitle(index: i, style: style, step: step);
        return MapEntry(i, value);
      },
    ).values;

    List<Widget> odd = [];
    List<Widget> even = [];

    var i = 0;
    for (var step in allSteps) {
      if (i.isEven) {
        even.add(step);
      } else {
        odd.add(step);
      }
      i++;
    }

    odd.insert(
      0,
      SizedBox(
        width: 10,
      ),
    );
    even.add(
      SizedBox(
        width: 10,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BrandText.h2('Progress'),
        SizedBox(height: 10),
        Row(
          children: even,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        SizedBox(height: 7),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: BrandColors.gray4,
            borderRadius: BorderRadius.circular(5),
          ),
          child: LayoutBuilder(
            builder: (_, constraints) {
              return AnimatedContainer(
                width: constraints.maxWidth * progress,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: BrandColors.stableGradientColors,
                  ),
                ),
                duration: Duration(
                  milliseconds: 300,
                ),
              );
            },
          ),
        ),
        SizedBox(height: 5),
        Row(
          children: odd,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ],
    );
  }

  Container _stepTitle({
    required int index,
    TextStyle? style,
    String? step,
  }) {
    var isActive = index == widget.activeIndex;
    var checked = index < widget.activeIndex;

    style = isActive ? style!.copyWith(fontWeight: FontWeight.w700) : style;
    return Container(
      padding: EdgeInsets.only(left: 10),
      height: 20,
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          style: progressTextStyleLight,
          children: [
            checked
                ? WidgetSpan(
                    child: Padding(
                    padding: const EdgeInsets.only(bottom: 2, right: 2),
                    child: Icon(BrandIcons.check, size: 11),
                  ))
                : TextSpan(text: '${index + 1}.', style: style),
            TextSpan(text: step, style: style)
          ],
        ),
      ),
    );
  }
}
