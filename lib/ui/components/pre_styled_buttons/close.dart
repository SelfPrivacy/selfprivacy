part of 'pre_styled_buttons.dart';

class _CloseButton extends StatelessWidget {
  const _CloseButton({super.key, required this.onPress});

  final VoidCallback onPress;

  @override
  Widget build(final BuildContext context) => OutlinedButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BrandText.h4('basis.close'.tr()),
          const Icon(Icons.close),
        ],
      ),
    );
}
