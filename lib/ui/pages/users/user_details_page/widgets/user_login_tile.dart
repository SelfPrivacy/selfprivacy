import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/atoms/cards/filled_card.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/list_tile_on_surface_variant.dart';
import 'package:selfprivacy/utils/platform_adapter.dart';

class UserEmailLoginCard extends StatelessWidget {
  const UserEmailLoginCard({
    required this.user,
    required this.domainName,
    super.key,
  });

  final User user;
  final String domainName;

  @override
  Widget build(final BuildContext context) {
    final email = '${user.login}@$domainName';

    return FilledCard(
      child: Column(
        children: [
          ListTileOnSurfaceVariant(
            onTap: () async {
              await PlatformAdapter.setClipboard(email);
              getIt<NavigationService>().showSnackBar(
                'basis.copied_to_clipboard'.tr(),
              );
            },
            title: email,
            subtitle: 'users.email_login'.tr(),
            leadingIcon: Icons.alternate_email_outlined,
          ),
        ],
      ),
    );
  }
}
