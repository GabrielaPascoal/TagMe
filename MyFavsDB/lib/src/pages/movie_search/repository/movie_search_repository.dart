import 'package:myfavsdb/src/constants/endoints.dart';
import 'package:myfavsdb/src/models/movie_search_result.dart';
import 'package:myfavsdb/src/services/http_manager.dart';

class MovieSearchRepository {
  final HttpManager _httpManager = HttpManager();

  Future<List<MovieSearchResult>> searchMovies(String query) async {
    try {
      final result = await _httpManager.restRequest(
        url: '${Endpoints.searchMovies}?query=${Uri.encodeComponent(query)}',
        method: HttpMethods.get,
      );

      if (result?.statusCode == 200 && result?.data != null) {
        final List<MovieSearchResult> movies = [];
        final data = result?.data as List;

        for (var item in data) {
          try {
            final movie = MovieSearchResult.fromMap(item);
            movies.add(movie);
          } catch (e) {
            print('Erro ao processar filme: $e');
          }
        }

        return movies;
      } else {
        return [];
      }
    } catch (e) {
      print('Erro na busca de filmes: $e');
      return [];
    }
  }
} 