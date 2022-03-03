import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_cards/brand_cards.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';

import '../../../logic/models/user.dart';

// Get user object as a parameter
class SshKeysPage extends StatefulWidget {
  final User user;

  SshKeysPage({Key? key, required this.user}) : super(key: key);

  @override
  _SshKeysPageState createState() => _SshKeysPageState();
}

class _SshKeysPageState extends State<SshKeysPage> {
  @override
  Widget build(BuildContext context) {
    return BrandHeroScreen(
      heroTitle: 'ssh.title'.tr(),
      heroSubtitle: widget.user.login,
      heroIcon: BrandIcons.key,
      children: <Widget>[
        if (widget.user.login == 'root')
          Column(
            children: [
              // Show alert card if user is root
              BrandCards.outlined(
                child: ListTile(
                  leading: Icon(
                    Icons.warning_rounded,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  title: Text('ssh.root.title'.tr()),
                  subtitle: Text('ssh.root.subtitle'.tr()),
                ),
              )
            ],
          ),
        BrandCards.outlined(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'ssh.create'.tr(),
                  style: Theme.of(context).textTheme.headline6,
                ),
                leading: Icon(Icons.add_circle_outline_rounded),
              ),
              Divider(height: 0),
              // show a list of ListTiles with ssh keys
              // Clicking on one should delete it
              Column(
                children: widget.user.sshKeys.map((key) {
                  return ListTile(
                      title:
                          Text('${key.split(' ')[2]} (${key.split(' ')[0]})'),
                      // do not overflow text
                      subtitle: Text(key.split(' ')[1],
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      onTap: () {
                        // TODO: delete ssh key
                      });
                }).toList(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
