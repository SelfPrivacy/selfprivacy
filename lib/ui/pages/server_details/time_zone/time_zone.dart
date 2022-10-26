part of '../server_details_screen.dart';

final List<Location> locations = timeZoneDatabase.locations.values.toList()
  ..sort(
    (final l1, final l2) =>
        l1.currentTimeZone.offset.compareTo(l2.currentTimeZone.offset),
  );

class SelectTimezone extends StatefulWidget {
  const SelectTimezone({super.key});

  @override
  State<SelectTimezone> createState() => _SelectTimezoneState();
}

class _SelectTimezoneState extends State<SelectTimezone> {
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
    print(t);

    if (index >= 0) {
      scrollController.animateTo(
        60.0 * index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
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
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: isSearching
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
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text('server.select_timezone'.tr()),
                ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: isSearching
                ? () => setState(() => isSearching = false)
                : () => Navigator.of(context).pop(),
          ),
          actions: [
            if (!isSearching)
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => setState(() => isSearching = true),
              ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            controller: scrollController,
            children: locations
                .where(
                  (final Location location) => timezoneFilterValue == null
                      ? true
                      : location.name
                              .toLowerCase()
                              .contains(timezoneFilterValue!) ||
                          Duration(
                            milliseconds: location.currentTimeZone.offset,
                          )
                              .toDayHourMinuteFormat()
                              .contains(timezoneFilterValue!),
                )
                .toList()
                .asMap()
                .map(
                  (final key, final value) => locationToListTile(key, value),
                )
                .values
                .toList(),
          ),
        ),
      );

  MapEntry<int, Container> locationToListTile(
    final int key,
    final Location location,
  ) {
    final duration = Duration(milliseconds: location.currentTimeZone.offset);
    final area = location.currentTimeZone.abbreviation
        .replaceAll(RegExp(r'[\d+()-]'), '');

    return MapEntry(
      key,
      Container(
        height: 75,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: BrandColors.dividerColor,
            ),
          ),
        ),
        child: InkWell(
          onTap: () {
            context.read<ServerDetailsCubit>().repository.setTimezone(
                  location.name,
                );
            Navigator.of(context).pop();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BrandText.body1(
                  location.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                BrandText.small(
                  'GMT ${duration.toDayHourMinuteFormat()} ${area.isNotEmpty ? '($area)' : ''}',
                  style: const TextStyle(
                    fontSize: 13,
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
