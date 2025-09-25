import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/list_pokemon_controller.dart';
import 'widgets/pokemon_tile.dart';

class ListPokemonPage extends StatelessWidget {
  const ListPokemonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ListPokemonController>();
    return Material(
      child: Obx(
        () => _buildPokemonList(controller),
      ),
    );
  }

  Widget _buildPokemonList(ListPokemonController controller) {
    return ListView.builder(
      itemCount: controller.pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = controller.pokemons[index];
        return PokemonTile(pokemon: pokemon);
      },
    );
  }
}
