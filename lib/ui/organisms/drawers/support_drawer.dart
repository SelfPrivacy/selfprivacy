import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/ui/atoms/markdown/brand_md.dart';

class SupportDrawer extends StatelessWidget {
  const SupportDrawer({super.key});

  @override
  Widget build(final BuildContext context) {
    final currentArticle =
        context.watch<SupportSystemCubit>().state.currentArticle;
    return Drawer(
      width: 440,
      child: SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 8),
                  const Icon(Icons.help_outline),
                  const SizedBox(width: 16),
                  Text(
                    'support.title'.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Scaffold.of(context).closeEndDrawer(),
                    icon: const Icon(Icons.chevron_right_outlined),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8),
                child: BrandMarkdown(fileName: currentArticle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
