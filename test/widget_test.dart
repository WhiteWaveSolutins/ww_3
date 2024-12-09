import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MyWidget', () {
    testWidgets('should display a string of text', (WidgetTester tester) async {
      // Define a Widget

      // Build myWidget and trigger a frame

      // Verify myWidget shows some text
      expect(find.byType(Text), findsOneWidget);
    });
  });
}
