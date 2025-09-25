import 'pokemon_model.dart';

class PokemonAdapter {
  PokemonAdapter._();

  static PokemonModel fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    return PokemonModel(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  static List<PokemonModel> fromList(dynamic list) {
    return (list as List<dynamic>).map(PokemonAdapter.fromJson).toList();
  }

  static Map<String, dynamic> toJson(PokemonModel pokemon) {
    return {
      'name': pokemon.name,
      'url': pokemon.url,
    };
  }
}
