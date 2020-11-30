import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_tab_bar/brand_tab_bar.dart';
import 'package:selfprivacy/ui/pages/servers/servers.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: TabBarView(
          controller: tabController,
          children: [
            ServersPage(),
            Text('services'),
            Text('users'),
            Text('more'),
          ],
        ),
        bottomNavigationBar: BottomTabBar(
          controller: tabController,
        ),
      ),
    );
  }
}
