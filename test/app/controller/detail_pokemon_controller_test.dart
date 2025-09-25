import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mottu/app/controller/detail_pokemon_controller.dart';
import 'package:mottu/app/data/i_pokemon_repository.dart';
import 'package:mottu/app/data/pokemon_detail_model.dart';

class MockPokemonRepository extends Mock implements IPokemonRepository {}

void main() {
  late DetailPokemonController controller;
  late MockPokemonRepository repository;

  setUp(() {
    repository = MockPokemonRepository();
    controller = DetailPokemonController(repository);
  });

  group('DetailPokemonController Tests', () {
    test('should start with null pokemon, not loading and no error', () {
      expect(controller.pokemon.value, isNull);
      expect(controller.isLoading.value, false);
      expect(controller.hasError.value, '');
    });

    test('should fetch pokemon detail successfully', () async {
      final pokemonDetail = PokemonDetailModel(
        name: 'Pikachu',
        abilities: [],
        baseExperience: null,
        forms: [],
        gameIndices: [],
        height: null,
        heldItems: [],
        id: null,
        isDefault: null,
        locationAreaEncounters: '',
        moves: [],
        order: null,
        pastAbilities: [],
        pastTypes: [],
        species: null,
        sprites: null,
        stats: [],
        types: [],
        weight: null,
      );
      when(() => repository.fetchPokemonDetail('Pikachu'))
          .thenAnswer((_) async => pokemonDetail);

      await controller.fetchPokemonDetail('Pikachu');

      expect(controller.isLoading.value, false);
      expect(controller.pokemon.value, equals(pokemonDetail));
      expect(controller.hasError.value, '');
      verify(() => repository.fetchPokemonDetail('Pikachu')).called(1);
    });
  });
}
