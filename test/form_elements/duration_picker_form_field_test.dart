import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picky/picky.dart';

void main() {
  const formFieldLabel = 'Sample Form Picker';
  var formFieldButtonFinder = find.text(formFieldLabel);

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

  testWidgets('elements are visible', (tester) async {
    await tester.pumpWidget(_Wrapper(DurationPickerFormField(
      title: formFieldLabel,
    )));

    await tester.pump();

    expect(find.text(formFieldLabel), findsOneWidget);
    expect(find.text('00h00m00s'), findsOneWidget);

    await tester.tap(formFieldButtonFinder);
    await tester.pumpAndSettle();

    expect(find.text(formFieldLabel), findsNWidgets(2));
    expect(find.text('00h00m00s'), findsNWidgets(2));
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

  testWidgets('controller gets updated by form', (tester) async {
    var controller = DurationPickerController();

    await tester.pumpWidget(_Wrapper(DurationPickerFormField(
      title: formFieldLabel,
      controller: controller,
    )));
    await tester.pump();

    await tester.tap(formFieldButtonFinder);
    await tester.pumpAndSettle();

    expect(controller.value, equals(Duration.zero));

    await tester.tap(button2Finder);
    await tester.tap(button7Finder);
    await tester.pumpAndSettle();

    expect(find.text('00h00m27s'), findsOneWidget);
    expect(controller.value, equals(Duration.zero));

    await tester.tap(buttonCheckFinder);
    await tester.pumpAndSettle();

    expect(controller.value, equals(Duration(seconds: 27)));
  });

  testWidgets('validation triggers', (tester) async {
    var controller = DurationPickerController();
    const errorText = 'More than 27 seconds';

    await tester.pumpWidget(_Wrapper(DurationPickerFormField(
      title: formFieldLabel,
      controller: controller,
      autovalidateMode: AutovalidateMode.always,
      validator: (duration) {
        if (duration.compareTo(Duration(seconds: 27)) == 1) {
          return errorText;
        }

        return "";
      },
    )));
    await tester.pump();

    expect(find.text(errorText), findsNothing);
    await tester.tap(formFieldButtonFinder);
    await tester.pumpAndSettle();
    expect(find.text(errorText), findsNothing);

    await tester.tap(button2Finder);
    await tester.tap(button7Finder);
    await tester.tap(buttonCheckFinder);
    await tester.pumpAndSettle();
    expect(find.text('00h00m27s'), findsOneWidget);
    expect(find.text(errorText), findsNothing);
    expect(controller.value, equals(Duration(seconds: 27)));

    await tester.tap(formFieldButtonFinder);
    await tester.pumpAndSettle();
    await tester.tap(button2Finder);
    await tester.tap(button8Finder);
    await tester.tap(buttonCheckFinder);
    await tester.pumpAndSettle();
    expect(find.text('00h00m28s'), findsOneWidget);
    expect(find.text(errorText), findsOneWidget);
    expect(controller.value, equals(Duration(seconds: 28)));
  });

  testWidgets('form field uses custom formatter', (tester) async {
    var controller = DurationPickerController();

    await tester.pumpWidget(_Wrapper(DurationPickerFormField(
      title: formFieldLabel,
      controller: controller,
      labelBuilder: (duration) => "${duration.inSeconds}s",
    )));
    await tester.pump();

    expect(find.text('0s'), findsOneWidget);

    await tester.tap(formFieldButtonFinder);
    await tester.pumpAndSettle();

    expect(controller.value, equals(Duration.zero));

    await tester.tap(button3Finder);
    await tester.tap(button4Finder);
    await tester.pumpAndSettle();

    expect(controller.value, equals(Duration.zero));

    await tester.tap(buttonCheckFinder);
    await tester.pumpAndSettle();

    expect(find.text('34s'), findsOneWidget);
    expect(controller.value, equals(Duration(seconds: 34)));
  });

  testWidgets("onTap get's called by pressing on Form element", (tester) async {
    var controller = DurationPickerController();
    var tapCounter = 0;
    await tester.pumpWidget(_Wrapper(DurationPickerFormField(
      title: formFieldLabel,
      controller: controller,
      onTap: () => tapCounter++,
    )));
    await tester.pump();

    expect(tapCounter, equals(0));

    await tester.tap(formFieldButtonFinder);
    await tester.pumpAndSettle();

    expect(tapCounter, equals(1));

    await tester.tap(buttonCheckFinder);
    await tester.pumpAndSettle();

    expect(tapCounter, equals(1));

    await tester.tap(formFieldButtonFinder);
    await tester.pumpAndSettle();

    expect(tapCounter, equals(2));

    await tester.tap(button1Finder);
    await tester.tap(button1Finder);
    await tester.tap(buttonCheckFinder);
    await tester.pumpAndSettle();

    expect(controller.value, equals(Duration(seconds: 11)));
    expect(tapCounter, equals(2));
  });
}

class _Wrapper extends StatelessWidget {
  final DurationPickerFormField durationPickerFormField;
  _Wrapper(this.durationPickerFormField);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Form(
          child: durationPickerFormField,
        )),
      ),
    );
  }
}
