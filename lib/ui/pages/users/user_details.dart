part of 'users.dart';

class _UserDetails extends StatelessWidget {
  const _UserDetails({
    Key? key,
    this.user,
  }) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    var config = context.watch<AppConfigCubit>().state;

    var domainName = UiHelpers.getDomainName(config);

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
                          // case PopupMenuItemType.reset:
                          //   break;
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
                BrandText.small('users.account'.tr()),
                Container(
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child: BrandText.h4('${user!.login}@$domainName'),
                ),
                SizedBox(height: 14),
                BrandText.small('basis.password'.tr()),
                Container(
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child: BrandText.h4(user!.password),
                ),
                SizedBox(height: 24),
                BrandDivider(),
                SizedBox(height: 20),
                BrandButton.emptyWithIconText(
                  title: 'users.send_regisration_data'.tr(),
                  icon: Icon(BrandIcons.share),
                  onPressed: () {},
                ),
                SizedBox(height: 20),
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
