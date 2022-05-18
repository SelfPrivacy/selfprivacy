part of '../server_details_screen.dart';

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
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  void _afterLayout(_) {
    var t = DateTime.now().timeZoneOffset;
    var index = locations.indexWhere((element) =>
        Duration(milliseconds: element.currentTimeZone.offset) == t);
    print(t);

    if (index >= 0) {
      controller.animateTo(60.0 * index,
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

              String timezoneName = value.name;
              if (context.locale.toString() == 'ru') {
                timezoneName = russian[value.name] ??
                    () {
                      var arr = value.name.split('/')..removeAt(0);
                      return arr.join('/');
                    }();
              }

              return MapEntry(
                key,
                Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BrandText.body1(
                        timezoneName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      BrandText.small(
                          'GMT ${duration.toDayHourMinuteFormat()} ${area.isNotEmpty ? '($area)' : ''}',
                          style: TextStyle(
                            fontSize: 13,
                          )),
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
