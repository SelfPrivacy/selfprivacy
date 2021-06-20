part of 'pre_styled_buttons.dart';

class _BrandFlashButton extends StatefulWidget {
  _BrandFlashButton({Key? key}) : super(key: key);

  @override
  _BrandFlashButtonState createState() => _BrandFlashButtonState();
}

class _BrandFlashButtonState extends State<_BrandFlashButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _colorTween = ColorTween(
      begin: BrandColors.black,
      end: BrandColors.primary,
    ).animate(_animationController);

    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(_afterLayout);
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

  late bool wasPrevStateIsEmpty;

  @override
  Widget build(BuildContext context) {
    var hasNoJobs = context.watch<JobsCubit>().state.isEmpty;
    wasPrevStateIsEmpty = hasNoJobs;
    var icon = hasNoJobs ? Ionicons.flash_outline : Ionicons.flash;

    return BlocListener<JobsCubit, JobsState>(
      listener: (context, state) {
        if (wasPrevStateIsEmpty && state.jobList.isNotEmpty) {
          wasPrevStateIsEmpty = false;
          _animationController.forward();
        } else if (!wasPrevStateIsEmpty && state.jobList.isEmpty) {
          _animationController.reverse();
        }
      },
      child: IconButton(
        onPressed: () {
          showBrandBottomSheet(
            context: context,
            builder: (context) => BrandBottomSheet(
              isExpended: true,
              child: JobsContent(),
            ),
          );
        },
        icon: AnimatedBuilder(
            animation: _colorTween,
            builder: (context, child) {
              var v = _animationController.value;
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
