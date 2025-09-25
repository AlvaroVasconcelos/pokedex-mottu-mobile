import 'dart:developer';

import 'pokemon_detail_model.dart';

class PokemonDetailAdapter {
  static PokemonDetailModel fromMap(Map<String, dynamic> map) {
    try {
      return PokemonDetailModel(
        abilities: _mapList(map['abilities'], Ability.fromMap),
        baseExperience: map['base_experience'] as int?,
        forms: _mapList(map['forms'], Species.fromMap),
        gameIndices: _mapList(map['game_indices'], GameIndex.fromMap),
        height: map['height'] as int?,
        heldItems: _mapList(map['held_items'], HeldItem.fromMap),
        id: map['id'] as int?,
        isDefault: map['is_default'] as bool?,
        locationAreaEncounters: map['location_area_encounters'] as String?,
        moves: _mapList(map['moves'], Move.fromMap),
        name: map['name'] as String?,
        order: map['order'] as int?,
        pastAbilities: _mapList(map['past_abilities'], PastAbility.fromMap),
        pastTypes:
            map['past_types'] == null ? [] : map['past_types'] as List<dynamic>,
        species: Species.fromMap(map['species']),
        sprites: Sprites.fromMap(map['sprites']),
        stats: _mapList(map['stats'], Stat.fromMap),
        types: _mapList(map['types'], Type.fromMap),
        weight: map['weight'] as int?,
      );
    } catch (e, s) {
      log('Error parsing Pokemon detail: $e', stackTrace: s);
      rethrow;
    }
  }

  static List<T> _mapList<T>(
    dynamic rawList,
    T Function(Map<String, dynamic>) fromMap,
  ) {
    if (rawList is List) {
      return rawList
          .whereType<Map<String, dynamic>>()
          .map((x) => fromMap(x))
          .toList();
    }
    return [];
  }
}
