import 'package:get/get.dart';
import 'package:myfavsdb/src/pages/adicionar/repository/adicionar_repository.dart';

import '../../../models/response_model.dart';
import '../../auth/controller/auth_controller.dart';
import '../../home/controller/home_controller.dart';

class AdicionarController extends GetxController {

  RxBool isLoading = false.obs;
  final addRepository = AdicionarRepository();
  final authController = Get.find<AuthController>();
  final homeController = Get.find<HomeController>();

  // Item selecionado reativo
  Rxn<Map<String, dynamic>> selectedItem = Rxn<Map<String, dynamic>>();

  void setSelectedItem(Map<String, dynamic> item) {
    selectedItem.value = item;
  }

  Future<ResponseRequest> adicionarItem({
    required String title,
    required String myRating,
    required String opinion,
    required int categoryId,
    required String imgUrl,
  }) async {
    isLoading.value = true;

    Map<String, dynamic> body = {
      'title': title,
      'myRating': myRating,
      'opinion': opinion,
      'categoryId': categoryId,
      'imgUrl': imgUrl,
      'username': authController.rxEmail.value,
      'password': authController.rxPassword.value,
    };

    ResponseRequest response = await addRepository.adicionar(body);

    isLoading.value = false;

    // Atualiza a lista de itens na home após adicionar
    if (response.statusCode == 200) {
      // Força atualização da categoria atual
      await homeController.refreshCurrentCategory();
    }

    return response;
  }

}