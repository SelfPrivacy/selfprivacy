import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/ui/components/brand_divider/brand_divider.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/utils/extensions/text_extension.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: BrandHeader(title: 'О проекте', hasBackButton: true),
          preferredSize: Size.fromHeight(52),
        ),
        body: ListView(
          padding: brandPagePadding2,
          children: [
            BrandDivider(),
            SizedBox(height: 20),
            Text('О проекте').h3,
            SizedBox(height: 10),
            Text('Всё больше организаций хотят владеть нашими данными').body1,
            SizedBox(height: 10),
            Text('А мы сами хотим распоряжаться своими данными на своем сервере.')
                .body1,
            SizedBox(height: 20),
            BrandDivider(),
            SizedBox(height: 10),
            Text('Миссия проекта').h3,
            SizedBox(height: 10),
            Text('Цифровая независимость и приватность доступная каждому'),
            SizedBox(height: 20),
            BrandDivider(),
            SizedBox(height: 10),
            Text('Цель').h3,
            SizedBox(height: 10),
            Text(
                'Развивать программу, которая позволит каждому создавать приватные сервисы для себя и своих близких'),
            SizedBox(height: 10),
            Text(
                'Развивать программу, которая позволит каждому создавать приватные сервисы для себя и своих близких'),
          ],
        ),
      ),
    );
  }
}
