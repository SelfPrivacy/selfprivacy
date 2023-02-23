import 'dart:collection';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/models/message.dart';
import 'package:selfprivacy/ui/components/brand_header/brand_header.dart';

class ConsolePage extends StatefulWidget {
  const ConsolePage({super.key});

  @override
  State<ConsolePage> createState() => _ConsolePageState();
}

class _ConsolePageState extends State<ConsolePage> {
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
  Widget build(final BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(53),
            child: Column(
              children: [
                BrandHeader(
                  title: 'console_page.title'.tr(),
                  hasBackButton: true,
                ),
              ],
            ),
          ),
          body: FutureBuilder(
            future: getIt.allReady(),
            builder: (
              final BuildContext context,
              final AsyncSnapshot<void> snapshot,
            ) {
              if (snapshot.hasData) {
                final List<Message> messages =
                    getIt.get<ConsoleModel>().messages;

                return ListView(
                  reverse: true,
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 20),
                    ...UnmodifiableListView(
                      messages
                          .map((final message) {
                            final bool isError =
                                message.type == MessageType.warning;
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
                                            isError ? BrandColors.red1 : null,
                                      ),
                                    ),
                                    TextSpan(text: message.text),
                                  ],
                                ),
                              ),
                            );
                          })
                          .toList()
                          .reversed,
                    ),
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('console_page.waiting'.tr()),
                    const SizedBox(
                      height: 16,
                    ),
                    const CircularProgressIndicator(),
                  ],
                );
              }
            },
          ),
        ),
      );
}
