import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/list_pokemon_controller.dart';
import 'widgets/pokemon_tile.dart';

class ListPokemonPageType extends StatefulWidget {
  const ListPokemonPageType({super.key, this.type = 'fire'});
  final String type;

  @override
  State<ListPokemonPageType> createState() => _ListPokemonPageState();
}

class _ListPokemonPageState extends State<ListPokemonPageType> {
  final controller = ListPokemonController(Get.find());
  @override
  void initState() {
    super.initState();
    controller.getPokemonByType(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon by Type: ${widget.type}'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.98,
            child: TextFormField(
              onChanged: controller.searchPokemons,
              decoration: InputDecoration(
                hintText: 'Search Pokémon',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
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
