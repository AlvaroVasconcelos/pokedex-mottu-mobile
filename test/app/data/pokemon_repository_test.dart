import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mottu/app/data/i_pokemon_repository.dart';
import 'package:mottu/app/data/pokemon_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockDio extends Mock implements Dio {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late IPokemonRepository sut;
  late MockDio dio;

  setUp(() {
    dio = MockDio();
    sut = PokemonRepository(dio);
    SharedPreferences.setMockInitialValues({});
  });

  group('PokemonRepository', () {
    group('fetchPokemons', () {
      test('should return a list of PokemonModel on success', () async {
        when(
          () => dio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: {
              'results': [
                {
                  'name': 'bulbasaur',
                  'url': 'https://pokeapi.co/api/v2/pokemon/1/',
                },
                {
                  'name': 'ivysaur',
                  'url': 'https://pokeapi.co/api/v2/pokemon/2/',
                },
              ],
            },
            statusCode: 200,
          ),
        );

        final result = await sut.fetchPokemons();

        expect(result.length, 2);
        expect(result[0].name, 'bulbasaur');
      });

      test('should throw an exception on failure', () async {
        when(
          () => dio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

        expect(() => sut.fetchPokemons(), throwsA(isA<DioException>()));
      });
    });

    group('fetchPokemonDetail', () {
      test('should return a PokemonDetailModel on success', () async {
        when(() => dio.get(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: {
              'abilities': [],
              'base_experience': 64,
              'forms': [],
              'game_indices': [],
              'height': 7,
              'held_items': [],
              'id': 1,
              'is_default': true,
              'location_area_encounters': '',
              'moves': [],
              'name': 'bulbasaur',
              'order': 1,
              'past_abilities': [],
              'past_types': [],
              'species': {'name': 'bulbasaur', 'url': ''},
              'sprites': {
                'back_default': '',
                'back_female': null,
                'back_shiny': '',
                'back_shiny_female': null,
                'front_default': '',
                'front_female': null,
                'front_shiny': '',
                'front_shiny_female': null,
              },
              'stats': [],
              'types': [],
              'weight': 69,
            },
            statusCode: 200,
          ),
        );

        final result = await sut.fetchPokemonDetail('bulbasaur');

        expect(result.name, 'bulbasaur');
        expect(result.height, 7);
        expect(result.weight, 69);
      });

      test('should throw an exception on failure', () async {
        when(() => dio.get(any()))
            .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

        expect(
          () => sut.fetchPokemonDetail('bulbasaur'),
          throwsA(isA<DioException>()),
        );
      });
    });

    group('fetchPokemonByType', () {
      test('should return a list of PokemonModel on success', () async {
        when(
          () => dio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: {
              'pokemon': [
                {
                  'pokemon': {
                    'name': 'bulbasaur',
                    'url': 'https://pokeapi.co/api/v2/pokemon/1/',
                  },
                },
              ],
            },
            statusCode: 200,
          ),
        );

        final result = await sut.fetchPokemonByType('grass');

        expect(result.length, 1);
        expect(result[0].name, 'bulbasaur');
      });

      test('should throw an exception on failure', () async {
        when(
          () => dio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenThrow(Exception());

        expect(
          () => sut.fetchPokemonByType('grass'),
          throwsA(
            isA<Exception>(),
          ),
        );
      });
    });

    group('fetchPokemonByAbility', () {
      test('should return a list of PokemonModel on success', () async {
        when(() => dio.get(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: {
              'pokemon': [
                {
                  'pokemon': {
                    'name': 'bulbasaur',
                    'url': 'https://pokeapi.co/api/v2/pokemon/1/',
                  },
                },
              ],
            },
            statusCode: 200,
          ),
        );

        final result = await sut.fetchPokemonByAbility('overgrow');

        expect(result.length, 1);
        expect(result[0].name, 'bulbasaur');
      });

      test('should throw an exception on failure', () async {
        when(() => dio.get(any())).thenThrow(Exception());

        expect(
          () => sut.fetchPokemonByAbility('overgrow'),
          throwsA(
            isA<Exception>(),
          ),
        );
      });
    });
  });
}
