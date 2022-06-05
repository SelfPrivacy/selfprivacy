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
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
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
      controller.animateTo(
        60.0 * index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(52),
          child: BrandHeader(
            title: 'select timezone',
            hasBackButton: true,
          ),
        ),
        body: ListView(
          controller: controller,
          children: locations
              .asMap()
              .map((final key, final value) {
                final duration =
                    Duration(milliseconds: value.currentTimeZone.offset);
                final area = value.currentTimeZone.abbreviation
                    .replaceAll(RegExp(r'[\d+()-]'), '');

                String timezoneName = value.name;
                if (context.locale.toString() == 'ru') {
                  timezoneName = russian[value.name] ??
                      () {
                        final arr = value.name.split('/')..removeAt(0);
                        return arr.join('/');
                      }();
                }

                return MapEntry(
                  key,
                  Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: BrandColors.dividerColor,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BrandText.body1(
                          timezoneName,
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
                );
              })
              .values
              .toList(),
        ),
      );
}
