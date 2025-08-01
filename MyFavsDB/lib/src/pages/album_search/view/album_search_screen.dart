import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfavsdb/src/pages/common_widgets/custom_shimmer.dart';
import 'package:myfavsdb/src/pages/album_search/controller/album_search_controller.dart';

class AlbumSearchScreen extends StatefulWidget {
  const AlbumSearchScreen({Key? key}) : super(key: key);

  @override
  State<AlbumSearchScreen> createState() => _AlbumSearchScreenState();
}

class _AlbumSearchScreenState extends State<AlbumSearchScreen> {
  final AlbumSearchController controller = Get.put(AlbumSearchController());
  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      controller.searchAlbums(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Álbuns'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Digite o nome do álbum...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    controller.clearSearch();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: const CustomShimmer(
                      width: double.infinity,
                      height: 100,
                    ),
                  ),
                );
              }

              if (controller.searchResults.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.album,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        controller.searchQuery.value.isEmpty
                            ? 'Digite o nome de um álbum para buscar'
                            : 'Nenhum álbum encontrado',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                itemCount: controller.searchResults.length,
                itemBuilder: (context, index) {
                  final album = controller.searchResults[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: album.fullImageUrl.isNotEmpty
                            ? Image.network(
                                album.fullImageUrl,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 60,
                                    height: 60,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.album),
                                  );
                                },
                              )
                            : Container(
                                width: 60,
                                height: 60,
                                color: Colors.grey[300],
                                child: const Icon(Icons.album),
                              ),
                      ),
                      title: Text(
                        album.collectionName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (album.artistName.isNotEmpty)
                            Text('Artista: ${album.artistName}'),
                          if (album.displayReleaseDate.isNotEmpty)
                            Text('Ano: ${album.displayReleaseDate}'),
                          if (album.displayTrackCount.isNotEmpty)
                            Text('${album.displayTrackCount}'),
                          if (album.primaryGenreName.isNotEmpty)
                            Text('Gênero: ${album.primaryGenreName}'),
                          if (album.displayPrice.isNotEmpty)
                            Text('Preço: ${album.displayPrice}'),
                        ],
                      ),
                      onTap: () {
                        Navigator.pop(context, {
                          'title': album.collectionName,
                          'imgUrl': album.fullImageUrl,
                          'overview': '${album.artistName} - ${album.displayTrackCount}',
                        });
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
} 