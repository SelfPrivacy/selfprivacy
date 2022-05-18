part of 'server_details_screen.dart';

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
    required this.providerState,
    required this.tabController,
  }) : super(key: key);

  final StateType providerState;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconStatusMask(
          status: providerState,
          child: Icon(
            BrandIcons.server,
            size: 40,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 10),
        BrandText.h2('providers.server.card_title'.tr()),
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 2,
          ),
          child: PopupMenuButton<_PopupMenuItemType>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onSelected: (_PopupMenuItemType result) {
              switch (result) {
                case _PopupMenuItemType.setting:
                  tabController.animateTo(1);
                  break;
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<_PopupMenuItemType>(
                value: _PopupMenuItemType.setting,
                child: Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('basis.settings'.tr()),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

enum _PopupMenuItemType { setting }
