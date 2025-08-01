import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfavsdb/src/pages/auth/controller/auth_controller.dart';
import 'package:myfavsdb/src/pages_routes/app_pages.dart';

void main() {
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        scaffoldBackgroundColor: Colors.white.withAlpha(190),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: PagesRoutes.loginRoute,
      getPages: AppPages.pages,
    );
  }
}
