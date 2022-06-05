import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:selfprivacy/logic/cubit/jobs/jobs_cubit.dart';
import 'package:selfprivacy/ui/components/brand_bottom_sheet/brand_bottom_sheet.dart';
import 'package:selfprivacy/ui/components/jobs_content/jobs_content.dart';
import 'package:selfprivacy/ui/helpers/modals.dart';

class BrandFab extends StatefulWidget {
  const BrandFab({super.key});

  @override
  State<BrandFab> createState() => _BrandFabState();
}

class _BrandFabState extends State<BrandFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800),);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool wasPrevStateIsEmpty = true;

  @override
  Widget build(final BuildContext context) {
    _colorTween = ColorTween(
      begin: Theme.of(context).colorScheme.onPrimaryContainer,
      end: Theme.of(context).colorScheme.primary,
    ).animate(_animationController);

    return BlocListener<JobsCubit, JobsState>(
      listener: (final BuildContext context, final JobsState state) {
        if (wasPrevStateIsEmpty && state is! JobsStateEmpty) {
          wasPrevStateIsEmpty = false;
          _animationController.forward();
        } else if (!wasPrevStateIsEmpty && state is JobsStateEmpty) {
          wasPrevStateIsEmpty = true;

          _animationController.reverse();
        }
      },
      child: FloatingActionButton(
        onPressed: () {
          showBrandBottomSheet(
            context: context,
            builder: (final BuildContext context) => const BrandBottomSheet(
              isExpended: true,
              child: JobsContent(),
            ),
          );
        },
        child: AnimatedBuilder(
            animation: _colorTween,
            builder: (final BuildContext context, final Widget? child) {
              final double v = _animationController.value;
              final IconData icon = v > 0.5 ? Ionicons.flash : Ionicons.flash_outline;
              return Transform.scale(
                scale: 1 + (v < 0.5 ? v : 1 - v) * 2,
                child: Icon(
                  icon,
                  color: _colorTween.value,
                ),
              );
            },),
      ),
    );
  }
}
