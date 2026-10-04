import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/bloc/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/logic/cubit/app_readiness/app_readiness_cubit.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/operations_cubit.dart';
import 'package:selfprivacy/ui/organisms/jobs/jobs_content.dart';

Future<T?> showModalJobsSheet<T>({required final BuildContext context}) async {
  final operations = context.read<OperationsCubit>();
  if (operations.sheetOpen) {
    return null;
  }
  final jobs = context.read<JobsCubit>();
  final serverJobs = context.read<ServerJobsBloc>();
  final readiness = context.read<AppReadinessCubit>();
  operations.sheetOpen = true;
  try {
    return await showModalBottomSheet<T>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (final BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: operations),
          BlocProvider.value(value: jobs),
          BlocProvider.value(value: serverJobs),
          BlocProvider.value(value: readiness),
        ],
        child: DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          initialChildSize: 0.6,
          builder: (final context, final scrollController) =>
              JobsContent(controller: scrollController),
        ),
      ),
    );
  } finally {
    operations.sheetOpen = false;
  }
}
