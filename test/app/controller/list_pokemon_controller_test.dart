import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mottu/app/controller/list_pokemon_controller.dart';
import 'package:mottu/app/data/i_pokemon_repository.dart';
import 'package:mottu/app/data/pokemon_model.dart';

class MockPokemonRepository extends Mock implements IPokemonRepository {}

void main() {
  late MockPokemonRepository repository;
  late ListPokemonController controller;

  setUp(() {
    repository = MockPokemonRepository();
    Get.testMode = true;
  });

  group('ListPokemonController', () {
    test('Should fetch initial pokemons on init', () async {
      final firstBatch = [
        PokemonModel(name: 'Pikachu', url: ''),
        PokemonModel(name: 'Charmander', url: ''),
      ];

      when(() => repository.fetchPokemons(offset: 0))
          .thenAnswer((_) async => firstBatch);

      controller = ListPokemonController(repository);

      controller.onInit();
      await Future.delayed(Duration.zero);

      verify(() => repository.fetchPokemons(offset: 0)).called(1);
      expect(controller.pokemons, firstBatch);
      expect(controller.offset, firstBatch.length);
    });

    test(
        'Should reset offset and load first batch when fetchPokemons is called',
        () async {
      final batch = [
        PokemonModel(name: 'Bulbasaur', url: ''),
      ];

      when(() => repository.fetchPokemons(offset: any(named: 'offset')))
          .thenAnswer((_) async => batch);

      controller = ListPokemonController(repository);

      await controller.fetchPokemons();

      expect(controller.offset, batch.length);
      expect(controller.pokemons, batch);
    });

    test('Should append pokemons when loadMorePokemons is called', () async {
      final firstBatch = [PokemonModel(name: 'Eevee', url: '')];
      final secondBatch = [PokemonModel(name: 'Snorlax', url: '')];

      when(() => repository.fetchPokemons(offset: 0))
          .thenAnswer((_) async => firstBatch);
      when(() => repository.fetchPokemons(offset: 1))
          .thenAnswer((_) async => secondBatch);

      controller = ListPokemonController(repository);

      await controller.fetchPokemons();
      expect(controller.pokemons, firstBatch);

      await controller.loadMorePokemons();
      expect(controller.pokemons, [...firstBatch, ...secondBatch]);
      expect(controller.offset, 2);
    });

    test('loadMorePokemons não deve buscar se já estiver carregando', () async {
      final batch = [PokemonModel(name: 'Ditto', url: '')];

      when(() => repository.fetchPokemons(offset: any(named: 'offset')))
          .thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 50));
        return batch;
      });

      controller = ListPokemonController(repository);

      controller.isLoading.value = true;

      await controller.loadMorePokemons();

      verifyNever(() => repository.fetchPokemons(offset: any(named: 'offset')));
    });

    test('getPokemonByAbility deve sobrescrever lista', () async {
      final abilityBatch = [
        PokemonModel(name: 'Gengar', url: ''),
      ];

      when(() => repository.fetchPokemonByAbility('levitate'))
          .thenAnswer((_) async => abilityBatch);

      controller = ListPokemonController(repository);

      await controller.getPokemonByAbility('levitate');

      expect(controller.pokemons, abilityBatch);
      verify(() => repository.fetchPokemonByAbility('levitate')).called(1);
    });

    test('getPokemonByType deve sobrescrever lista', () async {
      final typeBatch = [
        PokemonModel(name: 'Squirtle', url: ''),
      ];

      when(() => repository.fetchPokemonByType('water'))
          .thenAnswer((_) async => typeBatch);

      controller = ListPokemonController(repository);

      await controller.getPokemonByType('water');

      expect(controller.pokemons, typeBatch);
      verify(() => repository.fetchPokemonByType('water')).called(1);
    });

    test('searchPokemons deve filtrar lista por nome', () async {
      controller = ListPokemonController(repository);

      controller.pokemons.assignAll([
        PokemonModel(name: 'Pikachu', url: ''),
        PokemonModel(name: 'Bulbasaur', url: ''),
      ]);

      controller.searchPokemons('pika');
      await Future.delayed(
        const Duration(milliseconds: 550),
      );

      expect(controller.pokemons.length, 1);
      expect(controller.pokemons.first.name, 'Pikachu');
    });

    test('searchPokemons com string vazia deve chamar fetchPokemons', () async {
      final batch = [PokemonModel(name: 'Charmander', url: '')];

      when(() => repository.fetchPokemons(offset: 0))
          .thenAnswer((_) async => batch);

      controller = ListPokemonController(repository);

      controller.searchPokemons('');
      await Future.delayed(
        const Duration(milliseconds: 550),
      );
      expect(controller.pokemons, batch);
      verify(() => repository.fetchPokemons(offset: 0)).called(1);
    });

    test('searchPokemons should debounce calls', () async {
      final initialPokemons = [
        PokemonModel(name: 'Pikachu', url: ''),
        PokemonModel(name: 'Charmander', url: ''),
        PokemonModel(name: 'Bulbasaur', url: ''),
      ];

      when(() => repository.fetchPokemons(offset: 0))
          .thenAnswer((_) async => initialPokemons);

      controller = ListPokemonController(repository);
      controller.onInit();
      await Future.delayed(Duration.zero);

      expect(controller.pokemons.length, initialPokemons.length);

      controller.searchPokemons('p');
      controller.searchPokemons('pi');
      controller.searchPokemons('pik');

      expect(controller.pokemons.length, initialPokemons.length);

      await Future.delayed(const Duration(milliseconds: 550));

      expect(controller.pokemons.length, 1);
      expect(controller.pokemons.first.name, 'Pikachu');

      verify(() => repository.fetchPokemons(offset: 0)).called(1);
    });
  });
}
