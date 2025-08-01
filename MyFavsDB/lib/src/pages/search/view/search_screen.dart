import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfavsdb/src/pages/home/components/item_tile.dart';
import 'package:myfavsdb/src/pages/common_widgets/custom_shimmer.dart';
import 'package:myfavsdb/src/pages/common_widgets/search_bar_widget.dart';
import 'package:myfavsdb/src/pages/common_widgets/empty_state_widget.dart';

import '../controller/global_search_controller.dart' as search;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textController = TextEditingController();
  late final search.GlobalSearchController searchController;

  @override
  void initState() {
    super.initState();
    searchController = Get.put(search.GlobalSearchController());
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Buscar',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Barra de pesquisa padronizada
          SearchBarWidget(
            controller: _textController,
            hintText: 'Buscar em todos os itens...',
            onChanged: searchController.onSearchChanged,
            onClear: searchController.clearSearch,
          ),
          
          // Resultados da busca
          Expanded(
            child: Obx(() {
              if (searchController.isLoading.value) {
                return _buildLoadingState();
              }
              
              if (searchController.searchQuery.value.isEmpty) {
                return _buildEmptyState();
              }
              
              if (searchController.searchResults.isEmpty) {
                return _buildNoResultsState();
              }
              
              return _buildResultsList();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: const CustomShimmer(
          width: double.infinity,
          height: 100,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const EmptyStateWidget(
      icon: Icons.search,
      title: 'Digite algo para buscar',
      subtitle: 'Busque por filmes, séries, livros, álbuns e jogos',
    );
  }

  Widget _buildNoResultsState() {
    return const EmptyStateWidget(
      icon: Icons.search_off,
      title: 'Nenhum resultado encontrado',
      subtitle: 'Tente usar termos diferentes',
    );
  }

  Widget _buildResultsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            '${searchController.searchResults.length} resultado(s) encontrado(s)',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: searchController.searchResults.length,
            itemBuilder: (context, index) {
              final item = searchController.searchResults[index];
              return ItemTile(item: item);
            },
          ),
        ),
      ],
    );
  }
} 