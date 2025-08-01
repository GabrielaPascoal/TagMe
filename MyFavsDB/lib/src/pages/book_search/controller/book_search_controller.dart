import 'package:get/get.dart';
import 'package:myfavsdb/src/models/book_search_result.dart';
import 'package:myfavsdb/src/pages/book_search/repository/book_search_repository.dart';

class BookSearchController extends GetxController {
  final BookSearchRepository _repository = BookSearchRepository();
  
  final RxList<BookSearchResult> searchResults = <BookSearchResult>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  Future<void> searchBooks(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      return;
    }

    isLoading.value = true;
    searchQuery.value = query;

    try {
      final results = await _repository.searchBooks(query);
      searchResults.value = results;
    } catch (e) {
      print('Erro no controller de busca de livros: $e');
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