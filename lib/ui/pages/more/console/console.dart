import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/get_it/console.dart';
import 'package:selfprivacy/logic/models/message.dart';
import 'package:selfprivacy/ui/components/brand_divider/brand_divider.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';

class Console extends StatefulWidget {
  const Console({Key key}) : super(key: key);

  @override
  _ConsoleState createState() => _ConsoleState();
}

class _ConsoleState extends State<Console> {
  @override
  void initState() {
    getIt.get<ConsoleModel>().addListener(update);

    super.initState();
  }

  @override
  void dispose() {
    getIt<ConsoleModel>().removeListener(update);
    super.dispose();
  }

  void update() => setState(() => {});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: Column(
            children: [
              BrandHeader(title: 'Console', hasBackButton: true),
              BrandDivider(),
            ],
          ),
          preferredSize: Size.fromHeight(53),
        ),
        body: FutureBuilder(
          future: getIt.allReady(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.hasData) {
              var messages = getIt.get<ConsoleModel>().messages;

              return ListView(
                reverse: true,
                shrinkWrap: true,
                children: [
                  SizedBox(height: 20),
                  ...UnmodifiableListView(messages
                      .map((message) {
                        var isError = message.type == MessageType.warning;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        '${message.timeString}${isError ? '(Error)' : ''}: \n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            isError ? BrandColors.red1 : null)),
                                TextSpan(text: message.text),
                              ],
                            ),
                          ),
                        );
                      })
                      .toList()
                      .reversed),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Waiting for initialisation'),
                  SizedBox(
                    height: 16,
                  ),
                  CircularProgressIndicator(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
