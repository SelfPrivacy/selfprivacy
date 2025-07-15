import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/bloc/groups/groups_bloc.dart';
import 'package:selfprivacy/logic/bloc/services/services_bloc.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/cubit/forms/user/user_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/atoms/cards/filled_card.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/list_tile_on_surface_variant.dart';
import 'package:selfprivacy/ui/atoms/list_tiles/section_title.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/molecules/cards/radio_selection_card.dart';
import 'package:selfprivacy/ui/molecules/placeholders/empty_page_placeholder.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/ui_helpers.dart';

@RoutePage()
class NewUserPage extends StatelessWidget {
  const NewUserPage({this.user, super.key});

  final User? user;

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create:
        (final BuildContext context) => UserFormCubit(
          fieldFactory: FieldCubitFactory(context),
          initialUser: user,
        ),
    child: BlocConsumer<UserFormCubit, FormCubitState>(
      listener: (final BuildContext context, final FormCubitState state) async {
        final formCubit = context.read<UserFormCubit>();
        if (state.isSubmitted) {
          if (formCubit.userCreationMessage?.isNotEmpty ?? false) {
            getIt<NavigationService>().showSnackBar(
              formCubit.userCreationMessage!.tr(),
            );
          }
          await context.router.replace(
            UserDetailsRoute(login: formCubit.login.state.value),
          );
        }
        if (state.isErrorShown) {
          final errorMessage = formCubit.errorMessage;
          if (errorMessage.isNotEmpty) {
            getIt<NavigationService>().showSnackBar(errorMessage);
          }
        }
      },
      builder:
          (final BuildContext context, final FormCubitState state) =>
              NewUserScreen(state: state, user: user),
    ),
  );
}

class NewUserScreen extends StatelessWidget {
  const NewUserScreen({required this.state, this.user, super.key});
  final User? user;
  final FormCubitState state;

  @override
  Widget build(final BuildContext context) {
    final ServerInstallationState config =
        context.watch<ServerInstallationCubit>().state;

    final String domainName = UiHelpers.getDomainName(config);
    final formCubit = context.read<UserFormCubit>();

    return BrandHeroScreen(
      heroTitle: user != null ? 'users.edit_user'.tr() : 'users.new_user'.tr(),
      heroIcon: user != null ? null : Icons.person_add_outlined,
      heroIconWidget:
          user != null
              ? CircleAvatar(child: Text(user!.login[0].toUpperCase()))
              : null,
      children: [
        if (state.isErrorShown)
          Text(
            'users.username_rule'.tr(),
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        const Gap(8),
        IntrinsicHeight(
          child: CubitFormTextField(
            /// should make this read-only when the user is created
            autofocus: true,
            formFieldCubit: formCubit.login,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color:
                  user != null
                      ? Theme.of(context).colorScheme.onSurface.withAlpha(97)
                      : Theme.of(context).colorScheme.onSurface,
            ),
            decoration: InputDecoration(
              labelText: 'users.login'.tr(),
              suffixText: '@$domainName',
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            isDisabled: user != null,
          ),
        ),
        const Gap(24),
        IntrinsicHeight(
          child: CubitFormTextField(
            formFieldCubit: formCubit.displayName,
            decoration: InputDecoration(
              labelText: 'users.display_name'.tr(),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
        ),
        const Gap(16),
        GroupsSelector(formFieldCubit: formCubit.groups),
        const Gap(24),
        BrandButton.filled(
          onPressed: state.isSubmitting ? null : formCubit.trySubmit,
          title: user != null ? 'basis.apply'.tr() : 'basis.create'.tr(),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class GroupsSelector extends StatefulWidget {
  const GroupsSelector({required this.formFieldCubit, super.key});

  final FieldCubit<List<String>> formFieldCubit;

  @override
  State<GroupsSelector> createState() => _GroupsSelectorState();
}

class _GroupsSelectorState extends State<GroupsSelector> {
  String primaryGroup = 'sp.full_users';
  List<String> explicitGroups = [];

  late StreamSubscription subscription;

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
    setState(() {
      primaryGroup = getPrimaryGroupFromSelection(
        widget.formFieldCubit.state.value,
      );
      explicitGroups = getExplicitGroupsFromSelection(
        widget.formFieldCubit.state.value,
      );
    });
    subscription = widget.formFieldCubit.stream.listen(_cubitListener);
    super.initState();
  }

  void _cubitListener(final FieldCubitState<List<String>> state) {
    if (state is InitialFieldCubitState ||
        state is ExternalChangeFieldCubitState) {
      final groups = state.value;
      setState(() {
        primaryGroup =
            groups.contains('sp.admins')
                ? 'sp.admins'
                : groups.contains('sp.full_users')
                ? 'sp.full_users'
                : '';
        explicitGroups =
            groups
                .where(
                  (final String group) =>
                      group != 'sp.full_users' && group != 'sp.admins',
                )
                .toList();
      });
    }
  }

  @override
  void dispose() {
    unawaited(subscription.cancel());
    super.dispose();
  }

  @override
  Widget build(
    final BuildContext context,
  ) => BlocBuilder<FieldCubit, FieldCubitState>(
    bloc: widget.formFieldCubit,
    builder: (final context, final state) {
      final serviceGroups = context.watch<GroupsBloc>().state.serviceGroups;
      final unrecognizedGroups =
          context.watch<GroupsBloc>().state.unrecognizedGroups;
      final isGroupsEmpty = context.watch<GroupsBloc>().state.isEmpty;
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
              widget.formFieldCubit.setValue(getSelectedGroups());
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
                widget.formFieldCubit.setValue(getSelectedGroups());
              });
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
                widget.formFieldCubit.setValue(getSelectedGroups());
              });
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
                        leading:
                            service != null
                                ? SvgPicture.string(
                                  service.svgIcon,
                                  width: 24,
                                  height: 24,
                                  colorFilter: ColorFilter.mode(
                                    Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                    BlendMode.srcIn,
                                  ),
                                )
                                : Icon(
                                  Icons.question_mark_outlined,
                                  color:
                                      Theme.of(
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
                              widget.formFieldCubit.setValue(
                                getSelectedGroups(),
                              );
                            });
                          },
                        ),
                      ),
                      ...unrecognizedGroups.map(
                        (final String group) => Column(
                          children: [
                            CheckboxListTile.adaptive(
                              value: explicitGroups.contains(group),
                              title: Text(group),
                              onChanged: (final bool? value) {
                                setState(() {
                                  if (value ?? true) {
                                    explicitGroups.add(group);
                                  } else {
                                    explicitGroups.remove(group);
                                  }
                                  widget.formFieldCubit.setValue(
                                    getSelectedGroups(),
                                  );
                                });
                              },
                            ),
                          ],
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
    },
  );
}
