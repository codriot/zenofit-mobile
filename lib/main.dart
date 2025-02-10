import 'package:diet_app_mobile/bindings/initial_binding.dart';
import 'package:diet_app_mobile/product/init/application_initialize.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  await InitProject().initProject();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme(context).theme,
      initialRoute: NavigatorRoutes.init,
      getPages: NavigatorRoutes().routes,
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      // unknownRoute: GetPage(
      //   name: NavigateRoutesItems.unknown.withSlash,
      //   page: () => const UnknownScreen(),
      // ),
    );
  }
}
