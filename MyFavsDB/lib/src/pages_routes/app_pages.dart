import 'package:get/get.dart';
import 'package:myfavsdb/src/pages/adicionar/adicionar.dart';

import 'package:myfavsdb/src/pages/base/base_screen.dart';
import 'package:myfavsdb/src/pages/home/binding/home_binding.dart';
import 'package:myfavsdb/src/pages/home/home_tab.dart';
import 'package:myfavsdb/src/pages/auth/view/login.dart';
import 'package:myfavsdb/src/pages/item/item_screen.dart';
import 'package:myfavsdb/src/pages/item/view/edit_item_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      page: () => LoginScreen(),
      name: PagesRoutes.loginRoute
    ),

    GetPage(
        page: () => const HomeTab(),
        name: PagesRoutes.homeRoute
    ),

    GetPage(
        page: () => AdicionarScreen(),
        name: PagesRoutes.addRoute
    ),

    GetPage(
        page: () => ItemScreen(),
        name: PagesRoutes.detail
    ),

    GetPage(
        page: () => EditItemScreen(item: Get.arguments),
        name: PagesRoutes.editItem
    ),

    GetPage(
        page: () => const BaseScreen(),
        name: PagesRoutes.baseRoute,
        bindings: [
          HomeBinding(),
        ]
    )
  ];
}

abstract class PagesRoutes {
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String addRoute = '/add';
  static const String baseRoute = '/';
  static const String detail = '/detail';
  static const String editItem = '/edit-item';

}