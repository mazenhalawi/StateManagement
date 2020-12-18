import 'package:bloc_app/Blocs/temp_bloc.dart';
import 'package:bloc_app/Cubit/weather_cubit.dart';
import 'package:bloc_app/Managers/ApiManager.dart';
import 'package:bloc_app/Scenes/BaseScene.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/all.dart';

void main() {
  runApp(MyApp());
}

final apiRef = Provider((ref) => ApiManager());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Riverpod First Step - Wrap upmost widget in ProviderScope
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MultiBlocProvider(providers: [
          BlocProvider<WeatherCubit>(create: (context) => WeatherCubit()),
          BlocProvider<TempBloc>(create: (context) => TempBloc(TempInitial()))
        ], child: BaseScene()),
      ),
    );
  }
}
