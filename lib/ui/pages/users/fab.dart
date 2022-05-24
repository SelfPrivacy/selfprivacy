part of 'users.dart';

class _Fab extends StatelessWidget {
  const _Fab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48.0,
      height: 48.0,
      child: RawMaterialButton(
        fillColor: BrandColors.blue,
        shape: const CircleBorder(),
        elevation: 0.0,
        highlightElevation: 2,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 34,
        ),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: _NewUser());
            },
          );
        },
      ),
    );
  }
}
