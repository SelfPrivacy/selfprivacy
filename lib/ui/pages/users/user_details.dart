part of 'users.dart';

class _UserDetails extends StatelessWidget {
  const _UserDetails({
    Key? key,
    required this.user,
    required this.isRootUser,
  }) : super(key: key);

  final User user;
  final bool isRootUser;
  @override
  Widget build(BuildContext context) {
    var config = context.watch<ServerInstallationCubit>().state;

    var domainName = UiHelpers.getDomainName(config);

    return BrandBottomSheet(
      isExpended: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
                if (!isRootUser)
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
                            case PopupMenuItemType.delete:
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('basis.confirmation'.tr()),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text('users.delete_confirm_question'
                                              .tr()),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('basis.cancel'.tr()),
                                        onPressed: () {
                                          Navigator.of(context)..pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
                                          'basis.delete'.tr(),
                                          style: TextStyle(
                                            color: BrandColors.red1,
                                          ),
                                        ),
                                        onPressed: () {
                                          context.read<JobsCubit>().addJob(
                                              DeleteUserJob(user: user));
                                          Navigator.of(context)
                                            ..pop()
                                            ..pop();
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
                          // PopupMenuItem<PopupMenuItemType>(
                          //   value: PopupMenuItemType.reset,
                          //   child: Container(
                          //     padding: EdgeInsets.only(left: 5),
                          //     child: Text('users.reset_password'.tr()),
                          //   ),
                          // ),
                          PopupMenuItem<PopupMenuItemType>(
                            value: PopupMenuItemType.delete,
                            child: Container(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                'basis.delete'.tr(),
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
                    child: AutoSizeText(
                      user.login,
                      style: headline1Style,
                      softWrap: true,
                      minFontSize: 9,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: paddingH15V0.copyWith(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BrandText.small('users.account'.tr()),
                Container(
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child: BrandText.h4('${user.login}@$domainName'),
                ),
                if (user.password != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 14),
                      BrandText.small('basis.password'.tr()),
                      Container(
                        height: 40,
                        alignment: Alignment.centerLeft,
                        child: BrandText.h4(user.password),
                      ),
                    ],
                  ),
                SizedBox(height: 24),
                BrandDivider(),
                SizedBox(height: 20),
                ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .push(materialRoute(SshKeysPage(user: user)));
                    },
                    title: Text('ssh.title'.tr()),
                    subtitle: user.sshKeys.length > 0
                        ? Text('ssh.subtitle_with_keys'
                            .tr(args: [user.sshKeys.length.toString()]))
                        : Text('ssh.subtitle_without_keys'.tr()),
                    trailing: Icon(BrandIcons.key)),
                SizedBox(height: 20),
                ListTile(
                  onTap: () {
                    Share.share(
                        'login: ${user.login}, password: ${user.password}');
                  },
                  title: Text(
                    'users.send_registration_data'.tr(),
                  ),
                  trailing: Icon(BrandIcons.share),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

enum PopupMenuItemType {
  // reset,
  delete,
}
