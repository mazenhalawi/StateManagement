import 'package:bloc_app/Managers/ApiManager.dart';
import 'package:bloc_app/Models/Weather.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'temp_event.dart';
part 'temp_state.dart';

class TempBloc extends Bloc<TempEvent, TempState> {
  TempBloc(TempState initialState) : super(initialState);

  String _city;

  String get city => _city;

  @override
  Stream<TempState> mapEventToState(TempEvent event) async* {
    if (event is GetWeather) {
      try {
        yield TempLoading();
        final weather = await ApiManager().getWeatherInfo(_city);
        yield TempLoaded(weather);
      } on NetworkException {
        yield TempError('Server can not be reached at the moment. Please try again!');
      }
    } else if (event is AddCity) {
      _city = event.city;
    }
  }
}
