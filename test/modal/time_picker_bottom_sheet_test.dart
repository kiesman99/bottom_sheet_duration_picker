import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picky/picky.dart';
import 'package:picky/src/globals/keys.dart';

void main() {
  group('visual', () {
    testWidgets('Picker Contains every Button', (tester) async {
      BuildContext savedContext;

      var button1Finder = find.text('1');
      var button2Finder = find.text('2');
      var button3Finder = find.text('3');
      var button4Finder = find.text('4');
      var button5Finder = find.text('5');
      var button6Finder = find.text('6');
      var button7Finder = find.text('7');
      var button8Finder = find.text('8');
      var button9Finder = find.text('9');
      var button0Finder = find.text('0');
      var buttonDeleteFinder = find.byIcon(Icons.backspace);
      var buttonCheckFinder = find.byIcon(Icons.check);
      expect(button1Finder, findsNothing);
      expect(button2Finder, findsNothing);
      expect(button3Finder, findsNothing);
      expect(button4Finder, findsNothing);
      expect(button5Finder, findsNothing);
      expect(button6Finder, findsNothing);
      expect(button7Finder, findsNothing);
      expect(button8Finder, findsNothing);
      expect(button9Finder, findsNothing);
      expect(button0Finder, findsNothing);
      expect(buttonDeleteFinder, findsNothing);
      expect(buttonCheckFinder, findsNothing);

      var result;

      // load the widget
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) {
            savedContext = context;
            return Container();
          },
        ),
      ));
      expect(result, null);

      await tester.pump();
      expect(find.byKey(pickerLabelKey), findsNothing);

      result = showDurationPickerBottomSheet(
          context: savedContext, label: 'Test Picker');

      await tester.pumpAndSettle();
      expect(find.text('Test Picker'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
      expect(find.text('6'), findsOneWidget);
      expect(find.text('7'), findsOneWidget);
      expect(find.text('8'), findsOneWidget);
      expect(find.text('9'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
      expect(find.byIcon(Icons.backspace), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('tapping outside the Picker dismisses it by default',
        (tester) async {
      BuildContext savedContext;

      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) {
            savedContext = context;
            return Container();
          },
        ),
      ));

      await tester.pump();
      expect(find.text('Test Picker'), findsNothing);

      showDurationPickerBottomSheet(
          context: savedContext, label: 'Test Picker');

      await tester.pumpAndSettle();
      expect(find.text('Test Picker'), findsOneWidget);

      // tap outside bottomsheet to dismiss
      await tester.tapAt(const Offset(20.0, 20.0));
      await tester.pumpAndSettle();
      expect(find.text('Test Picker'), findsNothing);
    });

    testWidgets(
        'tapping outside the Picker does not dismiss'
        'when isDismissible is false', (tester) async {
      BuildContext savedContext;

      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) {
            savedContext = context;
            return Container();
          },
        ),
      ));

      await tester.pump();
      expect(find.text('Test Picker'), findsNothing);

      showDurationPickerBottomSheet(
          context: savedContext, label: 'Test Picker', isDismissible: false);

      await tester.pumpAndSettle();
      expect(find.text('Test Picker'), findsOneWidget);

      // tap outside bottomsheet to dismiss
      await tester.tapAt(const Offset(20.0, 20.0));
      await tester.pumpAndSettle();
      expect(find.text('Test Picker'), findsOneWidget);
    });

    testWidgets('Swiping down the Picker dismisses it by default',
        (tester) async {
      BuildContext savedContext;

      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) {
            savedContext = context;
            return Container();
          },
        ),
      ));

      await tester.pump();
      expect(find.text('Test Picker'), findsNothing);

      showDurationPickerBottomSheet(
          context: savedContext, label: 'Test Picker');

      await tester.pumpAndSettle();
      expect(find.text('Test Picker'), findsOneWidget);

      // drag bottomsheet down to dismiss
      await tester.tapAt(const Offset(20.0, 20.0));
      await tester.drag(find.text('Test Picker'), const Offset(0.0, 150.0));
      await tester.pumpAndSettle();
      expect(find.text('Test Picker'), findsNothing);
    });

    testWidgets(
        'Swiping down the Picker does not dismiss the picker if'
        'enableDrag=false', (tester) async {
      BuildContext savedContext;

      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) {
            savedContext = context;
            return Container();
          },
        ),
      ));

      await tester.pump();
      expect(find.text('Test Picker'), findsNothing);

      showDurationPickerBottomSheet(
          context: savedContext,
          label: 'Test Picker',
          enableDrag: false,
          isDismissible: false);

      await tester.pumpAndSettle();
      expect(find.text('Test Picker'), findsOneWidget);

      // drag bottomsheet down to dismiss
      await tester.tapAt(const Offset(20.0, 20.0));
      await tester.drag(find.text('Test Picker'), const Offset(0.0, 150.0));
      await tester.pumpAndSettle();
      expect(find.text('Test Picker'), findsOneWidget);
    });
  });

  group('functional', () {
    testWidgets('Tapping Numbers changes result', (tester) async {
      BuildContext savedContext;
      Future<Duration> result;

      // load the widget
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) {
            savedContext = context;
            return Container();
          },
        ),
      ));
      expect(result, null);

      await tester.pump();
      expect(find.byKey(pickerLabelKey), findsNothing);

      result = showDurationPickerBottomSheet(
          context: savedContext, label: 'Test Picker');

      await tester.pumpAndSettle();

      expect(find.text('Test Picker'), findsOneWidget);

      var button1Finder = find.text('1');
      var button2Finder = find.text('2');
      var button0Finder = find.text('0');
      var buttonDeleteFinder = find.byIcon(Icons.backspace);
      var buttonCheckFinder = find.byIcon(Icons.check);
      expect(button1Finder, findsOneWidget);
      expect(button2Finder, findsOneWidget);
      expect(button0Finder, findsOneWidget);
      expect(buttonDeleteFinder, findsOneWidget);
      expect(buttonCheckFinder, findsOneWidget);

      await tester.tap(button1Finder);
      await tester.tap(button0Finder);
      await tester.tap(buttonDeleteFinder);
      await tester.tap(button2Finder);
      await tester.tap(buttonCheckFinder);

      await tester.pumpAndSettle();

      // after check is pressed the sheet should dismiss
      expect(find.text('Test Picker'), findsNothing);
      expect(await result, equals(Duration(seconds: 12)));
    });
  });
}
