import 'package:auto_route/auto_route.dart';
import 'dart:collection';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/message.dart';
import 'package:selfprivacy/ui/components/list_tiles/log_list_tile.dart';

@RoutePage()
class ConsolePage extends StatefulWidget {
  const ConsolePage({super.key});

  @override
  State<ConsolePage> createState() => _ConsolePageState();
}

class _ConsolePageState extends State<ConsolePage> {
  @override
  void initState() {
    getIt.get<ConsoleModel>().addListener(update);

    super.initState();
  }

  @override
  void dispose() {
    getIt<ConsoleModel>().removeListener(update);
    super.dispose();
  }

  bool paused = false;

  void update() {
    if (!paused) {
      setState(() => {});
    }
  }

  @override
  Widget build(final BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('console_page.title'.tr()),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                icon: Icon(
                    paused ? Icons.play_arrow_outlined : Icons.pause_outlined),
                onPressed: () => setState(() => paused = !paused),
              ),
            ],
          ),
          body: FutureBuilder(
            future: getIt.allReady(),
            builder: (
              final BuildContext context,
              final AsyncSnapshot<void> snapshot,
            ) {
              if (snapshot.hasData) {
                final List<Message> messages =
                    getIt.get<ConsoleModel>().messages;

                return ListView(
                  reverse: true,
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 20),
                    ...UnmodifiableListView(
                      messages
                          .map((final message) => LogListItem(message: message))
                          .toList()
                          .reversed,
                    ),
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('console_page.waiting'.tr()),
                    const SizedBox(
                      height: 16,
                    ),
                    const CircularProgressIndicator(),
                  ],
                );
              }
            },
          ),
        ),
      );
}
