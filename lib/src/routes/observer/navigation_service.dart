import 'package:ai_translator/src/routes/observer/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TranslatorNavigationService {
  const TranslatorNavigationService();

  static GlobalKey<NavigatorState>? get navigatorKey => Get.key;

  static GlobalKey<NavigatorState>? nestedNavigationKey(int index) =>
      Get.nestedKey(index);

  static NavigatorObserver get routeObserver => TranslatorRouteObserver();
}
