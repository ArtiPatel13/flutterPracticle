

import 'package:flutter_practicle/ui/details_page.dart';
import 'package:flutter_practicle/ui/filter_screen.dart';
import 'package:flutter_practicle/ui/listing_page.dart';
import 'package:flutter_practicle/ui/login_screen.dart';
import 'package:get/get.dart';


class AppRoutes {
  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.listing,
      page: () => ListingPage(),
    ),
    GetPage(
      name: Routes.filter,
      page: () =>  FilterScreen(callback: Get.arguments[0],filterModel: Get.arguments[1],
        reset: Get.arguments[2],),
    ),
    GetPage(
      name: Routes.details,
      page: () =>  DetailsPage(id: Get.arguments[0],),
    ),

  ];
}

abstract class Routes {
  static const login = '/login';
  static const listing = '/listing';
  static const details = '/details';
  static const filter = '/filter';
}
