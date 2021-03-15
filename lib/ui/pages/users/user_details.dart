part of 'users.dart';

class _UserDetails extends StatelessWidget {
  const _UserDetails({
    Key? key,
    this.user,
  }) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return BrandModalSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: user!.color,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 2,
                    ),
                    child: PopupMenuButton<PopupMenuItemType>(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onSelected: (PopupMenuItemType result) {
                        switch (result) {
                          case PopupMenuItemType.reset:
                            break;
                          case PopupMenuItemType.delete:
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Подтверждение '),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text('удалить учетную запись?'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Отменить'),
                                      onPressed: () {
                                        Navigator.of(context)..pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text(
                                        'Удалить',
                                        style: TextStyle(
                                          color: BrandColors.red1,
                                        ),
                                      ),
                                      onPressed: () {
                                        context.read<UsersCubit>().remove(user);
                                        Navigator.of(context)..pop()..pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            break;
                        }
                      },
                      icon: Icon(Icons.more_vert),
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem<PopupMenuItemType>(
                          value: PopupMenuItemType.reset,
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Text('Сбросить пароль'),
                          ),
                        ),
                        PopupMenuItem<PopupMenuItemType>(
                          value: PopupMenuItemType.delete,
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              'Удалить',
                              style: TextStyle(color: BrandColors.red1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 15,
                    ),
                    child: BrandText.h1(
                      user!.login,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    )),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: brandPagePadding2.copyWith(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BrandText.small('Учетная запись'),
                Container(
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child: BrandText.h4('${user!.login}@example.com'),
                ),
                SizedBox(height: 14),
                BrandText.small('Пароль'),
                Container(
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child: BrandText.h4(user!.password),
                ),
                SizedBox(height: 24),
                BrandDivider(),
                SizedBox(height: 20),
                BrandButton.iconText(
                  title: 'Отправить реквизиты для входа',
                  icon: Icon(BrandIcons.share),
                  onPressed: () {},
                ),
                SizedBox(height: 20),
                BrandDivider(),
                SizedBox(height: 20),
                Text(
                    'Вам был создан доступ к сервисам с логином <login> и паролем <password> к сервисам:-  E-mail с адресом <username@domain.com>-  Менеджер паролей: <pass.domain.com>- Файловое облако: <cloud.mydomain.com>- Видеоконференция <meet.domain.com>- Git сервер <git.mydomain.com>'),
              ],
            ),
          )
        ],
      ),
    );
  }
}

enum PopupMenuItemType {
  reset,
  delete,
}
