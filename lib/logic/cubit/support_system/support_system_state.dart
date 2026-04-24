part of 'support_system_cubit.dart';

class SupportSystemState extends Equatable {
  const SupportSystemState(this.currentArticle);

  final String currentArticle;

  @override
  List<Object> get props => [currentArticle];
}
