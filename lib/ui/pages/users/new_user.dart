import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/bloc/groups/groups_bloc.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/bloc/users/users_bloc.dart';
import 'package:selfprivacy/logic/cubit/app_readiness/app_readiness_cubit.dart';
import 'package:selfprivacy/logic/forms/user_form.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/atoms/cards/filled_card.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/list_tile_on_surface_variant.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/section_title.dart';
import 'package:selfprivacy/ui/forms/user_form_view.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/molecules/cards/radio_selection_card.dart';
import 'package:selfprivacy/ui/molecules/placeholders/empty_page_placeholder.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/ui_helpers.dart';

@RoutePage()
class NewUserPage extends StatefulWidget {
  const NewUserPage({this.user, super.key});

  final User? user;

  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  late final UserForm _userForm;

  @override
  void initState() {
    super.initState();
    final usersState = context.read<UsersBloc>().state;
    _userForm = UserForm(
      initialUser: widget.user,
      isLoginRegistered: usersState.isLoginRegistered,
      onSubmit: _submit,
    );
  }

  @override
  void dispose() {
    _userForm.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final domainName = context.watch<AppReadinessCubit>().state.domain;
    final user = widget.user;
    return BrandHeroScreen(
      heroTitle: user != null ? 'users.edit_user'.tr() : 'users.new_user'.tr(),
      heroIcon: user != null ? null : Icons.person_add_outlined,
      heroIconWidget: user != null
          ? CircleAvatar(child: Text(user.login[0].toUpperCase()))
          : null,
      children: [
        UserFormView(
          userForm: _userForm,
          domainName: domainName,
          groupsSelector: GroupsSelector(
            groupsControl:
                _userForm.form.control(UserForm.groupsControlName)
                    as FormControl<List<String>>,
          ),
        ),
      ],
    );
  }

  Future<void> _submit(final User user) async {
    final result = widget.user == null
        ? await getIt<ApiConnectionRepository>().createUser(user)
        : await getIt<ApiConnectionRepository>().updateUser(user);
    if (!mounted) {
      return;
    }

    final (success, message) = result;
    if (!success) {
      if (message.isNotEmpty) {
        getIt<NavigationService>().showSnackBar(message);
      }
      return;
    }

    if (message.isNotEmpty) {
      getIt<NavigationService>().showSnackBar(message.tr());
    }
    if (widget.user != null) {
      context.router.pop();
      return;
    }
    await context.router.replace(UserDetailsRoute(login: user.login));
  }
}

class GroupsSelector extends StatefulWidget {
  const GroupsSelector({required this.groupsControl, super.key});

  final FormControl<List<String>> groupsControl;

  @override
  State<GroupsSelector> createState() => _GroupsSelectorState();
}

class _GroupsSelectorState extends State<GroupsSelector> {
  String primaryGroup = 'sp.full_users';
  List<String> explicitGroups = [];

  List<String> getSelectedGroups() => [
    if (primaryGroup != '') primaryGroup,
    ...explicitGroups,
  ];

  String getPrimaryGroupFromSelection(final List<String> groups) =>
      groups.contains('sp.admins')
      ? 'sp.admins'
      : groups.contains('sp.full_users')
      ? 'sp.full_users'
      : '';

  List<String> getExplicitGroupsFromSelection(final List<String> groups) =>
      groups
          .where(
            (final String group) =>
                group != 'sp.full_users' && group != 'sp.admins',
          )
          .toList();

  @override
  void initState() {
    super.initState();
    final groups = widget.groupsControl.value ?? const <String>[];
    primaryGroup = getPrimaryGroupFromSelection(groups);
    explicitGroups = getExplicitGroupsFromSelection(groups);
  }

  void _updateControl() =>
      widget.groupsControl.updateValue(getSelectedGroups());

  @override
  Widget build(final BuildContext context) {
    final groupsState = context.watch<GroupsBloc>().state;
    final serviceGroups = groupsState.serviceGroups;
    final unrecognizedGroups = groupsState.unrecognizedGroups;
    final isGroupsEmpty = groupsState.isEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'users.group'.tr()),
        const Gap(8),
        RadioSelectionCard(
          isSelected: primaryGroup == '',
          title: 'users.groups_only_email_title'.tr(),
          subtitle: 'users.groups_only_email_subtitle'.tr(),
          onTap: () {
            setState(() {
              primaryGroup = '';
            });
            _updateControl();
          },
        ),
        const Gap(8),
        RadioSelectionCard(
          isSelected: primaryGroup == 'sp.full_users',
          title: 'users.groups_full_user_title'.tr(),
          subtitle: 'users.groups_full_user_subtitle'.tr(),
          onTap: () {
            setState(() {
              primaryGroup = 'sp.full_users';
            });
            _updateControl();
          },
        ),
        const Gap(16),
        RadioSelectionCard(
          isSelected: primaryGroup == 'sp.admins',
          title: 'users.groups_admin_title'.tr(),
          subtitle: 'users.groups_admin_subtitle'.tr(),
          onTap: () {
            setState(() {
              primaryGroup = 'sp.admins';
            });
            _updateControl();
          },
        ),
        const Gap(16),
        FilledCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTileOnSurfaceVariant(
                title: 'users.explicit_permissions_title'.tr(),
                subtitle: 'users.explicit_permissions_subtitle'.tr(),
              ),
              const Divider(height: 0),
              if (isGroupsEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: EmptyPagePlaceholder(
                      title: 'basis.network_error'.tr(),
                      iconData: Icons.error_outline_outlined,
                    ),
                  ),
                ),
              if (!isGroupsEmpty &&
                  (serviceGroups.isEmpty && unrecognizedGroups.isEmpty))
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: EmptyPagePlaceholder(
                      title: 'users.no_groups'.tr(),
                      description: 'users.no_groups_subtitle'.tr(),
                      iconData: Icons.group_remove_outlined,
                    ),
                  ),
                ),
              ...serviceGroups.entries.map((final serviceEntry) {
                final service = context
                    .watch<ServicesBloc>()
                    .state
                    .getServiceById(serviceEntry.key);
                return Column(
                  children: [
                    ListTile(
                      leading: service != null
                          ? SvgPicture.string(
                              service.svgIcon,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.onSurfaceVariant,
                                BlendMode.srcIn,
                              ),
                            )
                          : Icon(
                              Icons.question_mark_outlined,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                      title: Text(service?.displayName ?? serviceEntry.key),
                    ),
                    ...serviceEntry.value.entries.map(
                      (final permissionEntry) => CheckboxListTile.adaptive(
                        value: explicitGroups.contains(permissionEntry.value),
                        title: Text(
                          UiHelpers.permissionTitle(
                            permissionEntry.key,
                            serviceEntry.key,
                          ),
                        ),
                        onChanged: (final bool? value) {
                          setState(() {
                            if (value ?? true) {
                              explicitGroups.add(permissionEntry.value);
                            } else {
                              explicitGroups.remove(permissionEntry.value);
                            }
                          });
                          _updateControl();
                        },
                      ),
                    ),
                    ...unrecognizedGroups.map(
                      (final String group) => CheckboxListTile.adaptive(
                        value: explicitGroups.contains(group),
                        title: Text(group),
                        onChanged: (final bool? value) {
                          setState(() {
                            if (value ?? true) {
                              explicitGroups.add(group);
                            } else {
                              explicitGroups.remove(group);
                            }
                          });
                          _updateControl();
                        },
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
