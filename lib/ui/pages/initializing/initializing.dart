import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/config/text_themes.dart';
import 'package:selfprivacy/logic/cubit/providers/providers_cubit.dart';
import 'package:selfprivacy/logic/models/provider.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_card/brand_card.dart';
import 'package:selfprivacy/ui/components/brand_modal_sheet/brand_modal_sheet.dart';
import 'package:selfprivacy/ui/components/brand_span_button/brand_span_button.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';

class InitializingPage extends StatelessWidget {
  const InitializingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<ProvidersCubit>();
    var connected = cubit.state.connected;
    var uninitialized = cubit.state.uninitialized;
    return Scaffold(
      body: ListView(
        padding: brandPagePadding1,
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
                  text: 'selfprivacy.org/start',
                  urlString: 'https://selfprivacy.org/start',
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          ...connected.map((p) => getCard(context, p)).toList(),
          ...uninitialized.map((p) => getCard(context, p)).toList(),
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

  Widget getCard(BuildContext context, ProviderModel model) {
    var cubit = context.watch<ProvidersCubit>();
    if (model.state == StateType.stable) {
      return _MockSuccess(type: model.type);
    }
    switch (model.type) {
      case ProviderType.server:
        return BrandCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/logos/hetzner.png'),
              SizedBox(height: 10),
              BrandText.h2('1. Подключите сервер Hetzner'),
              SizedBox(height: 10),
              BrandText.body2(
                  'Здесь будут жить наши данные и SelfPrivacy-сервисы'),
              _MockForm(
                hintText: 'Hetzner API Token',
                length: 2,
                onPressed: () {
                  var provider = cubit.state.all
                      .firstWhere((p) => p.type == ProviderType.server);
                  cubit.connect(provider);
                },
              ),
              SizedBox(height: 20),
              BrandButton.text(
                onPressed: () => _showModal(context, _HowHetzner()),
                title: 'Как получить API Token',
              ),
            ],
          ),
        );
        break;
      case ProviderType.domain:
        return BrandCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/logos/namecheap.png'),
              SizedBox(height: 10),
              BrandText.h2('2. Настройте домен'),
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
                length: 2,
                onPressed: () {},
              ),
              SizedBox(height: 20),
              BrandButton.text(
                onPressed: () {},
                title: 'Как настроить DNS CloudFlare',
              ),
              SizedBox(height: 10),
              Image.asset('assets/images/logos/cloudflare.png'),
              SizedBox(height: 10),
              BrandText.h2('3. Подключите CloudFlare DNS'),
              SizedBox(height: 10),
              BrandText.body2('Для управления DNS вашего домена'),
              _MockForm(
                hintText: 'CloudFlare API Token',
                length: 2,
                onPressed: () {
                  var provider = cubit.state.all
                      .firstWhere((p) => p.type == ProviderType.domain);
                  cubit.connect(provider);
                },
              ),
              SizedBox(height: 20),
              BrandButton.text(
                onPressed: () {},
                title: 'Как получить API Token',
              ),
            ],
          ),
        );
        break;
      case ProviderType.backup:
        return BrandCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/logos/aws.png'),
              SizedBox(height: 10),
              BrandText.h2('4. Подключите Amazon AWS для бекапа'),
              SizedBox(height: 10),
              BrandText.body2(
                  'IaaS-провайдер, для бесплатного хранения резервных копии ваших данных в зашифрованном виде'),
              _MockForm(
                hintText: 'Amazon AWS Access Key',
                length: 2,
                onPressed: () {
                  var provider = cubit.state.all
                      .firstWhere((p) => p.type == ProviderType.backup);
                  cubit.connect(provider);
                },
              ),
              SizedBox(height: 20),
              BrandButton.text(
                onPressed: () {},
                title: 'Как получить API Token',
              ),
            ],
          ),
        );
    }

    return null;
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

class _MockSuccess extends StatelessWidget {
  const _MockSuccess({Key key, this.type}) : super(key: key);

  final ProviderType type;

  @override
  Widget build(BuildContext context) {
    String text;

    switch (type) {
      case ProviderType.server:
        text = '1. Cервер подключен';
        break;
      case ProviderType.domain:
        text = '2. Домен настроен';
        break;
      case ProviderType.backup:
        text = '3. Резервное копирование настроенно';
        break;
    }
    return BrandCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BrandText.h3(text),
          Icon(
            Icons.check,
            color: BrandColors.green1,
          ),
        ],
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
        SizedBox(height: 20),
        BrandButton.rised(
          onPressed: _valid ? onPressed : null,
          title: widget.submitButtonText,
        ),
      ],
    );
  }
}
