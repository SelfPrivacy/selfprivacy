import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/config/text_themes.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/cubit/forms/user/user_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/jobs/jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/users/users_cubit.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/components/brand_bottom_sheet/brand_bottom_sheet.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_divider/brand_divider.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/components/not_ready_card/not_ready_card.dart';
import 'package:selfprivacy/ui/helpers/modals.dart';
import 'package:selfprivacy/ui/pages/ssh_keys/ssh_keys.dart';
import 'package:selfprivacy/utils/ui_helpers.dart';
import 'package:share_plus/share_plus.dart';

import 'package:selfprivacy/utils/route_transitions/basic.dart';

part 'empty.dart';
part 'new_user.dart';
part 'user.dart';
part 'user_details.dart';
part 'add_user_fab.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({final super.key});

  @override
  Widget build(final BuildContext context) {
    final bool isReady = context.watch<ServerInstallationCubit>().state
        is ServerInstallationFinished;
    Widget child;

    if (!isReady) {
      child = isNotReady();
    } else {
      child = BlocBuilder<UsersCubit, UsersState>(
        builder: (final BuildContext context, final UsersState state) {
          print('Rebuild users page');
          final primaryUser = state.primaryUser;
          final users = [primaryUser, ...state.users];

          return RefreshIndicator(
            onRefresh: () async {
              context.read<UsersCubit>().refresh();
            },
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (final BuildContext context, final int index) =>
                  _User(
                user: users[index],
                isRootUser: index == 0,
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(52),
        child: BrandHeader(
          title: 'basis.users'.tr(),
        ),
      ),
      body: child,
    );
  }

  Widget isNotReady() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: NotReadyCard(),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: _NoUsers(
                  text: 'users.not_ready'.tr(),
                ),
              ),
            ),
          )
        ],
      );
}
