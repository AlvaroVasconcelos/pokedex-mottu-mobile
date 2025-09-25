import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'i_pokemon_repository.dart';
import 'pokemon_adapter.dart';
import 'pokemon_detail_adapter.dart';
import 'pokemon_detail_model.dart';
import 'pokemon_model.dart';

class PokemonRepository implements IPokemonRepository {
  PokemonRepository(this._httpClient);
  final Dio _httpClient;

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  String _cacheKeyPokemons(int offset, int limit) =>
      'pokemons_${offset}_$limit';
  String _cacheKeyDetail(String name) => 'pokemon_detail_$name';
  String _cacheKeyType(String type, int offset, int limit) =>
      'pokemon_type_${type}_${offset}_$limit';
  String _cacheKeyAbility(String ability) => 'pokemon_ability_$ability';

  @override
  Future<List<PokemonModel>> fetchPokemons({
    int offset = 0,
    int limit = 20,
  }) async {
    final prefs = await _prefs;
    final cacheKey = _cacheKeyPokemons(offset, limit);

    try {
      final cachedData = prefs.getString(cacheKey);
      if (cachedData != null) {
        final decoded = jsonDecode(cachedData) as List<dynamic>;
        return PokemonAdapter.fromList(decoded);
      }

      final response = await _httpClient.get(
        '/pokemon',
        queryParameters: {'offset': offset, 'limit': limit},
      );

      final data = response.data as Map<String, dynamic>;
      final pokemons =
          PokemonAdapter.fromList(data['results'] as List<dynamic>);

      await prefs.setString(cacheKey, jsonEncode(data['results']));

      return pokemons;
    } on DioException catch (error, stackTrace) {
      log('Error fetching all pokemons: $error', stackTrace: stackTrace);
      rethrow;
    } catch (error, stackTrace) {
      log(
        'Unexpected error fetching all pokemons: $error',
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<PokemonDetailModel> fetchPokemonDetail(String name) async {
    final prefs = await _prefs;
    final cacheKey = _cacheKeyDetail(name);

    try {
      final cachedData = prefs.getString(cacheKey);
      if (cachedData != null) {
        return PokemonDetailAdapter.fromMap(
          jsonDecode(cachedData) as Map<String, dynamic>,
        );
      }

      final response = await _httpClient.get('/pokemon/$name');
      final map = response.data as Map<String, dynamic>;
      await prefs.setString(cacheKey, jsonEncode(map));

      return PokemonDetailAdapter.fromMap(map);
    } on DioException catch (error, stackTrace) {
      log('Error fetching pokemon by name: $error', stackTrace: stackTrace);
      rethrow;
    } catch (error, stackTrace) {
      log(
        'Unexpected error fetching pokemon by name: $error',
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<List<PokemonModel>> fetchPokemonByType(
    String type, {
    int offset = 0,
    int limit = 20,
  }) async {
    final prefs = await _prefs;
    final cacheKey = _cacheKeyType(type, offset, limit);

    try {
      final cachedData = prefs.getString(cacheKey);
      if (cachedData != null) {
        final decoded = jsonDecode(cachedData) as List<dynamic>;
        return PokemonAdapter.fromList(decoded);
      }

      final response = await _httpClient.get(
        '/type/$type',
        queryParameters: {'offset': offset, 'limit': limit},
      );

      final data = response.data['pokemon'] as List<dynamic>;
      await prefs.setString(cacheKey, jsonEncode(data));

      return PokemonAdapter.fromList(data);
    } catch (e, s) {
      log('Error fetching pokemon by type: $e', stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<PokemonModel>> fetchPokemonByAbility(String ability) async {
    final prefs = await _prefs;
    final cacheKey = _cacheKeyAbility(ability);

    try {
      final cachedData = prefs.getString(cacheKey);
      if (cachedData != null) {
        final decoded = jsonDecode(cachedData) as List<dynamic>;
        final pokemonList = decoded.map((e) => e['pokemon']).toList();
        return PokemonAdapter.fromList(pokemonList);
      }

      final response = await _httpClient.get('/ability/$ability');
      final data = response.data['pokemon'] as List<dynamic>;
      await prefs.setString(cacheKey, jsonEncode(data));

      final pokemonList = data.map((e) => e['pokemon']).toList();
      return PokemonAdapter.fromList(pokemonList);
    } catch (e, s) {
      log('Error fetching pokemon by ability: $e', stackTrace: s);
      rethrow;
    }
  }
}
