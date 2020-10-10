import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:picky/picky.dart';
import 'package:picky/src/widgets/numpad.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  DurationPickerController controller;
  MockBuildContext mockContext;
  Widget testNumpad;

  setUp(() {
    controller = DurationPickerController();
    mockContext = MockBuildContext();
    testNumpad = _TestWrapper(
      child: Numpad(context: mockContext, controller: controller),
    );
  });

  testWidgets('every button is provided in numpad', (tester) async {
    await tester.pumpWidget(testNumpad);
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
    final buttonDeleteFinder = find.byIcon(Icons.backspace);
    final buttonCheckFinder = find.byIcon(Icons.check);

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
    expect(buttonDeleteFinder, findsOneWidget);
    expect(buttonCheckFinder, findsOneWidget);
  });

  group('click on numpad elements', () {
    testWidgets('Clicking on one Tiles changes controller value',
        (tester) async {
      await tester.pumpWidget(testNumpad);
      expect(controller.value, equals(Duration.zero));

      final button1Finder = find.text("1");
      await tester.tap(button1Finder);
      await tester.pump();
      expect(controller.value, equals(Duration(seconds: 1)));
    });

    testWidgets('Clicking multiple Tiles changes controller value',
        (tester) async {
      await tester.pumpWidget(testNumpad);
      expect(controller.value, equals(Duration.zero));

      final button1Finder = find.text("1");
      final button4Finder = find.text("4");
      final button7Finder = find.text("7");
      await tester.tap(button1Finder);
      await tester.tap(button4Finder);
      await tester.tap(button7Finder);
      await tester.pump();
      expect(controller.value, equals(Duration(minutes: 1, seconds: 47)));
    });

    testWidgets('Pressing backspace does delete last number', (tester) async {
      await tester.pumpWidget(testNumpad);
      expect(controller.value, equals(Duration.zero));

      final button1Finder = find.text("1");
      final button4Finder = find.text("4");
      final button7Finder = find.text("7");
      final buttonDeleteFinder = find.byIcon(Icons.backspace);
      await tester.tap(button1Finder);
      await tester.tap(button4Finder);
      await tester.tap(buttonDeleteFinder);
      await tester.tap(button7Finder);
      await tester.pump();
      expect(controller.value, equals(Duration(seconds: 17)));
    });
  });

  group('send key events through keyboard', () {
    testWidgets('entering one number does change controller value',
        (tester) async {
      await tester.pumpWidget(testNumpad);
      expect(controller.value, equals(Duration.zero));
      await tester.sendKeyEvent(LogicalKeyboardKey.digit1);
      await tester.pump();
      expect(controller.value, equals(Duration(seconds: 1)));
    }, skip: true);
  }, skip: true);
}

class _TestWrapper extends StatelessWidget {
  _TestWrapper({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }
}
