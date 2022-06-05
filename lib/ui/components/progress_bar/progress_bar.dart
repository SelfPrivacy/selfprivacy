import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/text_themes.dart';
import 'package:selfprivacy/logic/cubit/app_settings/app_settings_cubit.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({
    super.key,
    required this.steps,
    required this.activeIndex,
  });

  final int activeIndex;

  final List<String> steps;

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(final BuildContext context) {
    final double progress = 1 / widget.steps.length * (widget.activeIndex + 0.3);
    final bool isDark = context.watch<AppSettingsCubit>().state.isDarkModeOn;
    final TextStyle style = isDark ? progressTextStyleDark : progressTextStyleLight;

    final Iterable<Container> allSteps = widget.steps.asMap().map(
      (final i, final step) {
        final Container value = _stepTitle(index: i, style: style, step: step);
        return MapEntry(i, value);
      },
    ).values;

    final List<Widget> odd = [];
    final List<Widget> even = [];

    int i = 0;
    for (final Container step in allSteps) {
      if (i.isEven) {
        even.add(step);
      } else {
        odd.add(step);
      }
      i++;
    }

    odd.insert(
      0,
      const SizedBox(
        width: 10,
      ),
    );
    odd.add(
      const SizedBox(
        width: 20,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BrandText.h2('Progress'),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: even,
        ),
        const SizedBox(height: 7),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: BrandColors.gray4,
            borderRadius: BorderRadius.circular(5),
          ),
          child: LayoutBuilder(
            builder: (final _, final constraints) => AnimatedContainer(
                width: constraints.maxWidth * progress,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: BrandColors.stableGradientColors,
                  ),
                ),
                duration: const Duration(
                  milliseconds: 300,
                ),
              ),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: odd,
        ),
      ],
    );
  }

  Container _stepTitle({
    required final int index,
    TextStyle? style,
    final String? step,
  }) {
    final bool isActive = index == widget.activeIndex;
    final bool checked = index < widget.activeIndex;

    style = isActive ? style!.copyWith(fontWeight: FontWeight.w700) : style;
    return Container(
      padding: const EdgeInsets.only(left: 10),
      height: 20,
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          style: progressTextStyleLight,
          children: [
            if (checked) const WidgetSpan(
                    child: Padding(
                    padding: EdgeInsets.only(bottom: 2, right: 2),
                    child: Icon(BrandIcons.check, size: 11),
                  ),) else TextSpan(text: '${index + 1}.', style: style),
            TextSpan(text: step, style: style)
          ],
        ),
      ),
    );
  }
}
