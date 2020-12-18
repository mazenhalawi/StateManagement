import 'package:bloc_app/Managers/ApiManager.dart';
import 'package:flutter_riverpod/all.dart';

import 'climate_states.dart';

//Riverpod Second Step - Create a state notifier
class ClimateNotifier extends StateNotifier<ClimateState> {
  final ApiManager api;

  ClimateNotifier(this.api) : super(ClimateInitial());

  Future<void> getWeather(String location) async {
    try {
      state = ClimateLoading();
      final weather = await api.getWeatherInfo(location);
      state = ClimateLoaded(weather, location);
    } on NetworkException {
      state = ClimateError(
          'Server can not be reached at the moment. Please try again!',
          location);
    }
  }
}
