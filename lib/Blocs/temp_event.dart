part of 'temp_bloc.dart';

abstract class TempEvent {
  const TempEvent();
}

class GetWeather extends TempEvent {
  const GetWeather();
}

class AddCity extends TempEvent {
  final String city;
  AddCity(this.city);
}
