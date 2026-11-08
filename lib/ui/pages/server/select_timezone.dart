part of 'server_settings.dart';

@RoutePage()
class SelectTimezonePage extends StatefulWidget {
  const SelectTimezonePage({super.key});

  @override
  State<SelectTimezonePage> createState() => _SelectTimezonePageState();
}

class _SelectTimezonePageState extends State<SelectTimezonePage> {
  static const _deviceChoice = 'device';
  String? _selected;
  String _filter = '';
  bool _searching = false;
  bool _edited = false;
  bool _useDeviceTimezone = false;
  bool _loadingDeviceTimezone = false;
  Location? _deviceTimezone;
  Map<String, String> _zoneNames = {};
  String? _locale;
  DateTime _now = DateTime.now();
  late final Timer _clock;
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    _clock = Timer.periodic(const Duration(minutes: 1), (_) {
      setState(() => _now = DateTime.now());
    });
    _lifecycle = AppLifecycleListener(
      onResume: () {
        setState(() => _now = DateTime.now());
        unawaited(_loadDeviceTimezone());
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = context.locale.toLanguageTag();
    if (_locale == locale) {
      return;
    }
    _locale = locale;
    _zoneNames = {};
    unawaited(_loadDeviceTimezone());
    unawaited(_loadZoneNames(locale));
  }

  Future<void> _loadDeviceTimezone() async {
    if (_loadingDeviceTimezone) {
      return;
    }
    setState(() => _loadingDeviceTimezone = true);
    Location? location;
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      location = timeZoneDatabase.locations[info.identifier];
    } on PlatformException {
      location = null;
    } on MissingPluginException {
      location = null;
    } on ArgumentError {
      location = null;
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _deviceTimezone = location;
      _loadingDeviceTimezone = false;
      if (_useDeviceTimezone) {
        _selected = location?.name;
      }
    });
  }

  Future<void> _loadZoneNames(final String locale) async {
    try {
      final zones = await FlutterTimezone.getAvailableTimezones(locale);
      if (!mounted || _locale != locale) {
        return;
      }
      setState(() {
        _zoneNames = {
          for (final zone in zones)
            if (zone.localizedName case final name?) zone.identifier: name.name,
        };
      });
    } on PlatformException {
      return;
    } on MissingPluginException {
      return;
    } on ArgumentError {
      return;
    }
  }

  @override
  void dispose() {
    _clock.cancel();
    _lifecycle.dispose();
    super.dispose();
  }

  void _closeSearch() {
    FocusScope.of(context).unfocus();
    setState(() {
      _searching = false;
      _filter = '';
    });
  }

  @override
  Widget build(final BuildContext context) {
    final bloc = context.watch<ServerSettingsBloc>();
    final state = bloc.state;
    final selected = _edited ? _selected : state.timezone;
    final pending = state.pending<ChangeServerTimezoneJob>();
    final locations =
        timeZoneDatabase.locations.values
            .where(
              (final location) =>
                  location.name
                      .replaceAll('_', ' ')
                      .toLowerCase()
                      .contains(_filter) ||
                  location.name.toLowerCase().contains(_filter) ||
                  (_zoneNames[location.name]?.toLowerCase().contains(_filter) ??
                      false) ||
                  Duration(
                    milliseconds: location
                        .timeZone(_now.millisecondsSinceEpoch)
                        .offset,
                  ).toTimezoneOffsetFormat().contains(_filter),
            )
            .toList()
          ..sort((final a, final b) {
            final offset = a
                .timeZone(_now.millisecondsSinceEpoch)
                .offset
                .compareTo(b.timeZone(_now.millisecondsSinceEpoch).offset);
            return offset == 0 ? a.name.compareTo(b.name) : offset;
          });
    return PopScope(
      canPop: !_searching,
      onPopInvokedWithResult: (final didPop, _) {
        if (!didPop && _searching) {
          _closeSearch();
        }
      },
      child: RadioGroup<String>(
        groupValue: _useDeviceTimezone ? _deviceChoice : selected,
        onChanged: (final value) {
          if (state.canEditSettings) {
            setState(() {
              _useDeviceTimezone = value == _deviceChoice;
              _selected = _useDeviceTimezone ? _deviceTimezone?.name : value;
              _edited = true;
            });
          }
        },
        child: BrandHeroScreen(
          hasFlashButton: !_searching,
          heroIcon: Icons.schedule,
          heroTitle: 'server.select_timezone'.tr(),
          pinned: true,
          appBarTitle: _searching
              ? TextField(
                  autofocus: true,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'server.timezone_search_bar'.tr(),
                    border: InputBorder.none,
                  ),
                  onChanged: (final value) =>
                      setState(() => _filter = value.toLowerCase()),
                  onSubmitted: (_) => FocusScope.of(context).unfocus(),
                )
              : null,
          actions: [
            IconButton(
              tooltip: _searching
                  ? MaterialLocalizations.of(context).closeButtonTooltip
                  : MaterialLocalizations.of(context).searchFieldLabel,
              icon: Icon(_searching ? Icons.close : Icons.search),
              onPressed: _searching
                  ? _closeSearch
                  : () => setState(() => _searching = true),
            ),
          ],
          bottomBar: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (pending != null) ...[
                    const NotAppliedLabel(),
                    const SizedBox(height: 24),
                  ],
                  FilledButton(
                    onPressed:
                        state.canEditSettings &&
                            (!_useDeviceTimezone || !_loadingDeviceTimezone) &&
                            selected != null &&
                            selected != state.timezone
                        ? () {
                            bloc.add(TimezoneSelected(selected));
                            context.router.pop();
                          }
                        : null,
                    child: Text(
                      (pending == null
                              ? 'service_page.create_job'
                              : 'service_page.update_job')
                          .tr(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          children: [
            if (_deviceTimezone case final location?)
              TimezoneSelectionTile(
                key: const ValueKey(_deviceChoice),
                value: _deviceChoice,
                title: 'server.timezone.device'.tr(),
                location: location,
                zoneName: _zoneNames[location.name],
                now: _now,
                enabled: state.canEditSettings && !_loadingDeviceTimezone,
              )
            else
              Skeletonizer(
                enabled: _loadingDeviceTimezone,
                child: RadioListTile<String>(
                  value: _deviceChoice,
                  enabled: false,
                  title: Text('server.timezone.device'.tr()),
                  subtitle: Text(
                    (_loadingDeviceTimezone
                            ? 'server.timezone.detecting'
                            : 'server.timezone.unavailable')
                        .tr(),
                  ),
                  secondary: _loadingDeviceTimezone
                      ? null
                      : IconButton(
                          tooltip: 'server.timezone.retry_detection'.tr(),
                          icon: const Icon(Icons.refresh),
                          onPressed: _loadDeviceTimezone,
                        ),
                ),
              ),
            if (locations.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('server.timezone.no_matches'.tr()),
              ),
            for (final location in locations)
              TimezoneSelectionTile(
                key: ValueKey(location.name),
                location: location,
                zoneName: _zoneNames[location.name],
                now: _now,
                enabled: state.canEditSettings,
              ),
          ],
        ),
      ),
    );
  }
}
