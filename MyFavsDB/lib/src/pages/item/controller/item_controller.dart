import 'package:get/get.dart';
import 'package:myfavsdb/src/models/response_model.dart';
import 'package:myfavsdb/src/pages/item/repository/item_repository.dart';
import 'package:myfavsdb/src/pages/auth/controller/auth_controller.dart';
import 'package:myfavsdb/src/pages/home/controller/home_controller.dart';

class ItemController extends GetxController {
  final ItemRepository _itemRepository = ItemRepository();
  final AuthController _authController = Get.find<AuthController>();
  final HomeController _homeController = Get.find<HomeController>();

  RxBool isLoading = false.obs;

  Future<ResponseRequest> updateItem({
    required int itemId,
    required String title,
    required String myRating,
    required String opinion,
    required int categoryId,
    required String imgUrl,
  }) async {
    isLoading.value = true;

    final response = await _itemRepository.updateItem(
      itemId: itemId,
      title: title,
      myRating: myRating,
      opinion: opinion,
      categoryId: categoryId,
      imgUrl: imgUrl,
      username: _authController.rxEmail.value,
      password: _authController.rxPassword.value,
    );

    isLoading.value = false;

    // Atualiza a lista de itens na home após editar
    if (response.statusCode == 200) {
      await _homeController.refreshCurrentCategory();
    }

    return response;
  }

  Future<ResponseRequest> deleteItem(int itemId) async {
    isLoading.value = true;

    final response = await _itemRepository.deleteItem(
      itemId: itemId,
      username: _authController.rxEmail.value,
      password: _authController.rxPassword.value,
    );

    isLoading.value = false;

    // Atualiza a lista de itens na home após remover
    if (response.statusCode == 200) {
      await _homeController.refreshCurrentCategory();
    }

    return response;
  }
} 