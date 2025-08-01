import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myfavsdb/src/pages/item/item_screen.dart';
import 'package:myfavsdb/src/pages/item/view/edit_item_screen.dart';
import 'package:myfavsdb/src/pages/item/controller/item_controller.dart';
import 'package:myfavsdb/src/services/utils_services.dart';

import '../../../models/item_model.dart';
import '../../../pages_routes/app_pages.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    super.key,
    required this.item,
  });

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    final itemController = Get.put(ItemController());
    final utilsServices = UtilsServices();

    //Conteúdo
    return GestureDetector(
      onTap: () {
        Get.toNamed(PagesRoutes.detail, arguments: item);
      },
      onLongPress: () {
        _showOptionsDialog(context, itemController, utilsServices);
      },
      child: Card(
        elevation: 1,
        shadowColor: Colors.grey.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              //Expanded(child: Image.asset(item.imgUrl)),
              Expanded(
                child: Hero(
                  tag: item.imgUrl,
                  child: Image.network(
                    item.imgUrl,
                  ),
                ),
              ),

              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context, ItemController itemController, UtilsServices utilsServices) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(item.title),
          content: const Text('O que você gostaria de fazer?'),
          actions: [
                         TextButton(
               onPressed: () {
                 Navigator.of(context).pop();
                 Get.toNamed(PagesRoutes.editItem, arguments: item);
               },
               child: const Text('Editar'),
             ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showDeleteConfirmation(context, itemController, utilsServices);
              },
              child: const Text('Remover'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, ItemController itemController, UtilsServices utilsServices) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: Text('Tem certeza que deseja remover "${item.title}"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final response = await itemController.deleteItem(item.id);
                if (response.statusCode == 200) {
                  utilsServices.showToast(message: 'Item removido com sucesso!');
                } else {
                  utilsServices.showToast(
                    message: response.returnMsg,
                    isError: true,
                  );
                }
              },
              child: const Text('Remover'),
            ),
          ],
        );
      },
    );
  }
}
