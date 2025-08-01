import 'package:myfavsdb/src/constants/endoints.dart';
import 'package:myfavsdb/src/models/album_search_result.dart';
import 'package:myfavsdb/src/services/http_manager.dart';

class AlbumSearchRepository {
  final HttpManager _httpManager = HttpManager();

  Future<List<AlbumSearchResult>> searchAlbums(String query) async {
    try {
      final result = await _httpManager.get('${Endpoints.searchAlbums}?query=$query');
      
      if (result?.statusCode == 200 && result?.data != null) {
        final List<dynamic> albumsList = result!.data;
        return albumsList.map((album) => AlbumSearchResult.fromMap(album)).toList();
      }
      
      return [];
    } catch (e) {
      print('Erro ao buscar álbuns: $e');
      return [];
    }
  }
} 