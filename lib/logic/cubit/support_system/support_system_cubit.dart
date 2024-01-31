import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'support_system_state.dart';

class SupportSystemCubit extends Cubit<SupportSystemState> {
  SupportSystemCubit() : super(const SupportSystemState('about'));

  void showArticle({
    required final String article,
    final BuildContext? context,
  }) {
    emit(SupportSystemState(article));
    if (context != null) {
      Scaffold.of(context).openEndDrawer();
    }
  }
}
