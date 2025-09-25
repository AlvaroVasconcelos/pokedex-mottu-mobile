import 'pokemon_detail_model.dart';
import 'pokemon_model.dart';

abstract class IPokemonRepository {
  Future<List<PokemonModel>> fetchPokemons({int offset = 0, int limit = 20});
  Future<PokemonDetailModel> fetchPokemonDetail(String name);
  Future<List<PokemonModel>> fetchPokemonByType(String type);
  Future<List<PokemonModel>> fetchPokemonByAbility(String ability);
}
