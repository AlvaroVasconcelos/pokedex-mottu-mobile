import 'pokemon_detail_model.dart';
import 'pokemon_model.dart';

abstract class IPokemonRepository {
  Future<List<PokemonModel>> getAllPokemons();
  Future<PokemonDetailModel> getPokemonByName(String name);
}
