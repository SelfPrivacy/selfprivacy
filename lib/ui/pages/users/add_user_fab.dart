part of 'users.dart';

class AddUserFab extends StatelessWidget {
  const AddUserFab({final super.key});

  @override
  Widget build(final BuildContext context) => FloatingActionButton.small(
        heroTag: 'new_user_fab',
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (final BuildContext context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: const NewUser(),
            ),
          );
        },
        child: const Icon(Icons.person_add_outlined),
      );
}
