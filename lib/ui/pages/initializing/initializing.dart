import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/initializing/backblaze_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/initializing/cloudflare_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/initializing/domain_cloudflare.dart';
import 'package:selfprivacy/logic/cubit/forms/initializing/hetzner_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/initializing/root_user_form_cubit.dart';
import 'package:selfprivacy/ui/components/brand_bottom_sheet/brand_bottom_sheet.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_cards/brand_cards.dart';
import 'package:selfprivacy/ui/components/brand_md/brand_md.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/components/brand_timer/brand_timer.dart';
import 'package:selfprivacy/ui/components/progress_bar/progress_bar.dart';
import 'package:selfprivacy/ui/pages/rootRoute.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

class InitializingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<AppConfigCubit>();
    var actualPage = [
      () => _stepHetzner(cubit),
      () => _stepCloudflare(cubit),
      () => _stepBackblaze(cubit),
      () => _stepDomain(cubit),
      () => _stepUser(cubit),
      () => _stepServer(cubit),
      () => _stepCheck(cubit),
      () => _stepCheck(cubit),
      () => _stepCheck(cubit),
      () => Container(child: Center(child: Text('initializing.finish'.tr())))
    ][cubit.state.progress]();
    return BlocListener<AppConfigCubit, AppConfigState>(
      listener: (context, state) {
        if (cubit.state is AppConfigFinished) {
          Navigator.of(context).pushReplacement(materialRoute(RootPage()));
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: paddingH15V0.copyWith(top: 10, bottom: 10),
                  child: cubit.state.isFullyInitilized
                      ? SizedBox(
                          height: 80,
                        )
                      : ProgressBar(
                          steps: [
                            'Hetzner',
                            'CloudFlare',
                            'Backblaze',
                            'Domain',
                            'User',
                            'Server',
                            '✅ Check',
                          ],
                          activeIndex: cubit.state.porgressBar,
                        ),
                ),
                _addCard(
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: actualPage,
                  ),
                ),
                ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          MediaQuery.of(context).padding.bottom -
                          566,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: BrandButton.text(
                        title: cubit.state is AppConfigFinished
                            ? 'basis.close'.tr()
                            : 'basis.later'.tr(),
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            materialRoute(RootPage()),
                            (predicate) => false,
                          );
                        },
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _stepHetzner(AppConfigCubit initializingCubit) {
    return BlocProvider(
      create: (context) => HetznerFormCubit(initializingCubit),
      child: Builder(builder: (context) {
        var formCubitState = context.watch<HetznerFormCubit>().state;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/logos/hetzner.png',
              width: 150,
            ),
            SizedBox(height: 10),
            BrandText.h2('initializing.1'.tr()),
            SizedBox(height: 10),
            BrandText.body2('initializing.2'.tr()),
            Spacer(),
            CubitFormTextField(
              formFieldCubit: context.read<HetznerFormCubit>().apiKey,
              textAlign: TextAlign.center,
              scrollPadding: EdgeInsets.only(bottom: 70),
              decoration: InputDecoration(
                hintText: 'Hetzner API Token',
              ),
            ),
            Spacer(),
            BrandButton.rised(
              onPressed: formCubitState.isSubmitting
                  ? null
                  : () => context.read<HetznerFormCubit>().trySubmit(),
              text: 'basis.connect'.tr(),
            ),
            SizedBox(height: 10),
            BrandButton.text(
              onPressed: () =>
                  _showModal(context, _HowTo(fileName: 'how_hetzner')),
              title: 'initializing.how'.tr(),
            ),
          ],
        );
      }),
    );
  }

  void _showModal(BuildContext context, Widget widget) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return widget;
      },
    );
  }

  Widget _stepCloudflare(AppConfigCubit initializingCubit) {
    return BlocProvider(
      create: (context) => CloudFlareFormCubit(initializingCubit),
      child: Builder(builder: (context) {
        var formCubitState = context.watch<CloudFlareFormCubit>().state;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/logos/cloudflare.png',
              width: 150,
            ),
            SizedBox(height: 10),
            BrandText.h2('initializing.3'.tr()),
            SizedBox(height: 10),
            BrandText.body2('initializing.4'.tr()),
            Spacer(),
            CubitFormTextField(
              formFieldCubit: context.read<CloudFlareFormCubit>().apiKey,
              textAlign: TextAlign.center,
              scrollPadding: EdgeInsets.only(bottom: 70),
              decoration: InputDecoration(
                hintText: 'initializing.5'.tr(),
              ),
            ),
            Spacer(),
            BrandButton.rised(
              onPressed: formCubitState.isSubmitting
                  ? null
                  : () => context.read<CloudFlareFormCubit>().trySubmit(),
              text: 'basis.connect'.tr(),
            ),
            SizedBox(height: 10),
            BrandButton.text(
              onPressed: () => _showModal(
                  context,
                  _HowTo(
                    fileName: 'how_cloudflare',
                  )),
              title: 'initializing.how'.tr(),
            ),
          ],
        );
      }),
    );
  }

  Widget _stepBackblaze(AppConfigCubit initializingCubit) {
    return BlocProvider(
      create: (context) => BackblazeFormCubit(initializingCubit),
      child: Builder(builder: (context) {
        var formCubitState = context.watch<BackblazeFormCubit>().state;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/logos/backblaze.png',
              height: 50,
            ),
            SizedBox(height: 10),
            BrandText.h2('initializing.6'.tr()),
            SizedBox(height: 10),
            Spacer(),
            CubitFormTextField(
              formFieldCubit: context.read<BackblazeFormCubit>().keyId,
              textAlign: TextAlign.center,
              scrollPadding: EdgeInsets.only(bottom: 70),
              decoration: InputDecoration(
                hintText: 'KeyID',
              ),
            ),
            Spacer(),
            CubitFormTextField(
              formFieldCubit: context.read<BackblazeFormCubit>().applicationKey,
              textAlign: TextAlign.center,
              scrollPadding: EdgeInsets.only(bottom: 70),
              decoration: InputDecoration(
                hintText: 'Master Application Key',
              ),
            ),
            Spacer(),
            BrandButton.rised(
              onPressed: formCubitState.isSubmitting
                  ? null
                  : () => context.read<BackblazeFormCubit>().trySubmit(),
              text: 'basis.connect'.tr(),
            ),
            SizedBox(height: 10),
            BrandButton.text(
              onPressed: () => _showModal(
                  context,
                  _HowTo(
                    fileName: 'how_backblaze',
                  )),
              title: 'initializing.how'.tr(),
            ),
          ],
        );
      }),
    );
  }

  Widget _stepDomain(AppConfigCubit initializingCubit) {
    return BlocProvider(
      create: (context) => DomainSetupCubit(initializingCubit)..load(),
      child: Builder(builder: (context) {
        DomainSetupState state = context.watch<DomainSetupCubit>().state;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/logos/cloudflare.png',
              width: 150,
            ),
            SizedBox(height: 30),
            BrandText.h2('basis.domain'.tr()),
            SizedBox(height: 10),
            if (state is Empty) BrandText.body2('initializing.7'.tr()),
            if (state is Loading)
              BrandText.body2(
                state.type == LoadingTypes.loadingDomain
                    ? 'initializing.8'.tr()
                    : 'basis.saving'.tr(),
              ),
            if (state is MoreThenOne)
              BrandText.body2(
                'initializing.9'.tr(),
              ),
            if (state is Loaded) ...[
              SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: BrandText.h3(
                      '${state.domain}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 50,
                    child: BrandButton.rised(
                      onPressed: () => context.read<DomainSetupCubit>().load(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
            if (state is Empty) ...[
              SizedBox(height: 30),
              BrandButton.rised(
                onPressed: () => context.read<DomainSetupCubit>().load(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    BrandText.buttonTitleText('Обновить cписок'),
                  ],
                ),
              ),
            ],
            if (state is Loaded) ...[
              SizedBox(height: 30),
              BrandButton.rised(
                onPressed: () => context.read<DomainSetupCubit>().saveDomain(),
                text: 'initializing.10'.tr(),
              ),
            ],
            SizedBox(
              height: 10,
              width: double.infinity,
            ),
          ],
        );
      }),
    );
  }

  Widget _stepUser(AppConfigCubit initializingCubit) {
    return BlocProvider(
      create: (context) => RootUserFormCubit(initializingCubit),
      child: Builder(builder: (context) {
        var formCubitState = context.watch<RootUserFormCubit>().state;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BrandText.h2('initializing.22'.tr()),
            SizedBox(height: 10),
            BrandText.body2('initializing.23'.tr()),
            Spacer(),
            CubitFormTextField(
              formFieldCubit: context.read<RootUserFormCubit>().userName,
              textAlign: TextAlign.center,
              scrollPadding: EdgeInsets.only(bottom: 70),
              decoration: InputDecoration(
                hintText: 'basis.nickname'.tr(),
              ),
            ),
            SizedBox(height: 10),
            BlocBuilder<FieldCubit<bool>, FieldCubitState<bool>>(
              bloc: context.read<RootUserFormCubit>().isVisible,
              builder: (context, state) {
                var isVisible = state.value;
                return CubitFormTextField(
                  obscureText: !isVisible,
                  formFieldCubit: context.read<RootUserFormCubit>().password,
                  textAlign: TextAlign.center,
                  scrollPadding: EdgeInsets.only(bottom: 70),
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
                    suffixIconConstraints: BoxConstraints(minWidth: 60),
                    prefixIconConstraints: BoxConstraints(maxWidth: 85),
                    prefixIcon: Container(),
                  ),
                );
              },
            ),
            Spacer(),
            BrandButton.rised(
              onPressed: formCubitState.isSubmitting
                  ? null
                  : () => context.read<RootUserFormCubit>().trySubmit(),
              text: 'basis.connect'.tr(),
            ),
          ],
        );
      }),
    );
  }

  Widget _stepServer(AppConfigCubit appConfigCubit) {
    var isLoading = (appConfigCubit.state as AppConfigNotFinished).isLoading;
    return Builder(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(flex: 2),
          BrandText.h2('initializing.final'.tr()),
          SizedBox(height: 10),
          BrandText.body2('initializing.11'.tr()),
          Spacer(),
          BrandButton.rised(
            onPressed: isLoading
                ? null
                : () => appConfigCubit.createServerAndSetDnsRecords(),
            text: isLoading ? 'basis.loading'.tr() : 'initializing.11'.tr(),
          ),
        ],
      );
    });
  }

  Widget _stepCheck(AppConfigCubit appConfigCubit) {
    assert(appConfigCubit.state is AppConfigNotFinished, 'wrong state');
    var state = appConfigCubit.state as TimerState;
    late int doneCount;
    late String? text;
    if (state.isServerResetedSecondTime) {
      text = 'initializing.13'.tr();
      doneCount = 3;
    } else if (state.isServerResetedFirstTime) {
      text = 'initializing.21'.tr();
      doneCount = 2;
    } else if (state.isServerStarted) {
      text = 'initializing.14'.tr();
      doneCount = 1;
    } else if (state.isServerCreated) {
      text = 'initializing.15'.tr();
      doneCount = 0;
    }
    return Builder(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          BrandText.h4(
            'initializing.checks'.tr(args: [doneCount.toString(), "4"]),
          ),
          Spacer(flex: 2),
          SizedBox(height: 10),
          BrandText.body2(text),
          SizedBox(height: 10),
          if (doneCount == 0 && state.dnsMatches != null)
            Column(
              children: state.dnsMatches!.entries.map((entry) {
                var domain = entry.key;
                var isCorrect = entry.value;
                return Row(
                  children: [
                    if (isCorrect) Icon(Icons.check, color: Colors.green),
                    if (!isCorrect) Icon(Icons.schedule, color: Colors.amber),
                    SizedBox(width: 10),
                    Text(domain),
                  ],
                );
              }).toList(),
            ),
          SizedBox(height: 10),
          if (!state.isLoading)
            Row(
              children: [
                BrandText.body2('initializing.16'.tr()),
                BrandTimer(
                  startDateTime: state.timerStart!,
                  duration: state.duration!,
                )
              ],
            ),
          if (state.isLoading) BrandText.body2('initializing.17'.tr()),
        ],
      );
    });
  }

  Widget _addCard(Widget child) {
    return Container(
      height: 450,
      padding: paddingH15V0,
      child: BrandCards.big(child: child),
    );
  }
}

class _HowTo extends StatelessWidget {
  const _HowTo({
    Key? key,
    required this.fileName,
  }) : super(key: key);

  final String fileName;

  @override
  Widget build(BuildContext context) {
    return BrandBottomSheet(
      isExpended: true,
      child: Padding(
        padding: paddingH15V0,
        child: BrandMarkdown(
          fileName: fileName,
        ),
      ),
    );
  }
}
