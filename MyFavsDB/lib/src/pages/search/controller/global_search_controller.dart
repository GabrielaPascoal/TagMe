import 'dart:async';
import 'package:get/get.dart';
import 'package:myfavsdb/src/models/item_model.dart';
import 'package:myfavsdb/src/pages/auth/controller/auth_controller.dart';
import 'package:myfavsdb/src/pages/search/repository/search_repository.dart';

class GlobalSearchController extends GetxController {
  final SearchRepository _searchRepository = SearchRepository();
  final AuthController _authController = Get.find<AuthController>();

  final RxList<ItemModel> searchResults = <ItemModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  // Debounce para evitar muitas requisições
  Timer? _debounceTimer;

  void onSearchChanged(String query) {
    searchQuery.value = query;
    
    // Cancela o timer anterior
    _debounceTimer?.cancel();
    
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    // Aguarda 500ms antes de fazer a busca
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      performSearch(query);
    });
  }

  Future<void> performSearch(String query) async {
    if (query.isEmpty) return;

    isLoading.value = true;
    
    try {
      final results = await _searchRepository.globalSearch(
        query,
        _authController.rxEmail.value,
        _authController.rxPassword.value,
      );
      
      searchResults.value = results;
    } catch (e) {
      print('Erro na busca: $e');
      searchResults.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void clearSearch() {
    searchQuery.value = '';
    searchResults.clear();
    _debounceTimer?.cancel();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }
} 