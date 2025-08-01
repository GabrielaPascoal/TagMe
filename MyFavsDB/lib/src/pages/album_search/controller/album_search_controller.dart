import 'package:get/get.dart';
import 'package:myfavsdb/src/models/album_search_result.dart';
import 'package:myfavsdb/src/pages/album_search/repository/album_search_repository.dart';

class AlbumSearchController extends GetxController {
  final AlbumSearchRepository _repository = AlbumSearchRepository();
  
  final RxList<AlbumSearchResult> searchResults = <AlbumSearchResult>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  Future<void> searchAlbums(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      return;
    }

    isLoading.value = true;
    searchQuery.value = query;

    try {
      final results = await _repository.searchAlbums(query);
      searchResults.value = results;
    } catch (e) {
      print('Erro no controller de busca de álbuns: $e');
      searchResults.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void clearSearch() {
    searchResults.clear();
    searchQuery.value = '';
  }
} 