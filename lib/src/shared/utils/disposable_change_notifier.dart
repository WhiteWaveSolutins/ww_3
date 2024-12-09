import 'package:flutter/cupertino.dart';

abstract class DisposableChangeNotifier extends ChangeNotifier {
  void disposeValues();
}
