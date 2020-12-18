import 'package:bloc/bloc.dart';
import 'package:bloc_app/Managers/ApiManager.dart';
import 'package:bloc_app/Models/Weather.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  ApiManager _api = ApiManager();
  String _cityName = '';

  WeatherCubit() : super(WeatherInitial());

  String get cityName => _cityName;

  void setCity(String city) {
    _cityName = city;
  }

  Future<void> getWeather() async {
    try {
      if (_cityName.length == 0) {
        emit(WeatherError(message: 'Enter a valid city name'));
        return;
      }
      emit(WeatherLoading());
      final weather = await _api.getWeatherInfo(_cityName);
      emit(WeatherLoaded(weather: weather));
    } on NetworkException {
      emit(WeatherError(
          message:
              'Server can not be reached at the moment. Please try again!'));
    }
  }
}
