import 'package:get/get.dart';

import '../controller/list_pokemon_controller.dart';

class ListPokemonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListPokemonController>(
      () => ListPokemonController(
        Get.find(),
      ),
    );
  }
}
