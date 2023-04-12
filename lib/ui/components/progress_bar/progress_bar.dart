import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/app_settings/app_settings_cubit.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({
    required this.steps,
    required this.activeIndex,
    super.key,
  });

  final int activeIndex;

  final List<String> steps;

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(final BuildContext context) {
    final double progress =
        1 / widget.steps.length * (widget.activeIndex + 0.3);
    final bool isDark = context.watch<AppSettingsCubit>().state.isDarkModeOn;
    final TextStyle style =
        isDark ? progressTextStyleDark : progressTextStyleLight;

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
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: const Color(0xFFDDDDDD),
            borderRadius: BorderRadius.circular(5),
          ),
          child: LayoutBuilder(
            builder: (final _, final constraints) => AnimatedContainer(
              width: constraints.maxWidth * progress,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).colorScheme.surfaceVariant,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary
                  ],
                ),
              ),
              duration: const Duration(
                milliseconds: 300,
              ),
            ),
          ),
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
            TextSpan(text: '${index + 1}.', style: style),
            TextSpan(text: step, style: style)
          ],
        ),
      ),
    );
  }
}

const TextStyle progressTextStyleLight = TextStyle(
  fontSize: 11,
  color: Colors.black,
  height: 1.7,
);

final TextStyle progressTextStyleDark = progressTextStyleLight.copyWith(
  color: Colors.white,
);
