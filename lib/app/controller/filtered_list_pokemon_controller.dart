import 'package:get/get.dart';

import '../data/i_pokemon_repository.dart';
import '../data/pokemon_model.dart';

class FilteredListPokemonController extends GetxController {
  FilteredListPokemonController(
    this.repository, {
    Map<String, dynamic>? initialArguments,
  }) : _initialArguments = initialArguments;

  final IPokemonRepository repository;
  final Map<String, dynamic>? _initialArguments;

  final pokemons = <PokemonModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = _initialArguments ?? (Get.arguments as Map<String, dynamic>);
    final filter = args['filter'] as String;
    final filterType = args['filterType'] as String;

    if (filterType == 'type') {
      getPokemonByType(filter);
    } else if (filterType == 'ability') {
      getPokemonByAbility(filter);
    }
  }

  Future<void> getPokemonByType(String type) async {
    isLoading.value = true;
    final response = await repository.fetchPokemonByType(type);
    pokemons.assignAll(response);
    isLoading.value = false;
  }

  Future<void> getPokemonByAbility(String ability) async {
    isLoading.value = true;
    final response = await repository.fetchPokemonByAbility(ability);
    pokemons.assignAll(response);
    isLoading.value = false;
  }
}
