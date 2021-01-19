import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/config/text_themes.dart';
import 'package:selfprivacy/logic/cubit/forms/initializing/cloudflare_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/forms/initializing/domain_form_cubit.dart';
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
      _stepHetzner(cubit),
      _stepCloudflare(cubit),
      _stepDomain(cubit),
      _stepUser(cubit),
      _stepServer(cubit),
      _stepCheck(cubit),
      Container(child: Text('Everythigng is initialized'))
    ][cubit.state.progress];
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProgressBar(
                      steps: [
                        'Hetzner',
                        'CloudFlare',
                        'Domain',
                        'User',
                        'Server',
                        'Check'
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
            Spacer(),
            Image.asset('assets/images/logos/hetzner.png'),
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
            Spacer(),
            Image.asset('assets/images/logos/cloudflare.png'),
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

  Widget _stepDomain(AppConfigCubit initializingCubit) {
    return BlocProvider(
      create: (context) => DomainFormCubit(initializingCubit),
      child: Builder(builder: (context) {
        var formCubit = context.watch<DomainFormCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            BrandText.h2('Введите домен:'),
            SizedBox(height: 10),
            CubitFormTextField(
              keyboardType: TextInputType.emailAddress,
              formFieldCubit: formCubit.domainName,
              textAlign: TextAlign.center,
              scrollPadding: EdgeInsets.only(bottom: 70),
              decoration: InputDecoration(
                hintText: 'Домен',
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
            CubitFormTextField(
              formFieldCubit: formCubit.password,
              textAlign: TextAlign.center,
              scrollPadding: EdgeInsets.only(bottom: 70),
              decoration: InputDecoration(
                hintText: 'Пароль',
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
            onPressed: isLoading ? null : appConfigCubit.createServer,
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
    var state = appConfigCubit.state;
    return Builder(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(flex: 2),
          SizedBox(height: 10),
          BrandText.body2(
            'Мы начали процесс инциализации сервера, раз в минуты мы будем проверять наличие DNS записей, как только они вступят в силу мы закончим инциализацию',
          ),
          SizedBox(height: 10),
          Row(
            children: [
              BrandText.body2('До следующей проверки: '),
              BrandTimer(
                startDateTime:
                    state.lastDnsCheckTime ?? state.server.createTime,
                duration: Duration(seconds: 10),
                callback: () {
                  appConfigCubit.checkDns();
                },
              )
            ],
          ),
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
                    style: body1Style,
                  ),
                  BrandSpanButton.link(
                    text: 'hetzner.com/sdfsdfsdfsdf',
                    urlString: 'https://hetzner.com/sdfsdfsdfsdf',
                  ),
                  TextSpan(
                    text: '''
                                  
2 Заходим в созданный нами проект. Если такового - нет, значит создаём.

3 Наводим мышкой на боковую панель. Она должна раскрыться, показав нам пункты меню. Нас интересует последний — Security (с иконкой ключика).

4 Далее, в верхней части интерфейса видим примерно такой список: SSH Keys, API Tokens, Certificates, Members. Нам нужен API Tokens. Переходим по нему.

5 В правой части интерфейса, нас будет ожидать кнопка Generate API token. Если же вы используете мобильную версию сайта, в нижнем правом углу вы увидите красный плюсик. Нажимаем на эту кнопку.

6 В поле Description, даём нашему токену название (это может быть любое название, которые вам нравиться. Сути оно не меняет.

                                  ''',
                    style: body1Style,
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
