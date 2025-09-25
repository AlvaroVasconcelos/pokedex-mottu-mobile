import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'app/data/i_pokemon_repository.dart';
import 'app/data/pokemon_repository.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Get
    ..put<Dio>(
      Dio(
        BaseOptions(
          baseUrl: 'https://pokeapi.co/api/v2/',
        ),
      ),
    )
    ..put<IPokemonRepository>(PokemonRepository(Get.find<Dio>()));
  runApp(await builder());
}
