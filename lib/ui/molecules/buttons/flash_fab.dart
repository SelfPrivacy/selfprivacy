import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/utils/show_jobs_modal.dart';

class BrandFab extends StatefulWidget {
  const BrandFab({this.extended = false, this.elevation, super.key});

  final bool extended;
  final double? elevation;

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
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
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

    final icon = AnimatedBuilder(
      animation: _colorTween,
      builder: (final BuildContext context, final Widget? child) {
        final double v = _animationController.value;
        return Transform.scale(
          scale: 1 + (v < 0.5 ? v : 1 - v) * 2,
          child: Icon(
            v > 0.5 ? Ionicons.flash : Ionicons.flash_outline,
            color: _colorTween.value,
          ),
        );
      },
    );
    Future<void> openJobs() => showModalJobsSheet(context: context);

    return BlocListener<JobsCubit, JobsState>(
      listener: (final BuildContext context, final JobsState state) {
        if (wasPrevStateIsEmpty && state is! JobsStateEmpty) {
          wasPrevStateIsEmpty = false;
          unawaited(_animationController.forward());
        } else if (!wasPrevStateIsEmpty && state is JobsStateEmpty) {
          wasPrevStateIsEmpty = true;

          unawaited(_animationController.reverse());
        }
      },
      child: widget.extended
          ? FloatingActionButton.extended(
              onPressed: openJobs,
              tooltip: 'jobs.title'.tr(),
              elevation: widget.elevation,
              icon: icon,
              label: Text('jobs.title'.tr()),
            )
          : FloatingActionButton(
              onPressed: openJobs,
              tooltip: 'jobs.title'.tr(),
              elevation: widget.elevation,
              child: icon,
            ),
    );
  }
}
