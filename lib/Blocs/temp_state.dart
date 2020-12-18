part of 'temp_bloc.dart';

abstract class TempState extends Equatable {
  const TempState();
}

class TempInitial extends TempState {
  const TempInitial();

  @override
  List<Object> get props => [];
}

class TempLoading extends TempState {
  const TempLoading();

  @override
  List<Object> get props => [];
}

class TempLoaded extends TempState {
  final Weather weather;
  const TempLoaded(this.weather);

  @override
  List<Object> get props => [weather];
}

class TempError extends TempState {
  final String message;
  TempError(this.message);

  @override
  List<Object> get props => throw [message];
}
