import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/organisms/jobs/jobs_content.dart';

Future<T?> showModalJobsSheet<T>({required final BuildContext context}) =>
    showModalBottomSheet<T>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder:
          (final BuildContext context) => DraggableScrollableSheet(
            expand: false,
            maxChildSize: 0.9,
            minChildSize: 0.4,
            initialChildSize: 0.6,
            builder:
                (final context, final scrollController) =>
                    JobsContent(controller: scrollController),
          ),
    );
