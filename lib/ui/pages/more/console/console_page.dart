import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/console_log.dart';
import 'package:selfprivacy/ui/pages/more/console/console_log_item_widget.dart';

/// listing with 500 latest app operations.
@RoutePage()
class ConsolePage extends StatefulWidget {
  const ConsolePage({super.key});

  @override
  State<ConsolePage> createState() => _ConsolePageState();
}

class _ConsolePageState extends State<ConsolePage> {
  /// should freeze logs state to properly read logs
  bool paused = false;
  late final Future<void> future;

  @override
  void initState() {
    super.initState();

    future = getIt.allReady();
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
              onPressed: () => Navigator.of(context).maybePop(),
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
          body: SelectionArea(
            child: Scrollbar(
              child: FutureBuilder(
                future: future,
                builder: (
                  final BuildContext context,
                  final AsyncSnapshot<void> snapshot,
                ) {
                  if (snapshot.hasData) {
                    final List<ConsoleLog> logs =
                        getIt.get<ConsoleModel>().logs;

                    return logs.isEmpty
                        ? const _ConsoleViewEmpty()
                        : _ConsoleViewLoaded(
                            logs: logs,
                          );
                  }

                  return const _ConsoleViewLoading();
                },
              ),
            ),
          ),
        ),
      );
}

class _ConsoleViewLoading extends StatelessWidget {
  const _ConsoleViewLoading();

  @override
  Widget build(final BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('console_page.waiting'.tr()),
          const Gap(16),
          const Expanded(
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ],
      );
}

class _ConsoleViewEmpty extends StatelessWidget {
  const _ConsoleViewEmpty();

  @override
  Widget build(final BuildContext context) => Align(
        alignment: Alignment.topCenter,
        child: Text('console_page.historyEmpty'.tr()),
      );
}

class _ConsoleViewLoaded extends StatelessWidget {
  const _ConsoleViewLoaded({required this.logs});

  final List<ConsoleLog> logs;

  @override
  Widget build(final BuildContext context) => ListView.separated(
        primary: true,
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: logs.length,
        itemBuilder: (final BuildContext context, final int index) {
          final log = logs[logs.length - 1 - index];

          return ConsoleLogItemWidget(
            key: ValueKey(log),
            log: log,
          );
        },
        separatorBuilder: (final context, final _) => const Divider(),
      );
}
