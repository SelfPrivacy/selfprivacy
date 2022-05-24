import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/logic/cubit/jobs/jobs_cubit.dart';
import 'package:selfprivacy/ui/components/brand_bottom_sheet/brand_bottom_sheet.dart';
import 'package:selfprivacy/ui/components/jobs_content/jobs_content.dart';
import 'package:selfprivacy/ui/helpers/modals.dart';

class BrandFab extends StatefulWidget {
  const BrandFab({Key? key}) : super(key: key);

  @override
  _BrandFabState createState() => _BrandFabState();
}

class _BrandFabState extends State<BrandFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _colorTween = ColorTween(
      begin: BrandColors.black,
      end: BrandColors.primary,
    ).animate(_animationController);

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  void _afterLayout(_) {
    if (Theme.of(context).brightness == Brightness.dark) {
      setState(() {
        _colorTween = ColorTween(
          begin: BrandColors.white,
          end: BrandColors.primary,
        ).animate(_animationController);
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool wasPrevStateIsEmpty = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<JobsCubit, JobsState>(
      listener: (context, state) {
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
            builder: (context) => const BrandBottomSheet(
              isExpended: true,
              child: JobsContent(),
            ),
          );
        },
        child: AnimatedBuilder(
            animation: _colorTween,
            builder: (context, child) {
              var v = _animationController.value;
              var icon = v > 0.5 ? Ionicons.flash : Ionicons.flash_outline;
              return Transform.scale(
                scale: 1 + (v < 0.5 ? v : 1 - v) * 2,
                child: Icon(
                  icon,
                  color: _colorTween.value,
                ),
              );
            }),
      ),
    );
  }
}
