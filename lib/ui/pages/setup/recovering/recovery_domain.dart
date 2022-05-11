import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';

class RecoveryDomain extends StatefulWidget {
  @override
  State<RecoveryDomain> createState() => _RecoveryDomainState();
}

class _RecoveryDomainState extends State<RecoveryDomain> {
  @override
  Widget build(BuildContext context) {
    return BrandHeroScreen(
      children: [
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "recovering.domain_recover_placeholder".tr(),
          ),
        ),
        SizedBox(height: 16),
        BrandButton.rised(
          onPressed: () {},
          text: "more.continue".tr(),
        ),
      ],
      heroTitle: "recovering.recovery_main_header".tr(),
      heroSubtitle: "recovering.domain_recovery_description".tr(),
      hasBackButton: true,
      hasFlashButton: false,
      heroIcon: Icons.link,
    );
  }
}

/*class RecoveryDomain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(52),
          child: BrandHeader(hasBackButton: true),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text(
              "recovering.recovery_main_header".tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 18),
            Text(
              "recovering.domain_recovery_description".tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 18),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "recovering.domain_recover_placeholder".tr(),
              ),
            ),
            SizedBox(height: 18),
            BrandButton.rised(
              onPressed: () {},
              text: "more.continue".tr(),
            ),
          ],
        ),
      ),
    );
  }
}*/