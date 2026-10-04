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
  final navigator = Navigator.of(context, rootNavigator: true);
  final localizations = MaterialLocalizations.of(context);
  operations.sheetOpen = true;
  final route = ModalBottomSheetRoute<T>(
    capturedThemes: InheritedTheme.capture(
      from: context,
      to: navigator.context,
    ),
    barrierLabel: localizations.scrimLabel,
    barrierOnTapHint: localizations.scrimOnTapHint(
      localizations.bottomSheetLabel,
    ),
    modalBarrierColor: Theme.of(context).bottomSheetTheme.modalBarrierColor,
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
  final subscription = operations.stream.listen(
    (_) {},
    onDone: () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (route.isActive) {
          route.navigator?.removeRoute(route);
        }
      });
    },
  );
  try {
    return await navigator.push(route);
  } finally {
    operations.sheetOpen = false;
    await subscription.cancel();
  }
}
