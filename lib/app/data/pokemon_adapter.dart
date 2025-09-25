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

  static PokemonModel fromMap(Map<String, dynamic> map) {
    return PokemonModel(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  static List<PokemonModel> fromList(dynamic list) {
    if (list == null) return [];

    return (list as List<dynamic>).map((x) {
      if (x['pokemon'] != null) {
        return PokemonAdapter.fromMap(x['pokemon'] as Map<String, dynamic>);
      }
      return PokemonAdapter.fromMap(x as Map<String, dynamic>);
    }).toList();
  }

  static Map<String, dynamic> toJson(PokemonModel pokemon) {
    return {
      'name': pokemon.name,
      'url': pokemon.url,
    };
  }
}
