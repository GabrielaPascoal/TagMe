import 'package:myfavsdb/src/constants/endoints.dart';
import 'package:myfavsdb/src/models/response_model.dart';
import 'package:myfavsdb/src/services/http_manager.dart';

class AdicionarRepository {
  final HttpManager _httpManager = HttpManager();

  Future<ResponseRequest> adicionar(Map<String, dynamic> body) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.addItem,
      method: HttpMethods.post,
      body: body
    );

    return ResponseRequest.fromMap(result?.data);
  }
}
