import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'app/data/i_pokemon_repository.dart';
import 'app/data/pokemon_repository.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  final httpClient = Dio(
    BaseOptions(
      baseUrl: 'https://pokeapi.co/api/v2/',
    ),
  );
  httpClient.interceptors.add(LogInterceptor(responseBody: false));
  final options = CacheOptions(
    store: MemCacheStore(),
    policy: CachePolicy.forceCache,
    priority: CachePriority.normal,
    maxStale: const Duration(days: 7),
    allowPostMethod: true,
  );
  httpClient.interceptors.add(DioCacheInterceptor(options: options));
  Get
    ..put<Dio>(httpClient)
    ..put<IPokemonRepository>(PokemonRepository(Get.find<Dio>()));
  runApp(await builder());
}
