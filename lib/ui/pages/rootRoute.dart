import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selfprivacy/ui/components/brand_tab_bar/brand_tab_bar.dart';
import 'package:selfprivacy/ui/pages/more/more.dart';
import 'package:selfprivacy/ui/pages/providers/providers.dart';
import 'package:selfprivacy/ui/pages/services/services.dart';
import 'package:selfprivacy/ui/pages/users/users.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Provider<ChangeTab>(
          create: (_) => ChangeTab(tabController.animateTo),
          child: TabBarView(
            controller: tabController,
            children: [
              ProvidersPage(),
              ServicesPage(),
              UsersPage(),
              MorePage(),
            ],
          ),
        ),
        bottomNavigationBar: BrandTabBar(
          controller: tabController,
        ),
      ),
    );
  }
}

class ChangeTab {
  final ValueChanged<int> onPress;

  ChangeTab(this.onPress);
}
