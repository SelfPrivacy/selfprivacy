part of 'users.dart';

class AddUserFab extends StatelessWidget {
  const AddUserFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      heroTag: 'new_user_fab',
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: const NewUser());
          },
        );
      },
      child: const Icon(Icons.person_add_outlined),
    );
  }
}
