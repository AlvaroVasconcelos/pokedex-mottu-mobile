import 'package:get/get.dart';

import '../data/i_pokemon_repository.dart';
import '../data/pokemon_detail_model.dart';

class DetailPokemonController extends GetxController {
  DetailPokemonController(this.repository);

  final IPokemonRepository repository;
  final isLoading = false.obs;
  final pokemon = Rx<PokemonDetailModel?>(null);
  final hasError = ''.obs;

  Future<void> fetchPokemonDetail(String name) async {
    isLoading.value = true;
    try {
      pokemon.value = await repository.fetchPokemonDetail(name);
    } catch (error) {
      hasError.value = 'Failed to fetch Pokemon: $error';
      Get.snackbar('Error', hasError.value);
    } finally {
      isLoading.value = false;
    }
  }
}
