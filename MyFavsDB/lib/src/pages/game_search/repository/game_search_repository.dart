import 'package:myfavsdb/src/constants/endoints.dart';
import 'package:myfavsdb/src/models/game_search_result.dart';
import 'package:myfavsdb/src/services/http_manager.dart';

class GameSearchRepository {
  final HttpManager _httpManager = HttpManager();

  Future<List<GameSearchResult>> searchGames(String query) async {
    try {
      final result = await _httpManager.get('${Endpoints.searchGames}?query=$query');
      
      if (result?.statusCode == 200 && result?.data != null) {
        final List<dynamic> gamesList = result!.data;
        return gamesList.map((game) => GameSearchResult.fromMap(game)).toList();
      }
      
      return [];
    } catch (e) {
      print('Erro ao buscar jogos: $e');
      return [];
    }
  }
} 