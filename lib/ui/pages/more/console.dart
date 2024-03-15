import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
  bool paused = false;

  @override
  void initState() {
    super.initState();

    getIt<ConsoleModel>().addListener(update);
  }

  @override
  void dispose() {
    getIt<ConsoleModel>().removeListener(update);

    super.dispose();
  }

  void update() {
    /// listener update could come at any time, like when widget is already
    /// unmounted or during frame build, adding as postframe callback ensures
    /// that element is marked for rebuild
    WidgetsBinding.instance.addPostFrameCallback((final _) {
      if (!paused && mounted) {
        setState(() => {});
      }
    });
  }

  void togglePause() {
    paused ^= true;
    setState(() {});
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
                  paused ? Icons.play_arrow_outlined : Icons.pause_outlined,
                ),
                onPressed: togglePause,
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
                    const Gap(20),
                    ...messages.reversed.map(
                      (final message) => LogListItem(
                        key: ValueKey(message),
                        message: message,
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('console_page.waiting'.tr()),
                    const Gap(16),
                    const CircularProgressIndicator.adaptive(),
                  ],
                );
              }
            },
          ),
        ),
      );
}
