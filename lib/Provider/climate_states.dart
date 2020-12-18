import 'package:bloc_app/Models/Weather.dart';
import 'package:equatable/equatable.dart';

abstract class ClimateState extends Equatable {
  final String location;
  const ClimateState({this.location = ''});
}

class ClimateInitial extends ClimateState {
  final String location;
  const ClimateInitial({this.location}) : super(location: location);

  @override
  List<Object> get props => [location];
}

class ClimateLoading extends ClimateState {
  const ClimateLoading();

  @override
  List<Object> get props => [];
}

class ClimateLoaded extends ClimateState {
  final Weather weather;
  final String location;
  const ClimateLoaded(this.weather, this.location) : super(location: location);

  @override
  List<Object> get props => [weather, location];
}

class ClimateError extends ClimateState {
  final String message;
  final String location;

  const ClimateError(this.message, this.location) : super(location: location);

  @override
  List<Object> get props => [message, location];
}
