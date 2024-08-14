import 'package:ecommerce_app/src/app/app.dart';
import 'package:ecommerce_app/src/features/login/presentation/pages/get_started.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(GetStartedPage), findsOneWidget);
    });
  });
}
