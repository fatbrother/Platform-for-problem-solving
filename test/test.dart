import 'package:flutter_test/flutter_test.dart';
import 'package:pops/main.dart';

void main() {
  testWidgets('log in test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    
  });
}
