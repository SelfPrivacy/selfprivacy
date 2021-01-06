part of 'users.dart';

class _NewUser extends StatefulWidget {
  const _NewUser({Key key}) : super(key: key);

  @override
  __NewUserState createState() => __NewUserState();
}

class __NewUserState extends State<_NewUser> {
  var passController = TextEditingController(text: genPass());

  @override
  Widget build(BuildContext context) {
    // final usersCubit = context.watch<UsersCubit>();

    return BrandModalSheet(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BrandHeader(title: 'Новый пользователь'),
            SizedBox(width: 14),
            Padding(
              padding: brandPagePadding2,
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Логин',
                      suffixText: '@example',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: passController,
                    decoration: InputDecoration(
                      alignLabelWithHint: false,
                      labelText: 'Пароль',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: IconButton(
                          icon: Icon(
                            BrandIcons.refresh,
                            color: BrandColors.blue,
                          ),
                          onPressed: () {
                            passController.value =
                                TextEditingValue(text: genPass());
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  BrandButton.rised(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    title: 'Создать',
                  ),
                  SizedBox(height: 40),
                  Text(
                      'Новый пользователь автоматически получит доступ ко всем сервисам. Ещё какое-то описание.'),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
