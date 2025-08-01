import 'package:myfavsdb/src/constants/endoints.dart';
import 'package:myfavsdb/src/models/item_model.dart';
import 'package:myfavsdb/src/services/http_manager.dart';

class SearchRepository {
  final HttpManager _httpManager = HttpManager();

  Future<List<ItemModel>> globalSearch(String query, String username, String password) async {
    final result = await _httpManager.get(
      '${Endpoints.globalSearch}?query=$query&username=$username&password=$password',
    );

    if (result != null && result.statusCode == 200) {
      final List<dynamic> itemsList = result.data;
      return itemsList.map((item) => ItemModel.fromMap(item)).toList();
    }

    return [];
  }
} 