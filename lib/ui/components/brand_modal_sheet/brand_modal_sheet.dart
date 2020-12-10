import 'package:flutter/material.dart';

var navigatorKey = GlobalKey<NavigatorState>();

class BrandModalSheet extends StatelessWidget {
  const BrandModalSheet({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        minChildSize: 0.95,
        initialChildSize: 1,
        maxChildSize: 1,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            physics: ClampingScrollPhysics(),
            child: Container(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: double.infinity,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 132, bottom: 6),
                          child: Container(
                            height: 4,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Color(0xFFE3E3E3).withOpacity(0.65),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 32 - 4,
                      maxHeight: MediaQuery.of(context).size.height,
                    ),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    width: double.infinity,
                    child: child
                  ),
                ],
              ),
            ),
          );
        });
  }
}
