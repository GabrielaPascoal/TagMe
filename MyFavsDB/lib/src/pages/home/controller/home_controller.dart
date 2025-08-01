import 'package:get/get.dart';
import 'package:myfavsdb/src/models/category_model.dart';
import 'package:myfavsdb/src/models/item_model.dart';
import 'package:myfavsdb/src/pages/home/repository/home_repository.dart';

import '../../auth/controller/auth_controller.dart';

class HomeController extends GetxController {

  final homeRepository = HomeRepository();
  final authController = Get.find<AuthController>();

  List<CategoryModel> allCategories = [];
  List<ItemModel> allItemsByCategory = [];
  bool isLoading = false;
  CategoryModel? currentCategory;
  List<ItemModel> get allItems => currentCategory?.items ?? [];

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();

    getAllItems();
  }

  @override
  void onInit() {
    super.onInit();
    getAllCategories();
  }

  Future<void> getAllCategories() async {
    setLoading(true);
    allCategories = await homeRepository.getAllCategories();
    setLoading(false);

    if(allCategories.isEmpty) return;

    selectCategory(allCategories.first);
  }

  Future<void> getAllItems() async {
    setLoading(true);

    Map<String, dynamic> body = {
      'username': authController.rxEmail.value,
      'password': authController.rxPassword.value,
      'categoryId': currentCategory?.id
    };

    currentCategory?.items = await homeRepository.getAllItems(body);
    setLoading(false);
  }

  // Método para forçar atualização da UI
  void refreshItems() {
    update();
  }

  // Método para atualizar itens da categoria atual
  Future<void> refreshCurrentCategory() async {
    if (currentCategory != null) {
      await getAllItems();
    }
  }
}