import 'package:cubit_form/cubit_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/pages/rootRoute.dart';
import 'package:selfprivacy/utils/route_transitions/basic.dart';

class RecoveryDomain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<AppConfigCubit>();
    return BlocListener<AppConfigCubit, AppConfigState>(
      listener: (context, state) {
        if (cubit.state is AppConfigFinished) {
          Navigator.of(context).pushReplacement(materialRoute(RootPage()));
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom -
                        566,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: BrandButton.text(
                      title: cubit.state is AppConfigFinished
                          ? 'basis.close'.tr()
                          : 'basis.later'.tr(),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          materialRoute(RootPage()),
                          (predicate) => false,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
