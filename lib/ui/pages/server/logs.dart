import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/bloc/server_logs/server_logs_bloc.dart';
import 'package:selfprivacy/logic/models/server_logs.dart';
import 'package:selfprivacy/ui/molecules/placeholders/empty_page_placeholder.dart';
import 'package:selfprivacy/utils/platform_adapter.dart';

@RoutePage()
class ServerLogsPage extends StatefulWidget {
  const ServerLogsPage({this.serviceId, this.unitId, super.key});

  final String? serviceId;
  final String? unitId;

  @override
  State<ServerLogsPage> createState() => _ServerLogsPageState();
}

class _ServerLogsPageState extends State<ServerLogsPage> {
  final ScrollController _scrollController = ScrollController();
  late ServerLogsBloc _serverLogsBloc;

  String? _selectedSystemdUnit;

  @override
  void initState() {
    super.initState();
    _serverLogsBloc = BlocProvider.of<ServerLogsBloc>(context);
    _scrollController.addListener(_onScroll);
    _serverLogsBloc.add(
      ServerLogsFetch(serviceId: widget.serviceId, unitId: widget.unitId),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _serverLogsBloc.add(ServerLogsDisconnect());
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      _serverLogsBloc.add(ServerLogsFetchMore());
    }
  }

  Widget _buildDrawer(final List<String> systemdUnits) => Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(child: Text('server.filter_by_systemd_unit'.tr())),
        // a tile to reset filter
        RadioListTile(
          title: Text('server.all_units'.tr()),
          value: null,
          groupValue: _selectedSystemdUnit,
          onChanged: (final value) {
            setState(() {
              _selectedSystemdUnit = value;
            });
          },
        ),
        for (final unit in systemdUnits.sorted())
          RadioListTile(
            title: Text(unit),
            value: unit,
            groupValue: _selectedSystemdUnit,
            onChanged: (final value) {
              setState(() {
                _selectedSystemdUnit = value;
              });
            },
          ),
      ],
    ),
  );

  @override
  Widget build(final BuildContext context) {
    const Key centerKey = ValueKey<String>('server-logs-center-key');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.serviceId == null
              ? 'server.logs'.tr()
              : 'service_page.logs'.tr(),
        ),
      ),
      endDrawer: BlocBuilder<ServerLogsBloc, ServerLogsState>(
        builder: (final context, final state) {
          if (state is ServerLogsLoaded) {
            return _buildDrawer(state.systemdUnits);
          }
          // Return an empty drawer if the state is not loaded
          return const Drawer(child: SizedBox());
        },
      ),
      body: BlocBuilder<ServerLogsBloc, ServerLogsState>(
        builder: (final context, final state) {
          final isLoadingMore = state is ServerLogsLoaded && state.loadingMore;
          if (state is ServerLogsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ServerLogsLoaded) {
            final List<ServerLogEntry> filteredNewLogs =
                _selectedSystemdUnit == null
                    ? state.newEntries
                    : state.newEntriesForUnit(_selectedSystemdUnit!);
            final List<ServerLogEntry> filteredOldLogs =
                _selectedSystemdUnit == null
                    ? state.oldEntries
                    : state.oldEntriesForUnit(_selectedSystemdUnit!);
            if (filteredOldLogs.isEmpty && filteredNewLogs.isEmpty) {
              return Center(
                child: EmptyPagePlaceholder(
                  title: 'server.logs_empty'.tr(),
                  iconData: Icons.info_outline,
                ),
              );
            }
            return CustomScrollView(
              center: centerKey,
              controller: _scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate((
                    final context,
                    final index,
                  ) {
                    final logEntry =
                        filteredNewLogs[(filteredNewLogs.length - 1) - index];
                    return LogEntryWidget(
                      logEntry: logEntry,
                      key: ValueKey(logEntry.cursor),
                    );
                  }, childCount: filteredNewLogs.length),
                ),
                SliverList(
                  key: centerKey,
                  delegate: SliverChildBuilderDelegate(
                    (final context, final index) {
                      if (isLoadingMore && index == filteredOldLogs.length) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final logEntry = filteredOldLogs[index];
                      return LogEntryWidget(
                        logEntry: logEntry,
                        key: ValueKey(logEntry.cursor),
                      );
                    },
                    childCount:
                        filteredOldLogs.length + (isLoadingMore ? 1 : 0),
                  ),
                ),
                if (isLoadingMore)
                  const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ],
            );
          } else if (state is ServerLogsError) {
            return Center(
              child: EmptyPagePlaceholder(
                title: 'basis.error'.tr(),
                iconData: Icons.error_outline,
                description: state.error.toString(),
              ),
            );
          }
          return Center(child: Text('server.logs_empty'.tr()));
        },
      ),
    );
  }
}

class LogEntryWidget extends StatelessWidget {
  const LogEntryWidget({required this.logEntry, super.key});

  final ServerLogEntry logEntry;

  @override
  Widget build(final BuildContext context) {
    final Color color =
        logEntry.priority == 4
            ? Theme.of(context).colorScheme.primary
            : logEntry.priority != null && logEntry.priority! <= 3
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListTile(
        dense: true,
        title: Text.rich(
          TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text: '${logEntry.localTimeString}: ',
                style: TextStyle(
                  fontFeatures: const [FontFeature.tabularFigures()],
                  color: color,
                ),
              ),
              TextSpan(
                text: logEntry.systemdUnit,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
        ),
        subtitle: Text(
          logEntry.message,
          overflow: TextOverflow.ellipsis,
          maxLines: 6,
        ),
        onTap:
            () => showDialog(
              context: context,
              builder:
                  (final BuildContext context) =>
                      ServerLogEntryDialog(log: logEntry),
            ),
      ),
    );
  }
}

/// dialog with detailed log content
class ServerLogEntryDialog extends StatelessWidget {
  const ServerLogEntryDialog({required this.log, super.key});

  final ServerLogEntry log;

  @override
  Widget build(final BuildContext context) => AlertDialog(
    scrollable: true,
    title: Text(log.localTimeString),
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(),
        _KeyValueRow(
          'console_page.logged_at'.tr(),
          '${log.localTimeString} (${log.localDateString(context.locale.languageCode)})',
        ),
        _KeyValueRow('UTC', log.fullUTCString),
        const Divider(),
        _SectionRow('server.log_dialog.metadata'.tr()),
        _KeyValueRow('server.log_dialog.cursor'.tr(), log.cursor),
        if (log.priority != null)
          _KeyValueRow(
            'server.log_dialog.priority'.tr(),
            log.priority?.toString(),
          ),
        if (log.systemdSlice != null)
          _KeyValueRow(
            'server.log_dialog.systemd_slice'.tr(),
            log.systemdSlice,
          ),
        if (log.systemdUnit != null)
          _KeyValueRow('server.log_dialog.systemd_unit'.tr(), log.systemdUnit),
        const Divider(),
        _SectionRow('server.log_dialog.message'.tr()),
        _DataRow(log.message),
      ],
    ),
    actions: [
      // A button to copy the request to the clipboard
      if (log.message.isNotEmpty)
        TextButton(
          onPressed: () => PlatformAdapter.setClipboard(log.message),
          child: Text('console_page.copy'.tr()),
        ),
      // close dialog
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text('basis.close'.tr()),
      ),
    ],
  );
}

class _SectionRow extends StatelessWidget {
  const _SectionRow(this.title);

  final String title;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
            width: 2.4,
          ),
        ),
      ),
      child: SelectableText(
        title.tr(),
        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
      ),
    ),
  );
}

class _KeyValueRow extends StatelessWidget {
  const _KeyValueRow(this.title, this.value);

  final String title;
  final String? value;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: SelectableText.rich(
      TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: '$title: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: value ?? ''),
        ],
      ),
    ),
  );
}

class _DataRow extends StatelessWidget {
  const _DataRow(this.data);

  final String? data;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: SelectableText(
      data ?? 'null',
      style: const TextStyle(fontWeight: FontWeight.w400),
    ),
  );
}
