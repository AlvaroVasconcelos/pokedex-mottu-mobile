import 'package:get/get.dart';

import '../controller/detail_pokemon_controller.dart';

class DetailPokemonBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<DetailPokemonController>(
      () => DetailPokemonController(
        Get.find(),
      ),
    );
  }
}
