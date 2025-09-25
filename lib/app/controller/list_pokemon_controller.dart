import 'dart:async';
import 'package:get/get.dart';

import '../data/i_pokemon_repository.dart';
import '../data/pokemon_model.dart';

class ListPokemonController extends GetxController {
  ListPokemonController(this.repository);

  final IPokemonRepository repository;

  final pokemons = <PokemonModel>[].obs;
  int offset = 0;
  final isLoading = false.obs;
  Timer? _debounce;
  @override
  void onInit() {
    fetchPokemons();
    super.onInit();
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }

  Future<void> fetchPokemons() async {
    offset = 0;
    pokemons.clear();
    await loadMorePokemons();
  }

  Future<void> loadMorePokemons() async {
    if (isLoading.value) return;
    isLoading.value = true;
    final response = await repository.fetchPokemons(offset: offset);
    pokemons.addAll(response);
    offset += response.length;
    isLoading.value = false;
  }

  Future<void> getPokemonByAbility(String ability) async {
    final response = await repository.fetchPokemonByAbility(ability);
    pokemons.assignAll(response);
  }

  Future<void> getPokemonByType(String type) async {
    final response = await repository.fetchPokemonByType(type);
    pokemons.assignAll(response);
  }

  void searchPokemons(String name) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (name.isEmpty) {
        await fetchPokemons();
        return;
      }

      final filteredPokemons = pokemons
          .where(
            (pokemon) => pokemon.name.toLowerCase().contains(
                  name.toLowerCase(),
                ),
          )
          .toList();
      pokemons.assignAll(filteredPokemons);
    });
  }
}
