import 'package:myfavsdb/src/constants/endoints.dart';
import 'package:myfavsdb/src/models/response_model.dart';
import 'package:myfavsdb/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  Future<ResponseRequest> login({
    required String email,
    required String password,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.login,
      method: HttpMethods.post,
      body: {
        "username": email,
        "password": password
      }
    );

    return ResponseRequest.fromMap(result?.data);
  }
}
