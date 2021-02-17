import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/config/text_themes.dart';
import 'package:selfprivacy/logic/cubit/forms/initializing/backblaze_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/initializing/cloudflare_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/initializing/domain_cloudflare.dart';
import 'package:selfprivacy/logic/cubit/forms/initializing/hetzner_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/initializing/root_user_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/logic/cubit/providers/providers_cubit.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_card/brand_card.dart';
import 'package:selfprivacy/ui/components/brand_modal_sheet/brand_modal_sheet.dart';
import 'package:selfprivacy/ui/components/brand_span_button/brand_span_button.dart';
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
      () => Container(child: Text('Everythigng is initialized'))
    ][cubit.state.progress]();
    return BlocListener<AppConfigCubit, AppConfigState>(
      listener: (context, state) {
        if (state.isFullyInitilized) {
          Navigator.of(context).pushReplacement(materialRoute(RootPage()));
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: ListView(
            children: [
              Padding(
                padding: brandPagePadding1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProgressBar(
                      steps: [
                        'Hetzner',
                        'CloudFlare',
                        'Backblaze',
                        'Domain',
                        'User',
                        'Server',
                        'Check1',
                        'Check2',
                        'Check3'
                      ],
                      activeIndex: cubit.state.progress,
                    ),
                  ],
                ),
              ),
              _addCard(
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: actualPage,
                ),
              ),
              BrandButton.text(
                  title:
                      cubit.state.isFullyInitilized ? 'Close' : 'Настрою потом',
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      materialRoute(RootPage()),
                      (predicate) => predicate == null,
                    );
                  }),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stepHetzner(AppConfigCubit initializingCubit) {
    return BlocProvider(
      create: (context) => HetznerFormCubit(initializingCubit),
      child: Builder(builder: (context) {
        var formCubit = context.watch<HetznerFormCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/logos/hetzner.png',
              width: 150,
            ),
            SizedBox(height: 10),
            BrandText.h2('Подключите сервер Hetzner'),
            SizedBox(height: 10),
            BrandText.body2(
                'Здесь будут жить наши данные и SelfPrivacy-сервисы'),
            Spacer(),
            CubitFormTextField(
              formFieldCubit: formCubit.apiKey,
              textAlign: TextAlign.center,
              scrollPadding: EdgeInsets.only(bottom: 70),
              decoration: InputDecoration(
                hintText: 'Hetzner API Token',
              ),
            ),
            Spacer(),
            BrandButton.rised(
              onPressed:
                  formCubit.state.isSubmitting ? null : formCubit.trySubmit,
              title: 'Подключить',
            ),
            SizedBox(height: 10),
            BrandButton.text(
              onPressed: () => _showModal(context, _HowHetzner()),
              title: 'Как получить API Token',
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
        var formCubit = context.watch<CloudFlareFormCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/logos/cloudflare.png',
              width: 150,
            ),
            SizedBox(height: 10),
            BrandText.h2('Подключите CloudFlare'),
            SizedBox(height: 10),
            BrandText.body2('Для управления DNS вашего домена'),
            Spacer(),
            CubitFormTextField(
              formFieldCubit: formCubit.apiKey,
              textAlign: TextAlign.center,
              scrollPadding: EdgeInsets.only(bottom: 70),
              decoration: InputDecoration(
                hintText: 'CloudFlare API Token',
              ),
            ),
            Spacer(),
            BrandButton.rised(
              onPressed:
                  formCubit.state.isSubmitting ? null : formCubit.trySubmit,
              title: 'Подключить',
            ),
            SizedBox(height: 10),
            BrandButton.text(
              onPressed: () {},
              title: 'Как получить API Token',
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
        var formCubit = context.watch<BackblazeFormCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/logos/backblaze.png',
              height: 50,
            ),
            SizedBox(height: 10),
            BrandText.h2('Подключите облачное хранилище Backblaze'),
            SizedBox(height: 10),
            Spacer(),
            CubitFormTextField(
              formFieldCubit: formCubit.keyId,
              textAlign: TextAlign.center,
              scrollPadding: EdgeInsets.only(bottom: 70),
              decoration: InputDecoration(
                hintText: 'KeyID',
              ),
            ),
            Spacer(),
            CubitFormTextField(
              formFieldCubit: formCubit.applicationKey,
              textAlign: TextAlign.center,
              scrollPadding: EdgeInsets.only(bottom: 70),
              decoration: InputDecoration(
                hintText: 'Master Application Key',
              ),
            ),
            Spacer(),
            BrandButton.rised(
              onPressed:
                  formCubit.state.isSubmitting ? null : formCubit.trySubmit,
              title: 'Подключить',
            ),
            SizedBox(height: 10),
            BrandButton.text(
              onPressed: () => _showModal(context, _HowHetzner()),
              title: 'Как получить API Token',
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
        var domainSetup = context.watch<DomainSetupCubit>();
        var state = domainSetup.state;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/logos/cloudflare.png',
              width: 150,
            ),
            SizedBox(height: 30),
            BrandText.h2('Домен'),
            SizedBox(height: 10),
            if (state is Empty)
              BrandText.body2('На данный момент подлюченных доменов нет'),
            if (state is Loading)
              BrandText.body2(
                state.type == LoadingTypes.loadingDomain
                    ? 'Загружаем список доменов'
                    : 'Сохранение..',
              ),
            if (state is MoreThenOne)
              BrandText.body2(
                'Найдено больше одного домена, для вашей безопастности, просим вам удалить не нужные домены',
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
                      onPressed: () => domainSetup.load(),
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
                onPressed: () => domainSetup.load(),
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
                onPressed: () => domainSetup.saveDomain(),
                title: 'Сохранить домен',
              ),
            ],
            SizedBox(height: 10),
            Spacer(),
            SizedBox(height: 10),
            BrandButton.text(
              onPressed: () => _showModal(context, _HowHetzner()),
              title: 'Как получить API Token',
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
        var formCubit = context.watch<RootUserFormCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            SizedBox(height: 10),
            CubitFormTextField(
              formFieldCubit: formCubit.userName,
              textAlign: TextAlign.center,
              scrollPadding: EdgeInsets.only(bottom: 70),
              decoration: InputDecoration(
                hintText: 'Никнейм',
              ),
            ),
            SizedBox(height: 10),
            BlocBuilder<FieldCubit<bool>, FieldCubitState<bool>>(
              cubit: formCubit.isVisible,
              builder: (context, state) {
                var isVisible = state.value;
                return CubitFormTextField(
                  obscureText: !isVisible,
                  formFieldCubit: formCubit.password,
                  textAlign: TextAlign.center,
                  scrollPadding: EdgeInsets.only(bottom: 70),
                  decoration: InputDecoration(
                    hintText: 'Пароль',
                    suffixIcon: IconButton(
                      icon: Icon(
                        isVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () => formCubit.isVisible.setValue(!isVisible),
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
              onPressed:
                  formCubit.state.isSubmitting ? null : formCubit.trySubmit,
              title: 'Подключить',
            ),
            SizedBox(height: 10),
            BrandButton.text(
              onPressed: () => _showModal(context, _HowHetzner()),
              title: 'Как получить API Token',
            ),
          ],
        );
      }),
    );
  }

  Widget _stepServer(AppConfigCubit appConfigCubit) {
    var isLoading = appConfigCubit.state.isLoading;
    return Builder(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(flex: 2),
          BrandText.h2('Создать сервер'),
          SizedBox(height: 10),
          BrandText.body2('Создать сервер'),
          Spacer(),
          BrandButton.rised(
            onPressed:
                isLoading ? null : appConfigCubit.createServerAndSetDnsRecords,
            title: isLoading ? 'loading' : 'Создать сервер',
          ),
          Spacer(flex: 2),
          BrandButton.text(
            onPressed: () => _showModal(context, _HowHetzner()),
            title: 'Что это значит?',
          ),
        ],
      );
    });
  }

  Widget _stepCheck(AppConfigCubit appConfigCubit) {
    assert(appConfigCubit.state is TimerState, 'wronge state');
    var state = appConfigCubit.state as TimerState;

    String text;
    if (state.isServerReseted) {
      text = 'Сервер презагружен, ждем последнюю проверку';
    } else if (state.isServerStarted) {
      text = 'Cервер запушен, сейчас он будет проверен и перезагружен';
    } else if (state.isServerCreated) {
      text = 'Cервер создан, идет проверка ДНС адресов и запуск сервера';
    }
    return Builder(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(flex: 2),
          SizedBox(height: 10),
          BrandText.body2(text),
          SizedBox(height: 10),
          if (!state.isLoading)
            Row(
              children: [
                BrandText.body2('До следующей проверки: '),
                BrandTimer(
                  startDateTime: state.timerStart,
                  duration: state.duration,
                )
              ],
            ),
          if (state.isLoading) BrandText.body2('Проверка'),
          Spacer(
            flex: 2,
          ),
          BrandButton.text(
            onPressed: () => _showModal(context, _HowHetzner()),
            title: 'Что это значит?',
          ),
        ],
      );
    });
  }

  Widget _addCard(Widget child) {
    return Container(
      height: 500,
      padding: brandPagePadding2,
      child: BrandCard(child: child),
    );
  }
}

class _HowHetzner extends StatelessWidget {
  const _HowHetzner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;

    return BrandModalSheet(
      child: Padding(
        padding: brandPagePadding2,
        child: Column(
          children: [
            SizedBox(height: 40),
            BrandText.h2('Как получить Hetzner API Token'),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '1 Переходим по ссылке ',
                    style: body1Style.copyWith(
                      color: isDark ? BrandColors.white : BrandColors.black,
                    ),
                  ),
                  BrandSpanButton.link(
                    text: 'hetzner.com',
                    urlString: 'https://hetzner.com',
                  ),
                  TextSpan(
                    text: '''
                                  
2 Заходим в созданный нами проект. Если такового - нет, значит создаём.

3 Наводим мышкой на боковую панель. Она должна раскрыться, показав нам пункты меню. Нас интересует последний — Security (с иконкой ключика).

4 Далее, в верхней части интерфейса видим примерно такой список: SSH Keys, API Tokens, Certificates, Members. Нам нужен API Tokens. Переходим по нему.

5 В правой части интерфейса, нас будет ожидать кнопка Generate API token. Если же вы используете мобильную версию сайта, в нижнем правом углу вы увидите красный плюсик. Нажимаем на эту кнопку.

6 В поле Description, даём нашему токену название (это может быть любое название, которые вам нравиться. Сути оно не меняет.

                                  ''',
                    style: body1Style.copyWith(
                      color: isDark ? BrandColors.white : BrandColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
