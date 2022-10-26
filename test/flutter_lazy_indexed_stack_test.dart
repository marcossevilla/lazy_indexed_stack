// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:flutter_test/flutter_test.dart';

extension AppTester on WidgetTester {
  Future<void> bootstrap(Widget widgetUnderTest) async {
    await pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: widgetUnderTest,
        ),
      ),
    );
  }
}

void main() {
  group('LazyIndexedStack', () {
    test('can be instantiated', () {
      expect(LazyIndexedStack(), isNotNull);
    });

    testWidgets('only renders default index', (tester) async {
      const lazyIndexedStackKey = Key('lazyIndexedStackKey');

      await tester.bootstrap(
        LazyIndexedStack(
          key: lazyIndexedStackKey,
          children: const [
            Text('page1'),
            Text('page2'),
            Text('page3'),
          ],
        ),
      );

      expect(find.byKey(lazyIndexedStackKey), findsOneWidget);
      expect(find.text('page1'), findsOneWidget);
      expect(find.text('page2'), findsNothing);
      expect(find.text('page3'), findsNothing);
    });

    testWidgets(
      'changes current index and renders activated children',
      (tester) async {
        var index = 0;

        await tester.bootstrap(
          StatefulBuilder(
            builder: (context, setState) {
              return LazyIndexedStack(
                index: index,
                children: [
                  ElevatedButton(
                    child: Text('page1'),
                    onPressed: () => setState(() => index++),
                  ),
                  Text('page2'),
                ],
              );
            },
          ),
        );
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        expect(find.text('page1'), findsOneWidget);
        expect(find.text('page2'), findsOneWidget);
        expect(find.text('page3'), findsNothing);
      },
    );
  });
}
