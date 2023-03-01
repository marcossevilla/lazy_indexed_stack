import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension AppTester on WidgetTester {
  Future<void> pumpApp(
    Widget widgetUnderTest, [
    Duration? duration,
    EnginePhase phase = EnginePhase.sendSemanticsUpdate,
  ]) async {
    await pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: widgetUnderTest,
        ),
      ),
    );
    await pump(duration, phase);
  }
}
