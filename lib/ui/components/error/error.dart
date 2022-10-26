import 'package:flutter/material.dart';

class BrandError extends StatelessWidget {
  const BrandError({super.key, this.error, this.stackTrace});

  final Object? error;
  final StackTrace? stackTrace;

  @override
  Widget build(final BuildContext context) => SafeArea(
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(error.toString()),
                  const Text('stackTrace: '),
                  Text(stackTrace.toString()),
                ],
              ),
            ),
          ),
        ),
      );
}
