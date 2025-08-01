import 'package:get/get.dart';
import 'package:myfavsdb/src/models/movie_search_result.dart';
import 'package:myfavsdb/src/pages/movie_search/repository/movie_search_repository.dart';

class MovieSearchController extends GetxController {
  final MovieSearchRepository _repository = MovieSearchRepository();
  
  final RxList<MovieSearchResult> searchResults = <MovieSearchResult>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  Future<void> searchMovies(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      return;
    }

    isLoading.value = true;
    searchQuery.value = query;

    try {
      final results = await _repository.searchMovies(query);
      searchResults.value = results;
    } catch (e) {
      print('Erro na busca: $e');
      searchResults.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void clearSearch() {
    searchResults.clear();
    searchQuery.value = '';
  }

  MovieSearchResult? getSelectedMovie(int index) {
    if (index >= 0 && index < searchResults.length) {
      return searchResults[index];
    }
    return null;
  }
} 