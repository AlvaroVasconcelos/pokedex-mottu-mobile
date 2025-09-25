import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/filtered_list_pokemon_controller.dart';
import 'widgets/pokemon_tile.dart';

class FilteredListPokemonPage extends StatelessWidget {
  const FilteredListPokemonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilteredListPokemonController>();
    final title = Get.arguments['filter'] as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pokémons with ${title[0].toUpperCase()}${title.substring(1)}',
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.pokemons.isEmpty) {
          return const Center(child: Text('No Pokémon found.'));
        }

        return ListView.builder(
          itemCount: controller.pokemons.length,
          itemBuilder: (context, index) {
            final pokemon = controller.pokemons[index];
            return PokemonTile(pokemon: pokemon);
          },
        );
      }),
    );
  }
}
