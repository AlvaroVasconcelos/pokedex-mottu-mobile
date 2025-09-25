import 'dart:async';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mottu/firebase_options.dart';

import 'app/data/connectivity_service.dart';
import 'app/data/i_pokemon_repository.dart';
import 'app/data/pokemon_repository.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  Get
    ..put(initHttpClient())
    ..put(ConnectivityService())
    ..put<IPokemonRepository>(PokemonRepository(Get.find<Dio>()));
  runApp(await builder());
}

Dio initHttpClient() {
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
  return httpClient;
}
