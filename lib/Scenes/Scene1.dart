import 'package:bloc_app/Cubit/weather_cubit.dart';
import 'package:bloc_app/Models/Weather.dart';
import 'package:bloc_app/Views/CentralLoader.dart';
import 'package:bloc_app/Views/CitySearchText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Scene1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cubit'),
      ),
      body: BlocConsumer<WeatherCubit, WeatherState>(
        listener: (context, state) {
          if (state is WeatherError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, WeatherState state) {
          if (state is WeatherInitial) {
            return buildInitialState(context);
          } else if (state is WeatherLoading) {
            return buildLoadingState();
          } else if (state is WeatherError) {
            return buildInitialState(context);
          } else if (state is WeatherLoaded) {
            return buildLoadedState(context, state.weather);
          }

          return buildInitialState(context);
        },
      ),
    );
  }

  Widget buildInitialState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: getSearchText(context),
          )
        ],
      ),
    );
  }

  Widget buildLoadingState() {
    return CentralLoader();
  }

  Widget buildLoadedState(BuildContext context, Weather weather) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weather.cityName,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${weather.tempC.toStringAsPrecision(3)} °C',
                        style: TextStyle(
                            fontSize: 62, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: getSearchText(context),
          ),
        ],
      ),
    );
  }

  Widget getSearchText(BuildContext context) {
    return CitySearchText(
      source: context.watch<WeatherCubit>().cityName,
      onChanged: (value) => context.read<WeatherCubit>().setCity(value),
      onPressed: () => context.read<WeatherCubit>().getWeather(),
    );
  }
}
