import 'package:get/get.dart';
import 'package:myfavsdb/src/models/game_search_result.dart';
import 'package:myfavsdb/src/pages/game_search/repository/game_search_repository.dart';

class GameSearchController extends GetxController {
  final GameSearchRepository _repository = GameSearchRepository();
  
  final RxList<GameSearchResult> searchResults = <GameSearchResult>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  Future<void> searchGames(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      return;
    }

    isLoading.value = true;
    searchQuery.value = query;

    try {
      final results = await _repository.searchGames(query);
      searchResults.value = results;
    } catch (e) {
      print('Erro no controller de busca de jogos: $e');
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