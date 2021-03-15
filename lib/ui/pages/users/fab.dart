part of 'users.dart';

class _Fab extends StatelessWidget {
  const _Fab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.0,
      height: 48.0,
      child: RawMaterialButton(
        fillColor: BrandColors.blue,
        shape: CircleBorder(),
        elevation: 0.0,
        highlightElevation: 2,
        child: Icon(
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
              return _NewUser();
            },
          );
        },
      ),
    );
  }
}
