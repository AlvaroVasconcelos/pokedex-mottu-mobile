import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/list_pokemon_controller.dart';
import 'widgets/pokemon_tile.dart';

class ListPokemonPage extends StatefulWidget {
  const ListPokemonPage({super.key});

  @override
  State<ListPokemonPage> createState() => _ListPokemonPageState();
}

class _ListPokemonPageState extends State<ListPokemonPage> {
  final ScrollController _scrollController = ScrollController();
  final ListPokemonController controller = Get.find<ListPokemonController>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        controller.loadMorePokemons();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
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
          Expanded(
            child: Obx(() {
              if (controller.pokemons.isEmpty && controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                controller: _scrollController,
                itemCount: controller.pokemons.length + 1,
                itemBuilder: (context, index) {
                  if (index < controller.pokemons.length) {
                    return PokemonTile(pokemon: controller.pokemons[index]);
                  } else {
                    return Obx(() {
                      return controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : const SizedBox.shrink();
                    });
                  }
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
