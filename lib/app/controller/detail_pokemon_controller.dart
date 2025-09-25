import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../data/i_pokemon_repository.dart';
import '../data/pokemon_detail_model.dart';
import '../data/pokemon_model.dart';

class Debounce {
  Timer? _timer;

  void call(void Function() action) {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 300), action);
  }
}

class DetailPokemonController extends GetxController {
  DetailPokemonController(this.repository);

  final IPokemonRepository repository;
  final isLoading = false.obs;
  final pokemon = Rx<PokemonDetailModel?>(null);
  final hasError = ''.obs;
  final debounce = Debounce();

  @override
  void onInit() {
    super.onInit();
    _loadPokemonDetailsFromArguments();
  }

  void _loadPokemonDetailsFromArguments() {
    final pokemonFromList = Get.arguments as PokemonModel;
    fetchPokemonByName(pokemonFromList.name);
  }

  Future<void> fetchPokemonByName(String name) async {
    isLoading.value = true;
    try {
      pokemon.value = await repository.getPokemonByName(name);
    } on DioException catch (error) {
      await _handleFetchError(error);
    } on Exception catch (error) {
      await _handleFetchError(error);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _handleFetchError(Exception error) async {
    hasError.value = 'Failed to fetch Pokemon: $error';
    Get.snackbar('Error', hasError.value);
  }
}
