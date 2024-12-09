import 'package:ai_translator/src/routes/observer/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TranslatorNavigationService {
  const TranslatorNavigationService();

  /// Returns the [Get.key] value to be set in the applications navigation
  static GlobalKey<NavigatorState>? get navigatorKey => Get.key;

  /// Creates and/or returns a new navigator key based on the index passed in
  static GlobalKey<NavigatorState>? nestedNavigationKey(int index) =>
      Get.nestedKey(index);

  /// Returns the [GetObserver] to be passed through navigatorObservers in MaterialApp to use all the functionalities
  static NavigatorObserver get routeObserver => TranslatorRouteObserver();
}
