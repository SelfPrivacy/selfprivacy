import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/brand_tab_bar/brand_tab_bar.dart';
import 'package:selfprivacy/ui/pages/more/more.dart';
import 'package:selfprivacy/ui/pages/providers/providers.dart';
import 'package:selfprivacy/ui/pages/services/services.dart';
import 'package:selfprivacy/ui/pages/users/users.dart';

import 'package:selfprivacy/ui/components/pre_styled_buttons/flash_fab.dart';

class RootPage extends StatefulWidget {
  const RootPage({final super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with TickerProviderStateMixin {
  late TabController tabController;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      setState(() {
        tabController.index == 2
            ? _controller.forward()
            : _controller.reverse();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final bool isReady = context.watch<ServerInstallationCubit>().state
        is ServerInstallationFinished;

    return SafeArea(
      child: Provider<ChangeTab>(
        create: (final _) => ChangeTab(tabController.animateTo),
        child: Scaffold(
          body: TabBarView(
            controller: tabController,
            children: const [
              ProvidersPage(),
              ServicesPage(),
              UsersPage(),
              MorePage(),
            ],
          ),
          bottomNavigationBar: BrandTabBar(
            controller: tabController,
          ),
          floatingActionButton: isReady
              ? SizedBox(
                  height: 104 + 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ScaleTransition(
                        scale: _animation,
                        child: const AddUserFab(),
                      ),
                      const SizedBox(height: 16),
                      const BrandFab(),
                    ],
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class ChangeTab {
  ChangeTab(this.onPress);
  final ValueChanged<int> onPress;
}
