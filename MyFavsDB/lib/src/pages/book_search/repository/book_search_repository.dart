import 'package:myfavsdb/src/constants/endoints.dart';
import 'package:myfavsdb/src/models/book_search_result.dart';
import 'package:myfavsdb/src/services/http_manager.dart';

class BookSearchRepository {
  final HttpManager _httpManager = HttpManager();

  Future<List<BookSearchResult>> searchBooks(String query) async {
    try {
      final result = await _httpManager.get('${Endpoints.searchBooks}?query=$query');
      
      if (result?.statusCode == 200 && result?.data != null) {
        final List<dynamic> booksList = result!.data;
        return booksList.map((book) => BookSearchResult.fromMap(book)).toList();
      }
      
      return [];
    } catch (e) {
      print('Erro ao buscar livros: $e');
      return [];
    }
  }
} 