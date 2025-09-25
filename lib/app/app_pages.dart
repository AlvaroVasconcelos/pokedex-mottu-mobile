import 'package:get/get.dart';

import 'app_routes.dart';
import 'view/detail_pokemon_binding.dart';
import 'view/detail_pokemon_page.dart';
import 'view/list_pokemon_binding.dart';
import 'view/list_pokemon_page.dart';

class AppPages {
  static const initial = Routes.home;

  static final routes = [
    GetPage<void>(
      name: Routes.home,
      page: () => const ListPokemonPage(),
      binding: ListPokemonBinding(),
    ),
    GetPage<void>(
      name: Routes.detail,
      page: () => const DetailPokemonPage(),
      binding: DetailPokemonBinding(),
    ),
  ];
}
