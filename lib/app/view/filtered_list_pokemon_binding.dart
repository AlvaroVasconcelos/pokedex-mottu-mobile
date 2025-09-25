import 'package:get/get.dart';

import '../controller/filtered_list_pokemon_controller.dart';

class FilteredListPokemonBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilteredListPokemonController>(
      () => FilteredListPokemonController(Get.find()),
    );
  }
}
