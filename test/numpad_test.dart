import 'package:bottom_sheet_duration_picker/src/controller/numpad/numpad_controller.dart';
import 'package:bottom_sheet_duration_picker/src/widgets/numpad.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockBuildContext extends Mock implements BuildContext {}

class MockNumpadController extends Mock implements NumpadController {}

void main() {
  Widget scaffoldContainer({Widget child}) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }

  testWidgets('Numpad has 12 grid items', (tester) async {
    var context = MockBuildContext();
    await tester.pumpWidget(scaffoldContainer(child: Numpad(context: context)));
    final button1Finder = find.text('1');
    final button2Finder = find.text('2');
    final button3Finder = find.text('3');
    final button4Finder = find.text('4');
    final button5Finder = find.text('5');
    final button6Finder = find.text('6');
    final button7Finder = find.text('7');
    final button8Finder = find.text('8');
    final button9Finder = find.text('9');
    final button0Finder = find.text('0');

    expect(button1Finder, findsOneWidget);
    expect(button2Finder, findsOneWidget);
    expect(button3Finder, findsOneWidget);
    expect(button4Finder, findsOneWidget);
    expect(button5Finder, findsOneWidget);
    expect(button6Finder, findsOneWidget);
    expect(button7Finder, findsOneWidget);
    expect(button8Finder, findsOneWidget);
    expect(button9Finder, findsOneWidget);
    expect(button0Finder, findsOneWidget);
  });

  testWidgets('controller gets changed when fields are pressed',
      (tester) async {
    var context = MockBuildContext();
    var controller = NumpadController();
    await tester.pumpWidget(scaffoldContainer(
        child: Numpad(context: context, controller: controller)));

    expect(controller.duration, Duration.zero);
    final button1Finder = find.text("1");
    await tester.tap(button1Finder);
    await tester.pump();
    expect(controller.duration, equals(Duration(seconds: 1)));
  });
}
