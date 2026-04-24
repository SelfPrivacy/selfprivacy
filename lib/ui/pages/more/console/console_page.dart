import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
  ConsoleModel get console => getIt<ConsoleModel>();

  @override
  void initState() {
    super.initState();
    console.addListener(update);
  }

  @override
  void dispose() {
    console.removeListener(update);
    super.dispose();
  }

  void update() {
    /// listener update could come at any time, like when widget is already
    /// unmounted or during frame build, adding as postframe callback ensures
    /// that element is marked for rebuild
    WidgetsBinding.instance.addPostFrameCallback((final _) {
      if (mounted) {
        setState(() => {});
      }
    });
  }

  @override
  Widget build(final BuildContext context) {
    final List<ConsoleLog> logs = console.logs;

    return Scaffold(
      appBar: AppBar(
        title: Text('console_page.title'.tr()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              console.paused ? Icons.play_arrow_outlined : Icons.pause_outlined,
            ),
            onPressed: console.paused ? console.play : console.pause,
          ),
        ],
      ),
      body: Scrollbar(
        child:
            logs.isEmpty
                ? const _ConsoleViewEmpty()
                : _ConsoleViewLoaded(logs: logs),
      ),
    );
  }
}

class _ConsoleViewEmpty extends StatelessWidget {
  const _ConsoleViewEmpty();

  @override
  Widget build(final BuildContext context) => Align(
    alignment: Alignment.topCenter,
    child: Text('console_page.history_empty'.tr()),
  );
}

class _ConsoleViewLoaded extends StatelessWidget {
  const _ConsoleViewLoaded({required this.logs});

  final List<ConsoleLog> logs;

  @override
  Widget build(final BuildContext context) => ListView.separated(
    primary: true,
    padding: const EdgeInsets.symmetric(vertical: 8),
    itemCount: logs.length,
    itemBuilder: (final BuildContext context, final int index) {
      final log = logs[logs.length - 1 - index];

      return ConsoleLogItemWidget(key: ValueKey(log), log: log);
    },
    separatorBuilder: (final context, final _) => const Divider(),
  );
}
