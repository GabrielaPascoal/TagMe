import 'dart:convert';

import 'package:get/get.dart';
import 'package:myfavsdb/src/constants/endoints.dart';
import 'package:myfavsdb/src/models/category_model.dart';
import 'package:myfavsdb/src/models/item_model.dart';
import 'package:myfavsdb/src/pages/auth/controller/auth_controller.dart';
import 'package:myfavsdb/src/services/http_manager.dart';

class HomeRepository {
  final HttpManager _httpManager = HttpManager();

  Future<List<CategoryModel>> getAllCategories() async {
    final result = await _httpManager.restRequest(
      url: Endpoints.categories,
      method: HttpMethods.get,
    );

    if(result?.statusCode == 200) {
      final List<CategoryModel> categories = [];
      final data = result?.data;

      data.forEach((item) {
        try {
          final CategoryModel category =  CategoryModel.fromMap(item);
          categories.add(category);
        } catch (e) {}
      });

      return categories;
    } else {
      throw Exception('Não foi possível buscar.');
    }
  }

  Future<List<ItemModel>> getAllItems(Map<String, dynamic> body) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getItemsByCategory,
      method: HttpMethods.post,
      body: body
    );

    if(result?.statusCode == 200) {
      final List<ItemModel> items = [];
      final data = result?.data;

      data.forEach((item) {
        try {
          final ItemModel element =  ItemModel.fromMap(item);
          items.add(element);
        } catch (e) {}
      });

      return items;
    } else {
      throw Exception('Não foi possível buscar.');
    }
  }


}
