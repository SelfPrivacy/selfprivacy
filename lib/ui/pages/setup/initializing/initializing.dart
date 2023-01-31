import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/provider_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/factories/field_cubit_factory.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/backblaze_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/dns_provider_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/domain_setup_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/setup/initializing/root_user_form_cubit.dart';
import 'package:selfprivacy/ui/components/brand_bottom_sheet/brand_bottom_sheet.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_md/brand_md.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/components/brand_timer/brand_timer.dart';
import 'package:selfprivacy/ui/components/progress_bar/progress_bar.dart';
import 'package:selfprivacy/ui/pages/root_route.dart';
import 'package:selfprivacy/ui/pages/setup/initializing/server_provider_picker.dart';
import 'package:selfprivacy/ui/pages/setup/initializing/server_type_picker.dart';
import 'package:selfprivacy/ui/pages/setup/recovering/recovery_routing.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

class InitializingPage extends StatelessWidget {
  const InitializingPage({super.key});

  @override
  Widget build(final BuildContext context) {
    final cubit = context.watch<ServerInstallationCubit>();

    if (cubit.state is ServerInstallationRecovery) {
      return const RecoveryRouting();
    } else {
      Widget? actualInitializingPage;
      if (cubit.state is! ServerInstallationFinished) {
        actualInitializingPage = [
          () => _stepServerProviderToken(cubit),
          () => _stepServerType(cubit),
          () => _stepCloudflare(cubit),
          () => _stepBackblaze(cubit),
          () => _stepDomain(cubit),
          () => _stepUser(cubit),
          () => _stepServer(cubit),
          () => _stepCheck(cubit),
          () => _stepCheck(cubit),
          () => _stepCheck(cubit),
          () => _stepCheck(cubit)
        ][cubit.state.progress.index]();
      }

      return BlocListener<ServerInstallationCubit, ServerInstallationState>(
        listener: (final context, final state) {
          if (cubit.state is ServerInstallationFinished) {
            Navigator.of(context)
                .pushReplacement(materialRoute(const RootPage()));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            actions: [
              if (cubit.state is ServerInstallationFinished)
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(materialRoute(const RootPage()));
                  },
                )
            ],
            title: Text(
              'more_page.configuration_wizard'.tr(),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(28),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: ProgressBar(
                  steps: const [
                    'Hosting',
                    'Server Type',
                    'CloudFlare',
                    'Backblaze',
                    'Domain',
                    'User',
                    'Server',
                    'Installation',
                  ],
                  activeIndex: cubit.state.porgressBar,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0.0),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: actualInitializingPage,
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom -
                        566,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: BrandButton.text(
                          title: cubit.state is ServerInstallationFinished
                              ? 'basis.close'.tr()
                              : 'basis.later'.tr(),
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              materialRoute(const RootPage()),
                              (final predicate) => false,
                            );
                          },
                        ),
                      ),
                      if (cubit.state is ServerInstallationEmpty ||
                          cubit.state is ServerInstallationNotFinished)
                        Container(
                          alignment: Alignment.center,
                          child: BrandButton.text(
                            title: 'basis.connect_to_existing'.tr(),
                            onPressed: () {
                              Navigator.of(context).push(
                                materialRoute(
                                  const RecoveryRouting(),
                                ),
                              );
                            },
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _stepServerProviderToken(
    final ServerInstallationCubit serverInstallationCubit,
  ) =>
      BlocProvider(
        create: (final context) => ProviderFormCubit(serverInstallationCubit),
        child: Builder(
          builder: (final context) {
            final providerCubit = context.watch<ProviderFormCubit>();
            return ServerProviderPicker(
              formCubit: providerCubit,
              serverInstallationCubit: serverInstallationCubit,
            );
          },
        ),
      );

  Widget _stepServerType(
    final ServerInstallationCubit serverInstallationCubit,
  ) =>
      BlocProvider(
        create: (final context) => ProviderFormCubit(serverInstallationCubit),
        child: Builder(
          builder: (final context) => ServerTypePicker(
            serverInstallationCubit: serverInstallationCubit,
          ),
        ),
      );

  void _showModal(final BuildContext context, final Widget widget) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (final BuildContext context) => widget,
    );
  }

  Widget _stepCloudflare(final ServerInstallationCubit initializingCubit) =>
      BlocProvider(
        create: (final context) => DnsProviderFormCubit(initializingCubit),
        child: Builder(
          builder: (final context) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${'initializing.connect_to_server_provider'.tr()}Cloudflare',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                'initializing.manage_domain_dns'.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              CubitFormTextField(
                formFieldCubit: context.read<DnsProviderFormCubit>().apiKey,
                textAlign: TextAlign.center,
                scrollPadding: const EdgeInsets.only(bottom: 70),
                decoration: InputDecoration(
                  hintText: 'initializing.cloudflare_api_token'.tr(),
                ),
              ),
              const SizedBox(height: 32),
              BrandButton.rised(
                onPressed: () =>
                    context.read<DnsProviderFormCubit>().trySubmit(),
                text: 'basis.connect'.tr(),
              ),
              const SizedBox(height: 10),
              BrandButton.text(
                onPressed: () => _showModal(
                  context,
                  const _HowTo(
                    fileName: 'how_cloudflare',
                  ),
                ),
                title: 'initializing.how'.tr(),
              ),
            ],
          ),
        ),
      );

  Widget _stepBackblaze(final ServerInstallationCubit initializingCubit) =>
      BlocProvider(
        create: (final context) => BackblazeFormCubit(initializingCubit),
        child: Builder(
          builder: (final context) {
            final formCubitState = context.watch<BackblazeFormCubit>().state;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${'initializing.connect_to_server_provider'.tr()}Backblaze',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 32),
                CubitFormTextField(
                  formFieldCubit: context.read<BackblazeFormCubit>().keyId,
                  textAlign: TextAlign.center,
                  scrollPadding: const EdgeInsets.only(bottom: 70),
                  decoration: const InputDecoration(
                    hintText: 'KeyID',
                  ),
                ),
                const SizedBox(height: 16),
                CubitFormTextField(
                  formFieldCubit:
                      context.read<BackblazeFormCubit>().applicationKey,
                  textAlign: TextAlign.center,
                  scrollPadding: const EdgeInsets.only(bottom: 70),
                  decoration: const InputDecoration(
                    hintText: 'Master Application Key',
                  ),
                ),
                const SizedBox(height: 32),
                BrandButton.rised(
                  onPressed: formCubitState.isSubmitting
                      ? null
                      : () => context.read<BackblazeFormCubit>().trySubmit(),
                  text: 'basis.connect'.tr(),
                ),
                const SizedBox(height: 10),
                BrandButton.text(
                  onPressed: () => _showModal(
                    context,
                    const _HowTo(
                      fileName: 'how_backblaze',
                    ),
                  ),
                  title: 'initializing.how'.tr(),
                ),
              ],
            );
          },
        ),
      );

  Widget _stepDomain(final ServerInstallationCubit initializingCubit) =>
      BlocProvider(
        create: (final context) => DomainSetupCubit(initializingCubit)..load(),
        child: Builder(
          builder: (final context) {
            final DomainSetupState state =
                context.watch<DomainSetupCubit>().state;
            return SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'initializing.use_this_domain'.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'initializing.use_this_domain_text'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32),
                  if (state is Empty)
                    Text(
                      'initializing.no_connected_domains'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  if (state is Loading)
                    Text(
                      state.type == LoadingTypes.loadingDomain
                          ? 'initializing.loading_domain_list'.tr()
                          : 'basis.saving'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  if (state is MoreThenOne)
                    Text(
                      'initializing.found_more_domains'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  if (state is Loaded) ...[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          state.domain,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                  if (state is Empty) ...[
                    const SizedBox(height: 30),
                    BrandButton.rised(
                      onPressed: () => context.read<DomainSetupCubit>().load(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          BrandText.buttonTitleText('domain.update_list'.tr()),
                        ],
                      ),
                    ),
                  ],
                  if (state is Loaded) ...[
                    const SizedBox(height: 32),
                    BrandButton.rised(
                      onPressed: () =>
                          context.read<DomainSetupCubit>().saveDomain(),
                      text: 'initializing.save_domain'.tr(),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      );

  Widget _stepUser(final ServerInstallationCubit initializingCubit) =>
      BlocProvider(
        create: (final context) =>
            RootUserFormCubit(initializingCubit, FieldCubitFactory(context)),
        child: Builder(
          builder: (final context) {
            final formCubitState = context.watch<RootUserFormCubit>().state;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'initializing.create_master_account'.tr(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Text(
                  'initializing.enter_username_and_password'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                if (formCubitState.isErrorShown) const SizedBox(height: 16),
                if (formCubitState.isErrorShown)
                  Text(
                    'users.username_rule'.tr(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                const SizedBox(height: 32),
                CubitFormTextField(
                  formFieldCubit: context.read<RootUserFormCubit>().userName,
                  textAlign: TextAlign.center,
                  scrollPadding: const EdgeInsets.only(bottom: 70),
                  decoration: InputDecoration(
                    hintText: 'basis.username'.tr(),
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<FieldCubit<bool>, FieldCubitState<bool>>(
                  bloc: context.read<RootUserFormCubit>().isVisible,
                  builder: (final context, final state) {
                    final bool isVisible = state.value;
                    return CubitFormTextField(
                      obscureText: !isVisible,
                      formFieldCubit:
                          context.read<RootUserFormCubit>().password,
                      textAlign: TextAlign.center,
                      scrollPadding: const EdgeInsets.only(bottom: 70),
                      decoration: InputDecoration(
                        hintText: 'basis.password'.tr(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () => context
                              .read<RootUserFormCubit>()
                              .isVisible
                              .setValue(!isVisible),
                        ),
                        suffixIconConstraints:
                            const BoxConstraints(minWidth: 60),
                        prefixIconConstraints:
                            const BoxConstraints(maxWidth: 60),
                        prefixIcon: Container(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
                BrandButton.rised(
                  onPressed: formCubitState.isSubmitting
                      ? null
                      : () => context.read<RootUserFormCubit>().trySubmit(),
                  text: 'basis.connect'.tr(),
                ),
              ],
            );
          },
        ),
      );

  Widget _stepServer(final ServerInstallationCubit appConfigCubit) {
    final bool isLoading =
        (appConfigCubit.state as ServerInstallationNotFinished).isLoading;
    return Builder(
      builder: (final context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'initializing.final'.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Text(
            'initializing.create_server'.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 128),
          BrandButton.rised(
            onPressed:
                isLoading ? null : appConfigCubit.createServerAndSetDnsRecords,
            text: isLoading
                ? 'basis.loading'.tr()
                : 'initializing.create_server'.tr(),
          ),
        ],
      ),
    );
  }

  Widget _stepCheck(final ServerInstallationCubit appConfigCubit) {
    assert(
      appConfigCubit.state is ServerInstallationNotFinished,
      'wrong state',
    );
    final state = appConfigCubit.state as TimerState;
    late int doneCount;
    late String? text;
    if (state.isServerResetedSecondTime) {
      text = 'initializing.server_rebooted'.tr();
      doneCount = 3;
    } else if (state.isServerResetedFirstTime) {
      text = 'initializing.one_more_restart'.tr();
      doneCount = 2;
    } else if (state.isServerStarted) {
      text = 'initializing.server_started'.tr();
      doneCount = 1;
    } else if (state.isServerCreated) {
      text = 'initializing.server_created'.tr();
      doneCount = 0;
    }
    return Builder(
      builder: (final context) => SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'initializing.checks'.tr(args: [doneCount.toString(), '4']),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            if (text != null)
              Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            const SizedBox(height: 128),
            const SizedBox(height: 10),
            if (doneCount == 0 && state.dnsMatches != null)
              Column(
                children: state.dnsMatches!.entries.map((final entry) {
                  final String domain = entry.key;
                  final bool isCorrect = entry.value;
                  return Row(
                    children: [
                      if (isCorrect)
                        const Icon(Icons.check, color: Colors.green),
                      if (!isCorrect)
                        const Icon(Icons.schedule, color: Colors.amber),
                      const SizedBox(width: 10),
                      Text(domain),
                    ],
                  );
                }).toList(),
              ),
            const SizedBox(height: 10),
            if (!state.isLoading)
              Row(
                children: [
                  Text(
                    'initializing.until_the_next_check'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  BrandTimer(
                    startDateTime: state.timerStart!,
                    duration: state.duration!,
                  )
                ],
              ),
            if (state.isLoading)
              Text(
                'initializing.check'.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
          ],
        ),
      ),
    );
  }
}

class _HowTo extends StatelessWidget {
  const _HowTo({
    required this.fileName,
  });

  final String fileName;

  @override
  Widget build(final BuildContext context) => BrandBottomSheet(
        isExpended: true,
        child: Padding(
          padding: paddingH15V0,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              BrandMarkdown(
                fileName: fileName,
              ),
            ],
          ),
        ),
      );
}
