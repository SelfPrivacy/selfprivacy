import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/forms/user/ssh_form_cubit.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/ui/components/brand_bottom_sheet/brand_bottom_sheet.dart';
import 'package:selfprivacy/ui/components/brand_cards/brand_cards.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';

import '../../../config/brand_colors.dart';
import '../../../config/brand_theme.dart';
import '../../../logic/cubit/jobs/jobs_cubit.dart';
import '../../../logic/models/hive/user.dart';
import '../../components/brand_button/brand_button.dart';
import '../../components/brand_header/brand_header.dart';

part 'new_ssh_key.dart';

// Get user object as a parameter
class SshKeysPage extends StatefulWidget {
  final User user;

  const SshKeysPage({Key? key, required this.user}) : super(key: key);

  @override
  State<SshKeysPage> createState() => _SshKeysPageState();
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
                leading: const Icon(Icons.add_circle_outline_rounded),
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: _NewSshKey(widget.user));
                    },
                  );
                },
              ),
              const Divider(height: 0),
              // show a list of ListTiles with ssh keys
              // Clicking on one should delete it
              Column(
                children: widget.user.sshKeys.map((key) {
                  final publicKey =
                      key.split(' ').length > 1 ? key.split(' ')[1] : key;
                  final keyType = key.split(' ')[0];
                  final keyName = key.split(' ').length > 2
                      ? key.split(' ')[2]
                      : 'ssh.no_key_name'.tr();
                  return ListTile(
                      title: Text('$keyName ($keyType)'),
                      // do not overflow text
                      subtitle: Text(publicKey,
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('ssh.delete'.tr()),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text('ssh.delete_confirm_question'.tr()),
                                    Text('$keyName ($keyType)'),
                                    Text(publicKey),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('basis.cancel'.tr()),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'basis.delete'.tr(),
                                    style: const TextStyle(
                                      color: BrandColors.red1,
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<JobsCubit>().addJob(
                                        DeleteSSHKeyJob(
                                            user: widget.user, publicKey: key));
                                    Navigator.of(context)
                                      ..pop()
                                      ..pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
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
