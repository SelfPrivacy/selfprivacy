import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';

class NotReadyCard extends StatelessWidget {
  const NotReadyCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: BrandColors.gray6),
      child: Text(
        'Завершите настройку приложения используя "Мастер подключения" для продолжения работы',
        style: TextStyle(color: BrandColors.white),
      ),
    );
  }
}
