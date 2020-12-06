import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/config/text_themes.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_card/brand_card.dart';
import 'package:selfprivacy/ui/components/brand_modal_sheet/brand_modal_sheet.dart';
import 'package:selfprivacy/ui/components/brand_span_button/brand_span_button.dart';
import 'package:selfprivacy/ui/pages/dots_indicator/dots_indicator.dart';
import 'package:selfprivacy/ui/pages/rootRoute.dart';
import 'package:selfprivacy/utils/extensions/text_extension.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController controller;
  var currentPage = 0;

  @override
  void initState() {
    controller = PageController(
      initialPage: 0,
    )..addListener(() {
        if (currentPage != controller.page.toInt()) {
          setState(() {
            currentPage = controller.page.toInt();
          });
        }
      });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var steps = getSteps();

    return SafeArea(
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: brandPagePadding1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Начало').caption,
                  Text('SelfPrivacy').h1,
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
                          text: 'selfprivacy.org/start',
                          urlString: 'https://selfprivacy.org/start',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 480,
              child: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                allowImplicitScrolling: false,
                controller: controller,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: brandPagePadding2,
                    child: steps[index],
                  );
                },
                itemCount: 4,
              ),
            ),
            DotsIndicator(
              activeIndex: currentPage,
              count: steps.length,
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  List<Widget> getSteps() => <Widget>[
        BrandCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/logos/hetzner.png'),
              SizedBox(height: 10),
              Text('1. Подключите сервер Hetzner').h2,
              SizedBox(height: 10),
              Text('Здесь будут жить наши данные и SelfPrivacy-сервисы').body2,
              _MockForm(
                onPressed: _nextPage,
                hintText: 'Hetzner API Token',
                length: 2,
              ),
              SizedBox(height: 20),
              Spacer(),
              BrandButton.text(
                onPressed: () => _showModal(context, _HowHetzner()),
                title: 'Как получить API Token',
              ),
            ],
          ),
        ),
        BrandCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/logos/namecheap.png'),
              SizedBox(height: 10),
              Text('2. Настройте домен ').h2,
              SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Зарегистрируйте домен в ',
                      style: body2Style,
                    ),
                    BrandSpanButton.link(
                      text: 'NameCheap',
                      urlString: 'https://www.namecheap.com',
                    ),
                    TextSpan(
                      text:
                          ' или у любого другого регистратора. После этого настройте его на DNS-сервер CloudFlare',
                      style: body2Style,
                    ),
                  ],
                ),
              ),
              _MockForm(
                onPressed: _nextPage,
                hintText: 'Домен, например, selfprivacy.org',
                submitButtonText: 'Проверить DNS',
                length: 2,
              ),
              Spacer(),
              BrandButton.text(
                onPressed: () {},
                title: 'Как настроить DNS CloudFlare',
              ),
            ],
          ),
        ),
        BrandCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/logos/cloudflare.png'),
              SizedBox(height: 10),
              Text('3. Подключите CloudFlare DNS').h2,
              SizedBox(height: 10),
              Text('Для управления DNS вашего домена').body2,
              _MockForm(
                onPressed: _nextPage,
                hintText: 'CloudFlare API Token',
                length: 2,
              ),
              Spacer(),
              BrandButton.text(
                onPressed: () {},
                title: 'Как получить API Token',
              ),
            ],
          ),
        ),
        BrandCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/logos/aws.png'),
              SizedBox(height: 10),
              Text('4. Подключите Amazon AWS для бекапа').h2,
              SizedBox(height: 10),
              Text('IaaS-провайдер, для бесплатного хранения резервных копии ваших данных в зашифрованном виде')
                  .body2,
              _MockForm(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(materialRoute(RootPage()));
                },
                hintText: 'Amazon AWS Access Key',
                length: 2,
              ),
              Spacer(),
              BrandButton.text(
                onPressed: () {},
                title: 'Как получить API Token',
              ),
            ],
          ),
        ),
      ];

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

  void _nextPage() => controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
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
            Text('Как получить Hetzner API Token').h2,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        TextField(
          onChanged: (value) => {
            setState(() {
              text = value;
            })
          },
          decoration: InputDecoration(hintText: widget.hintText),
        ),
        SizedBox(height: 20),
        BrandButton.rised(
          onPressed:
              text.length == widget.length ? widget.onPressed ?? () {} : null,
          title: widget.submitButtonText,
        ),
      ],
    );
  }
}
