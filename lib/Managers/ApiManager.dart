import 'dart:math';

import 'package:bloc_app/Models/Weather.dart';

class ApiManager {
  Future<Weather> getWeatherInfo(String cityName) async {
    await Future.delayed(Duration(seconds: 1));

    final random = Random();
    final bool = random.nextBool();
    if (bool) throw NetworkException();

    final weather =
        Weather(cityName: cityName, tempC: random.nextDouble() * 40);

    return weather;
  }
}

class NetworkException implements Exception {}
