import 'package:diet_app_mobile/product/init/application_initialize.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


void main() async{
 await InitProject().initProject();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: NavigatorRoutes.init,
      getPages: NavigatorRoutes().routes,
      debugShowCheckedModeBanner: false,
      // unknownRoute: GetPage(
      //   name: NavigateRoutesItems.unknown.withSlash,
      //   page: () => const UnknownScreen(),
      // ),
     
    );
  }
}
