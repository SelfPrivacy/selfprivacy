part of 'pre_styled_buttons.dart';

class _CloseButton extends StatelessWidget {
  const _CloseButton({Key? key, required this.onPress}) : super(key: key);

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BrandText.h4('basis.close'.tr()),
          Icon(Icons.close),
        ],
      ),
    );
  }
}
