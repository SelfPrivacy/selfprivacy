part of '../server_details_screen.dart';

final List<Location> locations = timeZoneDatabase.locations.values.toList()
  ..sort(
    (final l1, final l2) =>
        l1.currentTimeZone.offset.compareTo(l2.currentTimeZone.offset),
  );

class SelectTimezone extends StatefulWidget {
  const SelectTimezone({final super.key});

  @override
  State<SelectTimezone> createState() => _SelectTimezoneState();
}

class _SelectTimezoneState extends State<SelectTimezone> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  String? timezoneFilterValue;

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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(156),
          child: Column(
            children: [
              BrandHeader(
                title: 'server.select_timezone'.tr(),
              ),
              Row(
                children: [
                  const SizedBox(width: 16),
                  SizedBox(
                    height: 52,
                    child: TextField(
                      readOnly: false,
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.next,
                      enabled: true,
                      controller: searchController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        errorText: null,
                        labelText: 'server.timezone_search_bar'.tr(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.search_outlined),
                  const SizedBox(width: 16),
                ],
              ),
            ],
          ),
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
      final int key, final Location location) {
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
