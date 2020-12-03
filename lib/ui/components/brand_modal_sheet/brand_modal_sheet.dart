import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';

class BrandModalSheet extends StatelessWidget {
  const BrandModalSheet({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        minChildSize: 0.5,
        initialChildSize: 1,
        maxChildSize: 1,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            physics: ClampingScrollPhysics(),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 32, bottom: 6),
                    child: Container(
                      height: 4,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Color(0xFFE3E3E3).withOpacity(0.65),
                      ),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 32 - 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                      color: BrandColors.white,
                    ),
                    width: double.infinity,
                    child: child,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
