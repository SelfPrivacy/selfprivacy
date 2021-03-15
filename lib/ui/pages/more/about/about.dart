import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_theme.dart';
import 'package:selfprivacy/ui/components/brand_divider/brand_divider.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

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
            BrandText.h3('О проекте'),
            SizedBox(height: 10),
            BrandText.body1(
                'Всё больше организаций хотят владеть нашими данными'),
            SizedBox(height: 10),
            BrandText.body1(
                'А мы сами хотим распоряжаться своими данными на своем сервере.'),
            SizedBox(height: 20),
            BrandDivider(),
            SizedBox(height: 10),
            BrandText.h3('Миссия проекта'),
            SizedBox(height: 10),
            BrandText.body1(
                'Цифровая независимость и приватность доступная каждому'),
            SizedBox(height: 20),
            BrandDivider(),
            SizedBox(height: 10),
            BrandText.h3('Цель'),
            SizedBox(height: 10),
            BrandText.body1(
                'Развивать программу, которая позволит каждому создавать приватные сервисы для себя и своих близких'),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
