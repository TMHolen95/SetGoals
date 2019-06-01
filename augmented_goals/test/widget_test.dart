// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:augmented_goals/widgets/content_creation/create_goal.dart';
import 'package:augmented_goals/main.dart';
import 'package:augmented_goals/widgets/content_creation/util/position_selection_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:image_test_utils/image_test_utils.dart';

void main() {

  Widget testableWidget({Widget child}){
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('My App - Home Page', (WidgetTester tester) async {
    /*Widget home = testableWidget(child: HomePage(userPosition: testPos,));
    await tester.pumpWidget(home);*/

    provideMockedNetworkImages(() async {
      Widget form = MyApp();
      await tester.pumpWidget(form);
      await tester.tap(find.byIcon(Icons.home));
      await tester.pump();
      expect(find.text('Home Feed'), findsOneWidget);
      expect(find.text('Goal Feed'), findsNothing);
      await tester.tap(find.byIcon(Icons.assignment));
      await tester.pump();
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

  });

  testWidgets('Create Goal - Functioning', (WidgetTester tester) async {
    Widget form = MaterialApp(home: CreateGoalForm());
    await tester.pumpWidget(form);
    expect(find.text('Create Goal'), findsOneWidget);
  });

  testWidgets('Create Goal: MapWidget Functioning', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    provideMockedNetworkImages(() async {
      Widget form = testableWidget(child: PositionSelectionMap());
      await tester.pumpWidget(form);
    });
  });
}
