import 'package:equatable/equatable.dart';

class Weather extends Object implements Equatable {
  final String cityName;
  final double tempC;

  Weather({this.cityName, this.tempC});

  @override
  List<Object> get props => [cityName, tempC];

  @override
  bool get stringify => true;
}
