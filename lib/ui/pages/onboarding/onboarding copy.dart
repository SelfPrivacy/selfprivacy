import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/config/text_themes.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_card/brand_card.dart';
import 'package:selfprivacy/ui/components/brand_modal_sheet/brand_modal_sheet.dart';
import 'package:selfprivacy/ui/components/brand_span_button/brand_span_button.dart';
import 'package:selfprivacy/utils/extensions/text_extension.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: brandPagePadding1,
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
          SizedBox(height: 50),
          BrandCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/logos/hetzner.png'),
                SizedBox(height: 10),
                Text('1. Подключите сервер Hetzner').h2,
                SizedBox(height: 10),
                Text('Здесь будут жить наши данные и SelfPrivacy-сервисы')
                    .body2,
                _MockForm(
                  hintText: 'Hetzner API Token',
                ),
                SizedBox(height: 20),
                BrandButton.text(
                  onPressed: () => _showModal(context, _HowHetzner()),
                  title: 'Как получить API Token',
                ),
              ],
            ),
          ),
          BrandCard(
            child: Column(
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
                  hintText: 'Домен, например, selfprivacy.org',
                  submitButtonText: 'Проверить DNS',
                ),
                SizedBox(height: 20),
                BrandButton.text(
                  onPressed: () {},
                  title: 'Как настроить DNS CloudFlare',
                ),
              ],
            ),
          ),
          BrandCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/logos/cloudflare.png'),
                SizedBox(height: 10),
                Text('3. Подключите CloudFlare DNS').h2,
                SizedBox(height: 10),
                Text('Для управления DNS вашего домена').body2,
                _MockForm(
                  hintText: 'CloudFlare API Token',
                ),
                SizedBox(height: 20),
                BrandButton.text(
                  onPressed: () {},
                  title: 'Как получить API Token',
                ),
              ],
            ),
          ),
          BrandCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/logos/aws.png'),
                SizedBox(height: 10),
                Text('4. Подключите Amazon AWS для бекапа').h2,
                SizedBox(height: 10),
                Text('IaaS-провайдер, для бесплатного хранения резервных копии ваших данных в зашифрованном виде')
                    .body2,
                _MockForm(
                  hintText: 'Amazon AWS Access Key',
                ),
                SizedBox(height: 20),
                BrandButton.text(
                  onPressed: () {},
                  title: 'Как получить API Token',
                ),
              ],
            ),
          )
        ],
      ),
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
}

class _HowHetzner extends StatelessWidget {
  const _HowHetzner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BrandModalSheet(
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
    );
  }
}

class _MockForm extends StatelessWidget {
  const _MockForm({
    Key key,
    @required this.hintText,
    this.submitButtonText = 'Подключить',
  }) : super(key: key);

  final String hintText;
  final String submitButtonText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        TextField(decoration: InputDecoration(hintText: hintText)),
        SizedBox(height: 20),
        BrandButton.rised(onPressed: () {}, title: submitButtonText),
      ],
    );
  }
}
