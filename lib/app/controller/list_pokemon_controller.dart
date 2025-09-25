import 'package:get/get.dart';
import '../data/i_pokemon_repository.dart';
import '../data/pokemon_model.dart';

class ListPokemonController extends GetxController {
  ListPokemonController(this.repository);

  final IPokemonRepository repository;

  final pokemons = <PokemonModel>[].obs;

  @override
  void onInit() {
    fetchPokemons();
    super.onInit();
  }

  Future<void> fetchPokemons() async {
    await _performFetchPokemons();
  }

  Future<void> _performFetchPokemons() async {
    final response = await repository.getAllPokemons();
    pokemons.assignAll(response);
  }
}
