part of 'server_settings.dart';

final List<Location> locations =
    timeZoneDatabase.locations.values.toList()..sort(
      (final l1, final l2) =>
          l1.currentTimeZone.offset.compareTo(l2.currentTimeZone.offset),
    );

@RoutePage()
class SelectTimezonePage extends StatefulWidget {
  const SelectTimezonePage({super.key});

  @override
  State<SelectTimezonePage> createState() => _SelectTimezonePageState();
}

class _SelectTimezonePageState extends State<SelectTimezonePage> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  String? timezoneFilterValue;
  bool isSearching = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    searchController.addListener(() {
      setState(() {
        timezoneFilterValue =
            searchController.text.isNotEmpty ? searchController.text : null;
      });
    });
    super.initState();
  }

  void _afterLayout(final _) {
    final t = DateTime.now().timeZoneOffset;
    final index = locations.indexWhere(
      (final element) =>
          Duration(milliseconds: element.currentTimeZone.offset) == t,
    );

    if (index >= 0) {
      unawaited(
        scrollController.animateTo(
          60.0 * index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        ),
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final isDesktop = Breakpoints.mediumAndUp.isActive(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:
            (isDesktop || isSearching)
                ? TextField(
                  readOnly: false,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  enabled: true,
                  controller: searchController,
                  decoration: InputDecoration(
                    errorText: null,
                    hintText: 'server.timezone_search_bar'.tr(),
                  ),
                )
                : Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text('server.select_timezone'.tr()),
                ),
        leading:
            !isDesktop
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed:
                      isSearching
                          ? () => setState(() => isSearching = false)
                          : () => Navigator.of(context).pop(),
                )
                : null,
        actions: [
          if (!isSearching && !isDesktop)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => setState(() => isSearching = true),
            ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          controller: scrollController,
          children:
              locations
                  .where(
                    (final Location location) =>
                        timezoneFilterValue == null ||
                        location.name.toLowerCase().contains(
                          timezoneFilterValue!,
                        ) ||
                        Duration(milliseconds: location.currentTimeZone.offset)
                            .toTimezoneOffsetFormat()
                            .contains(timezoneFilterValue!),
                  )
                  .toList()
                  .asMap()
                  .map(locationToListTile)
                  .values
                  .toList(),
        ),
      ),
    );
  }

  MapEntry<int, ListTile> locationToListTile(
    final int key,
    final Location location,
  ) {
    final duration = Duration(milliseconds: location.currentTimeZone.offset);
    final area = location.currentTimeZone.abbreviation.replaceAll(
      RegExp(r'[\d+()-]'),
      '',
    );

    return MapEntry(
      key,
      ListTile(
        title: Text(location.name),
        subtitle: Text(
          'GMT ${duration.toTimezoneOffsetFormat()} ${area.isNotEmpty ? '($area)' : ''}',
        ),
        onTap: () {
          context.read<JobsCubit>().addJob(
            ChangeServerTimezoneJob(timezone: location.name),
          );
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
