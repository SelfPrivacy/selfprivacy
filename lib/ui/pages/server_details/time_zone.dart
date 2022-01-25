part of 'server_details.dart';

final List<Location> locations = timeZoneDatabase.locations.values.toList()
  ..sort((l1, l2) =>
      l1.currentTimeZone.offset.compareTo(l2.currentTimeZone.offset));

class SelectTimezone extends StatefulWidget {
  SelectTimezone({Key? key}) : super(key: key);

  @override
  _SelectTimezoneState createState() => _SelectTimezoneState();
}

class _SelectTimezoneState extends State<SelectTimezone> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  void _afterLayout(_) {
    var t = DateTime.now().timeZoneOffset;
    var index = locations.indexWhere((element) =>
        Duration(milliseconds: element.currentTimeZone.offset) == t);
    if (index >= 0) {
      controller.animateTo(40.0 * index,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: BrandHeader(
          title: 'select timezone',
          hasBackButton: true,
        ),
        preferredSize: Size.fromHeight(52),
      ),
      body: ListView(
        controller: controller,
        children: locations
            .asMap()
            .map((key, value) {
              var duration =
                  Duration(milliseconds: value.currentTimeZone.offset);
              var area = value.currentTimeZone.abbreviation
                  .replaceAll(RegExp(r'[\d+()-]'), '');
              return MapEntry(
                key,
                Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                            '${duration.toDayHourMinuteFormat()} ${area.isNotEmpty ? '($area)' : ''}'),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(value.name),
                      ),
                      // Text(value.toString()),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                      color: BrandColors.dividerColor,
                    )),
                  ),
                ),
              );
            })
            .values
            .toList(),
      ),
    );
  }
}
