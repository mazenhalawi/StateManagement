import 'package:bloc_app/Managers/ApiManager.dart';
import 'package:bloc_app/Provider/climate_notifier.dart';
import 'package:flutter_riverpod/all.dart';

//Riverpod Third Step - Identify all providers

final apiProvider = Provider<ApiManager>((ref) => ApiManager());

final weatherProvider =
    StateNotifierProvider((ref) => ClimateNotifier(ref.watch(apiProvider)));
