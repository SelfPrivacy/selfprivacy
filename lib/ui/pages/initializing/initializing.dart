import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/config/text_themes.dart';
import 'package:selfprivacy/logic/cubit/forms/initializing/hetzner_form_cubit.dart';
import 'package:selfprivacy/logic/cubit/initializing/initializing_cubit.dart';
import 'package:selfprivacy/logic/cubit/providers/providers_cubit.dart';
import 'package:selfprivacy/logic/models/user.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_card/brand_card.dart';
import 'package:selfprivacy/ui/components/brand_modal_sheet/brand_modal_sheet.dart';
import 'package:selfprivacy/ui/components/brand_span_button/brand_span_button.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/components/progress_bar/progress_bar.dart';
import 'package:selfprivacy/ui/pages/rootRoute.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

class InitializingPage extends StatefulWidget {
  const InitializingPage({Key key}) : super(key: key);

  @override
  _InitializingPageState createState() => _InitializingPageState();
}

class _InitializingPageState extends State<InitializingPage> {
  PageController pageController = PageController(viewportFraction: 1);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<InitializingCubit>();

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: brandPagePadding1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BrandText.h4('Начало'),
                  BrandText.h1('SelfPrivacy'),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Для устойчивости и приватности требует много учёток. Полная инструкция на ',
                          style: body2Style,
                        ),
                        BrandSpanButton.link(
                          text:
                              'https://selfprivacy.org/posts/getting_started/',
                          urlString:
                              'https://selfprivacy.org/posts/getting_started/',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  ProgressBar(
                    steps: ['Server', 'DNS', 'Domain', 'User'],
                    // progress: cubit.state.progress,
                    activeIndex: cubit.state.progress,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Container(
              height: 500,
              child: PageView(
                // physics: NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  _addCard(_stepOne(cubit)),
                  _addCard(_stepTwo(cubit)),
                  _addCard(_stepThree(cubit)),
                  _addCard(_stepFour(cubit)),
                ],
              ),
            ),
            BrandButton.text(title: 'Настрою потом', onPressed: _goToMainPage),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _goToMainPage() {
    Navigator.of(context).pushAndRemoveUntil(
      materialRoute(RootPage()),
      (predicate) => predicate == null,
    );
  }

  Widget _stepOne(InitializingCubit initializingCubit) {
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
              keyboardType: TextInputType.number,
              scrollPadding: EdgeInsets.only(bottom: 70),
              decoration: InputDecoration(
                hintText: 'Hetzner API Token',
              ),
            ),
            SizedBox(height: 20),
            BrandButton.rised(
              onPressed:
                  formCubit.state.isSubmitting ? null : formCubit.trySubmit,
              title: 'Подключить',
            ),
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

  Widget _stepTwo(InitializingCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/images/logos/cloudflare.png'),
        BrandText.h2('Подключите CloudFlare DNS'),
        SizedBox(height: 10),
        BrandText.body2('Для управления DNS вашего домена'),
        Expanded(
          child: _MockForm(
            hintText: 'CloudFlare API Token',
            length: 64,
            onPressed: () {
              cubit.setCloudFlare('key');
              pageController.animateToPage(
                2,
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 200),
              );
            },
          ),
        ),
        SizedBox(height: 20),
        BrandButton.text(
          onPressed: () {},
          title: 'Как получить API Token',
        ),
      ],
    );
  }

  Widget _stepThree(InitializingCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        BrandText.h2('Введите домен:'),
        Expanded(
          child: _MockForm(
            hintText: 'домен',
            length: 10,
            onPressed: () {
              cubit.setDomain('domain');
              pageController.animateToPage(
                3,
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 200),
              );
            },
          ),
        ),
        SizedBox(height: 10),
        BrandButton.text(
          onPressed: () => _showModal(context, _HowHetzner()),
          title: 'Как получить API Token',
        ),
      ],
    );
  }

  Widget _stepFour(InitializingCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Expanded(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'нинейм',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'пароль',
                ),
              ),
              Spacer(),
              BrandButton.rised(
                onPressed: () {
                  cubit.setRootUser(
                    User(login: 'aa', password: 'bbb'),
                  );
                  _goToMainPage();
                },
                title: 'some text',
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        BrandButton.text(
          onPressed: () => _showModal(context, _HowHetzner()),
          title: 'Как получить API Token',
        ),
      ],
    );
  }

  Widget _addCard(Widget child) {
    return Padding(
      padding: brandPagePadding2,
      child: BrandCard(
        child: child,
      ),
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

// class _MockSuccess extends StatelessWidget {
//   const _MockSuccess({Key key, this.type}) : super(key: key);

//   final ProviderType type;

//   @override
//   Widget build(BuildContext context) {
//     String text;

//     switch (type) {
//       case ProviderType.server:
//         text = '1. Cервер подключен';
//         break;
//       case ProviderType.domain:
//         text = '2. Домен настроен';
//         break;
//       case ProviderType.backup:
//         text = '3. Резервное копирование настроенно';
//         break;
//     }
//     return BrandCard(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           BrandText.h3(text),
//           Icon(
//             Icons.check,
//             color: BrandColors.green1,
//           ),
//         ],
//       ),
//     );
//   }
// }

class _MockForm extends StatefulWidget {
  const _MockForm({
    Key key,
    @required this.hintText,
    this.submitButtonText = 'Подключить',
    @required this.onPressed,
    @required this.length,
  }) : super(key: key);

  final String hintText;
  final String submitButtonText;
  final int length;

  final VoidCallback onPressed;

  @override
  __MockFormState createState() => __MockFormState();
}

class __MockFormState extends State<_MockForm> {
  String text = '';
  bool _valid = true;
  bool _touched = false;

  onPressed() {
    if (text.length == widget.length) {
      setState(() {
        _touched = true;
        _valid = true;
        widget.onPressed();
      });
    } else {
      setState(() {
        _touched = true;
        _valid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),
        TextField(
          onChanged: (value) {
            if (_touched) {
              if (value.length == widget.length) {
                setState(() {
                  _valid = true;
                  text = value;
                });
              } else {
                setState(() {
                  _valid = false;
                  text = value;
                });
              }
            } else {
              setState(() {
                text = value;
              });
            }
          },
          decoration: InputDecoration(
            hintText: widget.hintText,
            errorText:
                _valid ? null : 'Длинна должна быть ${widget.length} символа',
          ),
        ),
        Spacer(),
        BrandButton.rised(
          onPressed: _valid ? onPressed : null,
          title: widget.submitButtonText,
        ),
      ],
    );
  }
}

// Widget getCard(BuildContext context, ProviderModel model) {
//   var cubit = context.watch<ProvidersCubit>();
//   if (model.state == StateType.stable) {
//     return _MockSuccess(type: model.type);
//   }
//   switch (model.type) {
//     case ProviderType.server:
//       return BrandCard(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.asset('assets/images/logos/hetzner.png'),
//             SizedBox(height: 10),
//             BrandText.h2('1. Подключите сервер Hetzner'),
//             SizedBox(height: 10),
//             BrandText.body2(
//                 'Здесь будут жить наши данные и SelfPrivacy-сервисы'),
//             _MockForm(
//               hintText: 'Hetzner API Token',
//               length: 48,
//               onPressed: () {
//                 var provider = cubit.state.all
//                     .firstWhere((p) => p.type == ProviderType.server);
//                 cubit.connect(provider);
//               },
//             ),
//             SizedBox(height: 20),
//             BrandButton.text(
//               onPressed: () => _showModal(context, _HowHetzner()),
//               title: 'Как получить API Token',
//             ),
//           ],
//         ),
//       );
//       break;
//     case ProviderType.domain:
//       return BrandCard(
//         isBlocked: true,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.asset('assets/images/logos/namecheap.png'),
//             SizedBox(height: 10),
//             BrandText.h2('2. Настройте домен'),
//             SizedBox(height: 10),
//             RichText(
//               text: TextSpan(
//                 children: [
//                   TextSpan(
//                     text: 'Зарегистрируйте домен в ',
//                     style: body2Style,
//                   ),
//                   BrandSpanButton.link(
//                     text: 'NameCheap',
//                     urlString: 'https://www.namecheap.com',
//                   ),
//                   TextSpan(
//                     text:
//                         ' или у любого другого регистратора. После этого настройте его на DNS-сервер CloudFlare',
//                     style: body2Style,
//                   ),
//                 ],
//               ),
//             ),
//             _MockForm(
//               hintText: 'Домен, например, selfprivacy.org',
//               submitButtonText: 'Проверить DNS',
//               length: 2,
//               onPressed: () {},
//             ),
//             SizedBox(height: 20),
//             BrandButton.text(
//               onPressed: () {},
//               title: 'Как настроить DNS CloudFlare',
//             ),
//             SizedBox(height: 10),
//             Image.asset('assets/images/logos/cloudflare.png'),
//             SizedBox(height: 10),
//           ],
//         ),
//       );
//       break;
//     case ProviderType.backup:
//       return BrandCard(
//         isBlocked: true,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.asset('assets/images/logos/aws.png'),
//             SizedBox(height: 10),
//             BrandText.h2('4. Подключите Amazon AWS для бекапа'),
//             SizedBox(height: 10),
//             BrandText.body2(
//                 'IaaS-провайдер, для бесплатного хранения резервных копии ваших данных в зашифрованном виде'),
//             _MockForm(
//               hintText: 'Amazon AWS Access Key',
//               length: 2,
//               onPressed: () {
//                 var provider = cubit.state.all
//                     .firstWhere((p) => p.type == ProviderType.backup);
//                 cubit.connect(provider);
//               },
//             ),
//             SizedBox(height: 20),
//             BrandButton.text(
//               onPressed: () {},
//               title: 'Как получить API Token',
//             ),
//           ],
//         ),
//       );
//   }

//   return null;
// }
