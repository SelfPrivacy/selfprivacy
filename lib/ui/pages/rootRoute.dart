import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/initializing/initializing_cubit.dart';
import 'package:selfprivacy/logic/cubit/providers/providers_cubit.dart';
import 'package:selfprivacy/ui/components/brand_tab_bar/brand_tab_bar.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';
import 'package:selfprivacy/ui/pages/more/more.dart';
import 'package:selfprivacy/ui/pages/providers/providers.dart';
import 'package:selfprivacy/ui/pages/services/services.dart';
import 'package:selfprivacy/ui/pages/users/users.dart';

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
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isUserFilled =
        context.watch<InitializingCubit>().state.isFullyInitilized;

    return SafeArea(
      child: Scaffold(
        body: TabBarView(
          controller: tabController,
          children: [
            ProvidersPage(),
            ServicesPage(),
            isUserFilled ? UsersPage() : _NotReady(),
            MorePage(),
          ],
        ),
        bottomNavigationBar: BrandTabBar(
          controller: tabController,
        ),
      ),
    );
  }
}

class _NotReady extends StatelessWidget {
  const _NotReady({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BrandText.h3('Not ready'),
          BrandText.body2('Finish providers initialization first'),
        ],
      ),
    );
  }
}
