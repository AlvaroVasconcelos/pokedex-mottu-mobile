import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/detail_pokemon_controller.dart';
import '../../data/pokemon_model.dart';

class PokemonTile extends StatefulWidget {
  const PokemonTile({required this.pokemon, super.key});
  final PokemonModel pokemon;

  @override
  State<PokemonTile> createState() => _PokemonTileState();
}

class _PokemonTileState extends State<PokemonTile> {
  final controller = DetailPokemonController(Get.find());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchPokemonDetail(widget.pokemon.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: ListTile(
          onTap: () {
            Get.toNamed(
              '/detail',
              arguments: widget.pokemon.name,
            );
          },
          title: Text(widget.pokemon.name),
          leading: Obx(
            () {
              return CircleAvatar(
                backgroundImage: NetworkImage(
                  controller.pokemon.value?.sprites?.frontDefault ??
                      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/0.png',
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
