import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/cubit/forms/user/reset_password_bloc.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/ui/atoms/buttons/brand_button.dart';
import 'package:selfprivacy/ui/atoms/buttons/outlined_button.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/molecules/info_box/info_box.dart';
import 'package:selfprivacy/ui/molecules/placeholders/empty_page_placeholder.dart';
import 'package:selfprivacy/ui/organisms/modals/qr_modal.dart';
import 'package:selfprivacy/utils/platform_adapter.dart';
import 'package:share_plus/share_plus.dart';

@RoutePage()
class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({required this.user, super.key});

  final User user;

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final BuildContext context) {
      final bloc = ResetPasswordBloc(user: user)
        ..add(const RequestNewPassword());
      return bloc;
    },
    child: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listener: (final BuildContext context, final ResetPasswordState state) {},
      builder: (final BuildContext context, final ResetPasswordState state) {
        late final Widget content;
        if (state is ResetPasswordUnsupported) {
          content = Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: EmptyPagePlaceholder(
                title: 'basis.error'.tr(),
                description: state.errorMessage,
                iconData: Icons.error_outline_outlined,
              ),
            ),
          );
        } else {
          if (state.passwordResetMessage.isNotEmpty) {
            content = Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          state.passwordResetLink!.toString(),
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const Gap(8),
                      IconButton(
                        icon: const Icon(Icons.copy),
                        color: Theme.of(context).colorScheme.onSurface,
                        onPressed: () async {
                          await PlatformAdapter.setClipboard(
                            state.passwordResetLink.toString(),
                          );
                          getIt<NavigationService>().showSnackBar(
                            'basis.copied_to_clipboard'.tr(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const Gap(16),
                BrandOutlinedButton(
                  onPressed: () async {
                    await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useRootNavigator: true,
                      builder:
                          (final BuildContext context) =>
                              DraggableScrollableSheet(
                                expand: false,
                                initialChildSize: 0.8,
                                maxChildSize: 0.9,
                                minChildSize: 0.4,
                                builder:
                                    (
                                      final BuildContext context,
                                      final ScrollController scrollController,
                                    ) => QrModal(
                                      title: 'users.password_reset_link'.tr(),
                                      qrData:
                                          state.passwordResetLink.toString(),
                                      scrollController: scrollController,
                                    ),
                              ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.qr_code_outlined,
                        size: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const Gap(8),
                      Text('basis.show_qr_code'.tr()),
                    ],
                  ),
                ),
                const Gap(8),
                BrandButton.filled(
                  onPressed: () async {
                    await SharePlus.instance.share(
                      ShareParams(uri: state.passwordResetLink),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.share_outlined,
                        size: 18,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      const Gap(8),
                      Text('basis.share_link'.tr()),
                    ],
                  ),
                ),
                const Gap(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: InfoBox(
                    text: 'users.password_reset_link_description'.tr(
                      namedArgs: {'username': user.login},
                    ),
                  ),
                ),
              ],
            );
          } else if (state.errorMessage.isNotEmpty) {
            content = Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: EmptyPagePlaceholder(
                  title: 'basis.error'.tr(),
                  description: state.errorMessage,
                  iconData: Icons.error_outline_outlined,
                ),
              ),
            );
          } else {
            // loading state
            content = Center(
              child: Column(
                children: [
                  const CircularProgressIndicator(),
                  const Gap(8),
                  Text('users.creating_password_reset_link'.tr()),
                ],
              ),
            );
          }
        }

        return BrandHeroScreen(
          hasBackButton: true,
          hasFlashButton: true,
          heroTitle: 'users.password_reset_link'.tr(),
          children: [content],
        );
      },
    ),
  );
}
