import 'package:auto_route/auto_route.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/bloc/outdated_server_checker/outdated_server_checker_bloc.dart';
import 'package:selfprivacy/logic/bloc/users/users_bloc.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/atoms/buttons/outlined_button.dart';
import 'package:selfprivacy/ui/atoms/icons/brand_icons.dart';
import 'package:selfprivacy/ui/molecules/cards/server_outdated_card.dart';
import 'package:selfprivacy/ui/molecules/list_items/user_list_item.dart';
import 'package:selfprivacy/ui/molecules/placeholders/empty_page_placeholder.dart';
import 'package:selfprivacy/ui/organisms/headers/brand_header.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/breakpoints.dart';

@RoutePage()
class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(final BuildContext context) {
    final bool isReady = context.watch<ServerInstallationCubit>().state
        is ServerInstallationFinished;
    Widget child;

    final OutdatedServerCheckerState outdatedServerCheckerState =
        context.watch<OutdatedServerCheckerBloc>().state;

    if (!isReady) {
      child = EmptyPagePlaceholder(
        showReadyCard: true,
        title: 'users.nobody_here'.tr(),
        description: 'basis.please_connect'.tr(),
        iconData: BrandIcons.users,
      );
    } else {
      child = BlocBuilder<UsersBloc, UsersState>(
        builder: (final BuildContext context, final UsersState state) {
          final users = state.orderedUsers;
          if (users.isEmpty) {
            if (state is UsersRefreshing) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<UsersBloc>().refresh();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EmptyPagePlaceholder(
                        title: 'users.could_not_fetch_users'.tr(),
                        description: 'users.could_not_fetch_description'.tr(),
                        iconData: BrandIcons.users,
                      ),
                      const SizedBox(height: 18),
                      BrandOutlinedButton(
                        onPressed: () {
                          context.read<UsersBloc>().refresh();
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
              await context.read<UsersBloc>().refresh();
            },
            child: Column(
              children: [
                if (outdatedServerCheckerState
                    is OutdatedServerCheckerOutdated) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ServerOutdatedCard(
                      requiredVersion:
                          outdatedServerCheckerState.requiredVersion.toString(),
                      currentVersion:
                          outdatedServerCheckerState.currentVersion.toString(),
                    ),
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder:
                        (final BuildContext context, final int index) =>
                            UserListItem(
                      user: users[index],
                      isPrimaryUser: users[index].type == UserType.primary,
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
          ? BrandHeader(
              title: 'basis.users'.tr(),
            )
          : null,
      body: child,
    );
  }
}
