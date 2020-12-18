import 'package:bloc_app/Models/Weather.dart';
import 'package:bloc_app/Provider/climate_states.dart';
import 'package:bloc_app/Provider/provider.dart';
import 'package:bloc_app/Views/CentralLoader.dart';
import 'package:bloc_app/Views/CitySearchText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Scene3 extends StatelessWidget {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riverpod'),
      ),
      //Riverpod Fourth Step - add a listener and a consumer (both required)
      body: ProviderListener(
        provider: weatherProvider.state,
        onChange: (BuildContext context, state) {
          if (state is ClimateError) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Consumer(
          builder: (context, watch, child) {
            final state = watch(weatherProvider.state);
            if (state is ClimateLoading) {
              return buildLoadingState();
            } else if (state is ClimateLoaded) {
              return buildLoadedState(context, state.weather, state.location);
            } else if (state is ClimateInitial) {
              return buildInitialState(context, state.location);
            }

            return buildInitialState(context, state.location);
          },
        ),
      ),
    );
  }

  Widget buildLoadedState(
      BuildContext context, Weather weather, String location) {
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
            child: getSearchText(context, location),
          ),
        ],
      ),
    );
  }

  Widget buildLoadingState() {
    return CentralLoader();
  }

  Widget buildInitialState(BuildContext context, String location) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: getSearchText(context, location),
      ),
    );
  }

  Widget getSearchText(BuildContext context, String city) {
    return CitySearchText(
      source: city,
      onChanged: (value) {
        controller.text = value;
      },
      onPressed: () =>
          context.read(weatherProvider).getWeather(controller.value.text),
      onSubmitted: (value) => context.read(weatherProvider).getWeather(value),
    );
  }
}
