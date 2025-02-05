import 'package:flutter/material.dart';
import 'package:flutter_practicle/constant/app_preference.dart';
import 'package:get/get.dart';

import 'constant/app_routes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreference().initPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: _setNavigation(),
      getPages: AppRoutes.routes,
    );
  }

  _setNavigation() {
    if(AppPreference().isLogin){
      return Routes.listing;
    }
    else{
      return Routes.login;
    }
  }
}

