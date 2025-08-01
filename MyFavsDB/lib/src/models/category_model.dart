import 'item_model.dart';

class CategoryModel {
  String title;
  int id;
  List<ItemModel> items = [];

  CategoryModel({
    required this.title,
    required this.id,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      title: map['title'],
    );
  }
}
