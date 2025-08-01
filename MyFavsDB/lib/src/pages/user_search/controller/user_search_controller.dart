import 'package:get/get.dart';
import 'package:myfavsdb/src/models/user_search_result.dart';
import 'package:myfavsdb/src/pages/user_search/repository/user_search_repository.dart';

class UserSearchController extends GetxController {
  final UserSearchRepository _repository = UserSearchRepository();
  
  final RxList<UserSearchResult> searchResults = <UserSearchResult>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  Future<void> searchUsers(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      return;
    }

    isLoading.value = true;
    searchQuery.value = query;

    try {
      final results = await _repository.searchUsers(query);
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
} 