import 'package:example/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_indexed_stack/lazy_indexed_stack.dart';

import 'helpers/helpers.dart';

void main() {
  group('ExampleApp', () {
    testWidgets('renders ExampleHomePage', (tester) async {
      await tester.pumpWidget(const ExampleApp());
      await tester.pump(ExamplePage.displayTimeDelay);

      expect(find.byType(ExampleHomePage), findsOneWidget);
    });
  });

  group('ExampleHomePage', () {
    const homePageTitle = 'Example';

    testWidgets(
      'renders LazyIndexedStack with one example page by default',
      (tester) async {
        await tester.pumpApp(const ExampleHomePage(title: homePageTitle));
        await tester.pump(ExamplePage.displayTimeDelay);

        expect(find.text(homePageTitle), findsOneWidget);
        expect(find.byType(LazyIndexedStack), findsOneWidget);
        expect(find.byType(ExamplePage), findsOneWidget);
        expect(find.byType(BottomNavigationBar), findsOneWidget);
      },
    );

    testWidgets('changes index and renders a new example page', (tester) async {
      await tester.pumpApp(const ExampleHomePage(title: homePageTitle));
      await tester.pump(ExamplePage.displayTimeDelay);
      await tester.tap(find.byIcon(Icons.filter_3));
      await tester.pumpAndSettle();

      expect(find.byType(ExamplePage), findsNWidgets(2));
    });
  });

  group('ExamplePage', () {
    testWidgets('renders correct index', (tester) async {
      const index = 1;
      await tester.pumpApp(const ExamplePage(index: index));
      await tester.pump(ExamplePage.displayTimeDelay);

      expect(find.text('This is page $index'), findsOneWidget);
    });
  });
}
