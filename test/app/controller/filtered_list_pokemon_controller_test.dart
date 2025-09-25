import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mottu/app/controller/filtered_list_pokemon_controller.dart';
import 'package:mottu/app/data/i_pokemon_repository.dart';
import 'package:mottu/app/data/pokemon_model.dart';

class MockPokemonRepository extends Mock implements IPokemonRepository {}

void main() {
  late MockPokemonRepository repository;
  late FilteredListPokemonController controller;

  setUp(() {
    repository = MockPokemonRepository();
    Get.testMode = true;
  });

  group('FilteredListPokemonController', () {
    test('Should call getPokemonByType on init when filterType is "type"',
        () async {
      final fakePokemons = [PokemonModel(name: 'Pikachu', url: '')];

      when(() => repository.fetchPokemonByType('electric'))
          .thenAnswer((_) async => fakePokemons);

      controller = FilteredListPokemonController(
        repository,
        initialArguments: {'filter': 'electric', 'filterType': 'type'},
      );

      controller.onInit();
      await Future.delayed(Duration.zero);

      verify(() => repository.fetchPokemonByType('electric')).called(1);
      expect(controller.isLoading.value, isFalse);
      expect(controller.pokemons, fakePokemons);
    });

    test('Should call getPokemonByAbility on init when filterType is "ability"',
        () async {
      final fakePokemons = [PokemonModel(name: 'Bulbasaur', url: '')];

      when(() => repository.fetchPokemonByAbility('overgrow'))
          .thenAnswer((_) async => fakePokemons);

      controller = FilteredListPokemonController(
        repository,
        initialArguments: {'filter': 'overgrow', 'filterType': 'ability'},
      );

      controller.onInit();
      await Future.delayed(Duration.zero);

      verify(() => repository.fetchPokemonByAbility('overgrow')).called(1);
      expect(controller.isLoading.value, isFalse);
      expect(controller.pokemons, fakePokemons);
    });

    test(
        'Should pokemons correctly when getPokemonByType is called',
        () async {
      final fakePokemons = [PokemonModel(name: 'Charmander', url: '')];

      when(() => repository.fetchPokemonByType('fire'))
          .thenAnswer((_) async => fakePokemons);

      controller = FilteredListPokemonController(repository);

      final future = controller.getPokemonByType('fire');
      expect(controller.isLoading.value, isTrue);

      await future;

      expect(controller.isLoading.value, isFalse);
      expect(controller.pokemons, fakePokemons);
      verify(() => repository.fetchPokemonByType('fire')).called(1);
    });

    test(
        'Should pokemons correctly when getPokemonByAbility is called',
        () async {
      final fakePokemons = [PokemonModel(name: 'Gengar', url: '')];

      when(() => repository.fetchPokemonByAbility('levitate'))
          .thenAnswer((_) async => fakePokemons);

      controller = FilteredListPokemonController(repository);

      final future = controller.getPokemonByAbility('levitate');
      expect(controller.isLoading.value, isTrue);

      await future;

      expect(controller.isLoading.value, isFalse);
      expect(controller.pokemons, fakePokemons);
      verify(() => repository.fetchPokemonByAbility('levitate')).called(1);
    });
  });
}
