import 'package:get/get.dart';
import 'package:myfavsdb/src/models/user_search_result.dart';
import 'package:myfavsdb/src/pages/user_search/repository/user_search_repository.dart';

class UserProfileController extends GetxController {
  final UserSearchRepository _repository = UserSearchRepository();
  
  final Rx<UserProfileResult?> profile = Rx<UserProfileResult?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> loadUserProfile(String email) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await _repository.getUserProfile(email);
      if (result != null) {
        profile.value = result;
      } else {
        errorMessage.value = 'Usuário não encontrado';
      }
    } catch (e) {
      errorMessage.value = 'Erro ao carregar perfil: $e';
    } finally {
      isLoading.value = false;
    }
  }
} 