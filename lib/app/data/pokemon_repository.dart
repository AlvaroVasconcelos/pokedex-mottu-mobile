import 'dart:developer';

import 'package:dio/dio.dart';
import 'i_pokemon_repository.dart';
import 'pokemon_adapter.dart';
import 'pokemon_detail_adapter.dart';
import 'pokemon_detail_model.dart';
import 'pokemon_model.dart';

class PokemonRepository implements IPokemonRepository {
  PokemonRepository(this._httpClient);
  final Dio _httpClient;

  @override
  Future<List<PokemonModel>> getAllPokemons() async {
    try {
      return _fetchAndAdaptPokemons();
    } on DioException catch (error, stackTrace) {
      log(
        'Error fetching all pokemons: $error',
        stackTrace: stackTrace,
      );
      rethrow;
    } catch (error, stackTrace) {
      log(
        'Unexpected error fetching all pokemons: $error',
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<List<PokemonModel>> _fetchAndAdaptPokemons() async {
    final response = await _httpClient.get('/pokemon');
    final data = response.data as Map<String, dynamic>;
    return PokemonAdapter.fromList(data['results'] as List<dynamic>);
  }

  @override
  Future<PokemonDetailModel> getPokemonByName(String name) async {
    try {
      return _fetchAndAdaptPokemonDetail(name);
    } on DioException catch (error, stackTrace) {
      log(
        'Error fetching pokemon by name: $error',
        stackTrace: stackTrace,
      );
      rethrow;
    } catch (error, stackTrace) {
      log(
        'Unexpected error fetching pokemon by name: $error',
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<PokemonDetailModel> _fetchAndAdaptPokemonDetail(String name) async {
    final response = await _httpClient.get('/pokemon/$name');
    return PokemonDetailAdapter.fromMap(
      response.data as Map<String, dynamic>,
    );
  }
}
