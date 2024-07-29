part of 'tokens_bloc.dart';

sealed class TokensEvent extends Equatable {
  const TokensEvent();
}

class RevalidateTokens extends TokensEvent {
  const RevalidateTokens();

  @override
  List<Object> get props => [];
}
