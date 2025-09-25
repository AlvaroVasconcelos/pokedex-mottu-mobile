import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../l10n/arb/app_localizations.dart';
import 'app_pages.dart';
import 'data/connectivity_service.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final StreamSubscription<String> _connectivitySubscription;
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    final connectivityService = Get.find<ConnectivityService>();
    _connectivitySubscription =
        connectivityService.connectivityStream.listen((status) {
      setState(() {
        _isOffline = status == 'offline';
      });
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      locale: AppLocalizations.supportedLocales.first,
      debugShowCheckedModeBanner: false,
      title: 'Mottu',
      builder: (context, child) {
        return Column(
          children: [
            if (_isOffline)
              MaterialBanner(
                content: const Text('Você está offline'),
                backgroundColor: Colors.red,
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isOffline = false;
                      });
                    },
                    child: const Text('FECHAR'),
                  ),
                ],
              ),
            Expanded(child: child!),
          ],
        );
      },
    );
  }
}
