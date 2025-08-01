import 'package:myfavsdb/src/constants/endoints.dart';
import 'package:myfavsdb/src/models/response_model.dart';
import 'package:myfavsdb/src/services/http_manager.dart';

class ItemRepository {
  final HttpManager _httpManager = HttpManager();

  Future<ResponseRequest> updateItem({
    required int itemId,
    required String title,
    required String myRating,
    required String opinion,
    required int categoryId,
    required String imgUrl,
    required String username,
    required String password,
  }) async {
    final result = await _httpManager.restRequest(
      url: '${Endpoints.updateItem}/$itemId',
      method: HttpMethods.put,
      body: {
        'title': title,
        'myRating': myRating,
        'opinion': opinion,
        'categoryId': categoryId,
        'imgUrl': imgUrl,
        'username': username,
        'password': password,
      },
    );

    return ResponseRequest.fromMap(result?.data);
  }

  Future<ResponseRequest> deleteItem({
    required int itemId,
    required String username,
    required String password,
  }) async {
    final result = await _httpManager.restRequest(
      url: '${Endpoints.deleteItem}/$itemId?username=$username&password=$password',
      method: HttpMethods.delete,
    );

    return ResponseRequest.fromMap(result?.data);
  }
} 