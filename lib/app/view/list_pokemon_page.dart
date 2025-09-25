import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/list_pokemon_controller.dart';
import 'widgets/pokemon_tile.dart';

class ListPokemonPage extends StatelessWidget {
  const ListPokemonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ListPokemonController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              onChanged: (name) {
                if (name.isNotEmpty) {
                  controller.searchPokemons(name);
                } else {
                  controller.fetchPokemons();
                }
              },
            ),
          ),
          Obx(
            () {
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.pokemons.length,
                  itemBuilder: (context, index) {
                    final pokemon = controller.pokemons[index];
                    return PokemonTile(pokemon: pokemon);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
