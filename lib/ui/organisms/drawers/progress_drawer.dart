import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProgressDrawer extends StatelessWidget {
  /// A [Drawer] that displays a list of steps and the current step.
  /// Used in setup wizards. The [trailing] widget is displayed at the bottom.
  /// The [steps] are translated using [EasyLocalization].
  const ProgressDrawer({
    required this.steps,
    required this.currentStep,
    required this.constraints,
    required this.trailing,
    required this.title,
    super.key,
  });

  final List<String> steps;
  final int currentStep;
  final Widget trailing;
  final BoxConstraints constraints;
  final String title;

  @override
  Widget build(final BuildContext context) => SizedBox(
    width: 300,
    height: constraints.maxHeight,
    child: Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...steps.map((final step) {
                        final index = steps.indexOf(step);
                        return _StepIndicator(
                          title: step.tr(),
                          isCurrent: index == currentStep,
                          isCompleted: index < currentStep,
                        );
                      }),
                    ],
                  ),
                ),
              ),
              // const Spacer(),
              Padding(padding: const EdgeInsets.only(top: 8), child: trailing),
            ],
          ),
        ),
      ),
    ),
  );
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({
    required this.title,
    required this.isCompleted,
    required this.isCurrent,
  });

  final String title;
  final bool isCompleted;
  final bool isCurrent;

  @override
  Widget build(final BuildContext context) => ListTile(
    selected: isCurrent,
    leading:
        isCurrent
            ? const _StepCurrentIcon()
            : isCompleted
            ? const _StepCompletedIcon()
            : const _StepPendingIcon(),
    title: Text(title),
    textColor: Theme.of(context).colorScheme.onSurfaceVariant,
    iconColor: Theme.of(context).colorScheme.onSurfaceVariant,
  );
}

class _StepCompletedIcon extends StatelessWidget {
  const _StepCompletedIcon();

  @override
  Widget build(final BuildContext context) => const Icon(Icons.check_circle);
}

class _StepPendingIcon extends StatelessWidget {
  const _StepPendingIcon();

  @override
  Widget build(final BuildContext context) => const Icon(Icons.circle_outlined);
}

class _StepCurrentIcon extends StatelessWidget {
  const _StepCurrentIcon();

  @override
  Widget build(final BuildContext context) =>
      const Icon(Icons.build_circle_outlined);
}
