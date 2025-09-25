import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/detail_pokemon_controller.dart';
import '../data/pokemon_detail_model.dart';
import '../data/pokemon_model.dart';

class DetailPokemonPage extends StatelessWidget {
  const DetailPokemonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DetailPokemonController>();

    return Scaffold(
      appBar: AppBar(
        title: Text((Get.arguments as PokemonModel).name),
        centerTitle: true,
      ),
      body: Obx(() => _buildBody(controller, context)),
    );
  }

  Widget _buildBody(DetailPokemonController controller, BuildContext context) {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.hasError.value.isNotEmpty) {
      return Center(child: Text(controller.hasError.value));
    }

    if (controller.pokemon.value == null) {
      return const Center(child: Text('No Pokemon data'));
    }

    return _buildPokemonDetails(controller.pokemon.value!, context);
  }

  Widget _buildPokemonDetails(
    PokemonDetailModel pokemon,
    BuildContext context,
  ) {
    return Center(
      child: Column(
        children: [
          Center(
            child: Image.network(
              pokemon.sprites?.frontDefault ?? '',
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.5,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 20),
          Text('Name: ${pokemon.name}'),
          Text('Height: ${pokemon.height}'),
          Text('Weight: ${pokemon.weight}'),
        ],
      ),
    );
  }
}
