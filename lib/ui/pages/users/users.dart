import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/users/users_cubit.dart';
import 'package:selfprivacy/logic/models/user.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_divider/brand_divider.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/brand_modal_sheet/brand_modal_sheet.dart';
import 'package:selfprivacy/utils/extensions/text_extension.dart';
import 'package:selfprivacy/utils/password_generator.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersCubit = context.watch<UsersCubit>();
    final users = usersCubit.state.users;
    return Scaffold(
      appBar: PreferredSize(
        child: BrandHeader(title: 'Пользователи'),
        preferredSize: Size.fromHeight(52),
      ),
      floatingActionButton: Container(
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
      ),
      body: ListView(
        children: [
          ...users.map((user) => _User(user: user)),
        ],
      ),
    );
  }
}

class _User extends StatelessWidget {
  const _User({Key key, this.user}) : super(key: key);

  final User user;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return _UserDetails(user: user);
          },
        );
      },
      child: Container(
        padding: brandPagePadding2,
        height: 48,
        child: Row(
          children: [
            Container(
              width: 17,
              height: 17,
              decoration: BoxDecoration(
                color: user.color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 20),
            Text(user.login).caption,
          ],
        ),
      ),
    );
  }
}

class _NewUser extends StatefulWidget {
  const _NewUser({Key key}) : super(key: key);

  @override
  __NewUserState createState() => __NewUserState();
}

class __NewUserState extends State<_NewUser> {
  var passController = TextEditingController(text: genPass());

  @override
  Widget build(BuildContext context) {
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

class _UserDetails extends StatelessWidget {
  const _UserDetails({
    Key key,
    this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return BrandModalSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: user.color,
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
                    child: PopupMenuButton<int>(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      // onSelected: (WhyFarther result) {
                      //   setState(() {
                      //     _selection = result;
                      //   });
                      // },
                      icon: Icon(Icons.more_vert),
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem<int>(
                          value: 1,
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Text('Сбросить пароль'),
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 2,
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              'Удалить',
                              style: TextStyle(color: BrandColors.red),
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
                  child: Text(
                    user.login,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ).h1,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: brandPagePadding2.copyWith(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Учетная запись').small,
                Container(
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child: Text('${user.login}@example.com').caption,
                ),
                SizedBox(height: 14),
                Text('Пароль').small,
                Container(
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child: Text(user.password).caption,
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
                    'Вам был создан доступ к сервисам с логином <login> и паролем <password> к сервисам: -  E-mail с адресом <username@domain.com> -  Менеджер паролей: <pass.domain.com> - Файловое облако: <cloud.mydomain.com> - Видеоконференция <meet.domain.com> - Git сервер <git.mydomain.com>'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
