import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfavsdb/src/pages/home/components/category_tile.dart';
import 'package:myfavsdb/src/config/app_data.dart' as app_data;
import 'package:myfavsdb/src/pages/home/components/item_tile.dart';
import 'package:myfavsdb/src/pages/home/controller/home_controller.dart';

import '../../pages_routes/app_pages.dart';
import '../common_widgets/custom_shimmer.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //AppBar
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 30,
              ),
              children: [
                TextSpan(
                    text: 'Tag',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                TextSpan(
                    text: 'Me',
                    style: TextStyle(
                      color: Colors.purple,
                    )),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            //Campo Pesquisa
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 20,
            //     vertical: 10,
            //   ),
            //   child: TextFormField(
            //     decoration: InputDecoration(
            //       filled: true,
            //       fillColor: Colors.white,
            //       isDense: true,
            //       hintText: 'Search here...',
            //       hintStyle: TextStyle(
            //         color: Colors.grey.shade400,
            //         fontSize: 14,
            //       ),
            //       prefixIcon: const Icon(Icons.search),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(60),
            //         borderSide: const BorderSide(
            //           width: 0,
            //           style: BorderStyle.none,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            //Categorias
            GetBuilder<HomeController>(builder: (controller) {
              return Container(
                padding: const EdgeInsets.only(left: 25),
                height: 40,
                child: !controller.isLoading
                    ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return CategoryTile(
                            onPressed: () {
                              controller.selectCategory(
                                  controller.allCategories[index]);
                            },
                            category: controller.allCategories[index].title,
                            isSelected: controller.allCategories[index] ==
                                controller.currentCategory,
                          );
                        },
                        separatorBuilder: (_, index) =>
                            const SizedBox(width: 10),
                        itemCount: controller.allCategories.length,
                      )
                    : ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          10,
                          (index) => Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(right: 12),
                            child: CustomShimmer(
                              height: 20,
                              width: 80,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
              );
            }),

            //Grid
            GetBuilder<HomeController>(builder: (controller) {
              return Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 9 / 11.5,
                  ),
                  itemCount: controller.allItems.length,
                  itemBuilder: (_, index) {
                    return ItemTile(
                      item: controller.allItems[index],
                    );
                  },
                ),
              );
            })
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Get.toNamed(PagesRoutes.addRoute);
            // Força atualização quando retorna da tela de adicionar
            final homeController = Get.find<HomeController>();
            await homeController.refreshCurrentCategory();
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ));
  }
}
