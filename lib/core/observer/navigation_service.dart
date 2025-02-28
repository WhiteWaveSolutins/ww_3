import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'observer.dart';

class TranslatorNavigationService {
  const TranslatorNavigationService();

  static GlobalKey<NavigatorState>? get navigatorKey => Get.key;

  static GlobalKey<NavigatorState>? nestedNavigationKey(int index) =>
      Get.nestedKey(index);

  static NavigatorObserver get routeObserver => TranslatorRouteObserver();
}
