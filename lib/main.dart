import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
    SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
