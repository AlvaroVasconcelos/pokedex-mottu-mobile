import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/detail_pokemon_controller.dart';
import '../data/pokemon_detail_model.dart';

class DetailPokemonPage extends StatefulWidget {
  const DetailPokemonPage({super.key});

  @override
  State<DetailPokemonPage> createState() => _DetailPokemonPageState();
}

class _DetailPokemonPageState extends State<DetailPokemonPage> {
  final controller = Get.find<DetailPokemonController>();
  @override
  void initState() {
    super.initState();
    controller.fetchPokemonByName(Get.arguments as String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments as String),
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
    return SingleChildScrollView(
      child: Center(
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
            const SizedBox(height: 20),
            _buildSectionTitle('Types'),
            Wrap(
              spacing: 8,
              children: pokemon.types
                  .map(
                    (type) => GestureDetector(
                      onTap: () => _navigateToFilteredList(
                        type.type.name,
                        'type',
                      ),
                      child: _buildInfoChip(type.type.name),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Abilities'),
            Wrap(
              spacing: 8,
              children: pokemon.abilities
                  .map(
                    (ability) => GestureDetector(
                      onTap: () => _navigateToFilteredList(
                        ability.ability?.name ?? '',
                        'ability',
                      ),
                      child: _buildInfoChip(ability.ability?.name ?? ''),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToFilteredList(String filter, String filterType) {
    Get.toNamed(
      '/filtered-list',
      arguments: {
        'filter': filter,
        'filterType': filterType,
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInfoChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.blue.shade100,
    );
  }
}
