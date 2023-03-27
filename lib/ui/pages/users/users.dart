import 'package:auto_route/auto_route.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/forms/user/ssh_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/cubit/forms/user/user_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/users/users_cubit.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/components/brand_bottom_sheet/brand_bottom_sheet.dart';
import 'package:selfprivacy/ui/components/buttons/brand_button.dart';
import 'package:selfprivacy/ui/components/buttons/outlined_button.dart';
import 'package:selfprivacy/ui/components/brand_cards/filled_card.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/info_box/info_box.dart';
import 'package:selfprivacy/ui/components/list_tiles/list_tile_on_surface_variant.dart';
import 'package:selfprivacy/ui/components/not_ready_card/not_ready_card.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/breakpoints.dart';
import 'package:selfprivacy/utils/ui_helpers.dart';

part 'empty.dart';
part 'new_user.dart';
part 'user.dart';
part 'user_details.dart';
part 'reset_password.dart';

@RoutePage()
class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

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
          final List<User> users = state.users
              .where((final user) => user.type != UserType.root)
              .toList();
          // final List<User> users = [];
          users.sort(
            (final User a, final User b) =>
                a.login.toLowerCase().compareTo(b.login.toLowerCase()),
          );

          if (users.isEmpty) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<UsersCubit>().refresh();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _CouldNotLoadUsers(
                        text: 'users.could_not_fetch_description'.tr(),
                      ),
                      const SizedBox(height: 18),
                      BrandOutlinedButton(
                        onPressed: () {
                          context.read<UsersCubit>().refresh();
                        },
                        title: 'users.refresh_users'.tr(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              context.read<UsersCubit>().refresh();
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilledButton.tonal(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.person_add_outlined),
                        const SizedBox(width: 8),
                        Text('users.new_user'.tr()),
                      ],
                    ),
                    onPressed: () {
                      context.pushRoute(const NewUserRoute());
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder:
                        (final BuildContext context, final int index) => _User(
                      user: users[index],
                      isRootUser: users[index].type == UserType.primary,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: Breakpoints.small.isActive(context)
          ? PreferredSize(
              preferredSize: const Size.fromHeight(52),
              child: BrandHeader(
                title: 'basis.users'.tr(),
              ),
            )
          : null,
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
