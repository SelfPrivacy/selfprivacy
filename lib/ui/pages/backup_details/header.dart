part of 'backup_details.dart';

class _Header extends StatelessWidget {
  const _Header(
      {Key? key, required this.providerState, required this.refreshing})
      : super(key: key);

  final StateType providerState;
  final bool refreshing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconStatusMask(
          status: providerState,
          child: Icon(
            BrandIcons.save,
            size: 40,
            color: Colors.white,
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 2,
          ),
          child: IconButton(
            onPressed: refreshing
                ? null
                : () => {context.read<BackupsCubit>().updateBackups()},
            icon: const Icon(Icons.refresh_rounded),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 2,
          ),
          child: PopupMenuButton<_PopupMenuItemType>(
            enabled: providerState != StateType.uninitialized,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onSelected: (_PopupMenuItemType result) {
              switch (result) {
                case _PopupMenuItemType.reuploadKey:
                  context.read<BackupsCubit>().reuploadKey();
                  break;
                case _PopupMenuItemType.refetchBackups:
                  context.read<BackupsCubit>().forceUpdateBackups();
                  break;
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<_PopupMenuItemType>(
                value: _PopupMenuItemType.reuploadKey,
                child: Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('providers.backup.reuploadKey'.tr()),
                ),
              ),
              PopupMenuItem<_PopupMenuItemType>(
                value: _PopupMenuItemType.refetchBackups,
                child: Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text('providers.backup.refetchBackups'.tr()),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

enum _PopupMenuItemType { reuploadKey, refetchBackups }
