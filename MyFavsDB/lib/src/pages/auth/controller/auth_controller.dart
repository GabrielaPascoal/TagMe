import 'package:get/get.dart';
import 'package:myfavsdb/src/models/response_model.dart';
import 'package:myfavsdb/src/pages/auth/repository/auth_repository.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxString rxEmail = ''.obs;
  RxString rxPassword = ''.obs;

  final authRepository = AuthRepository();

  Future<ResponseRequest> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    rxEmail.value = email;
    rxPassword.value = password;

    ResponseRequest response = await authRepository.login(email: email, password: password);

    isLoading.value = false;

    return response;
  }
}
