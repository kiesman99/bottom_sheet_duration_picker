import 'package:flutter_test/flutter_test.dart';
import 'package:picky/src/controller/numpad/numpad_controller.dart';
import 'package:picky/src/controller/numpad/numpad_value.dart';

void main() {
  group('Initialisation and getting duration', () {
    test('NumpadController initialized', () {
      var controller = NumpadController();
      expect(controller.value.duration, Duration.zero);
    });

    test('given duration zero', () {
      var controller1 =
          NumpadController.initial(value: NumpadValue(digits: ""));
      var controller2 =
          NumpadController.initial(value: NumpadValue(digits: "000000"));
      var controller3 = NumpadController.initial(value: NumpadValue.empty());
      expect(controller1.value.duration, Duration.zero);
      expect(controller2.value.duration, Duration.zero);
      expect(controller3.value.duration, Duration.zero);
    });

    void _givenDurationMatchesGetDuration(String digits, Duration d) {
      var controller =
          NumpadController.initial(value: NumpadValue(digits: digits));
      expect(controller.value.duration, d);
    }

    test('duration only seconds', () {
      _givenDurationMatchesGetDuration("001", Duration(seconds: 1));
      _givenDurationMatchesGetDuration("1", Duration(seconds: 1));
      _givenDurationMatchesGetDuration("55", Duration(seconds: 55));
    });

    test('duration only minutes', () {
      _givenDurationMatchesGetDuration("5000", Duration(minutes: 50));
      _givenDurationMatchesGetDuration("0500", Duration(minutes: 5));
    });

    test('duration only hours', () {
      _givenDurationMatchesGetDuration("170000", Duration(hours: 17));
      _givenDurationMatchesGetDuration("070000", Duration(hours: 7));
      _givenDurationMatchesGetDuration(
          "173419", Duration(hours: 17, minutes: 34, seconds: 19));
    });

    test('duration seconds bigger than 60', () {
      var controller =
          NumpadController.initial(value: NumpadValue(digits: "88"));
      expect(controller.value.duration, Duration(minutes: 1, seconds: 28));
    });

    test('duration minutes bigger than 60', () {
      var controller =
          NumpadController.initial(value: NumpadValue(digits: "7200"));
      expect(controller.value.duration, Duration(hours: 1, minutes: 12));
    });

    test('duration hours bigger than 24', () {
      var controller =
          NumpadController.initial(value: NumpadValue(digits: "720000"));
      expect(controller.value.duration, Duration(hours: 72));
    });

    test('duration is exact 24 hours', () {
      var controller =
          NumpadController.initial(value: NumpadValue(digits: "240000"));
      expect(controller.value.duration, Duration(hours: 24));
    });

    test('duration seconds, minutes bigger than 60, hours bigger 24', () {
      var controller =
          NumpadController.initial(value: NumpadValue(digits: "487277"));
      expect(controller.value.duration,
          Duration(hours: 48, minutes: 72, seconds: 77));
    });
  });

  group('inserting a number', () {
    test('insert number higher than 9', () {
      var controller =
          NumpadController.initial(value: NumpadValue(digits: "5500"));

      expect(() {
        controller.insert(10);
      }, throwsAssertionError);
    });

    void _expectInsert(
        {String initial, int insert, Duration expectedDuration}) {
      var controller =
          NumpadController.initial(value: NumpadValue(digits: initial));
      controller.insert(insert);
      expect(controller.value.duration, equals(expectedDuration));
    }

    test('insert number to seconds', () {
      _expectInsert(
          initial: "1",
          insert: 7,
          expectedDuration: const Duration(seconds: 17));
      _expectInsert(
          initial: "19",
          insert: 7,
          expectedDuration: const Duration(minutes: 2, seconds: 37));
    });

    test('insert number to minutes', () {
      _expectInsert(
          initial: "5500",
          insert: 1,
          expectedDuration: const Duration(hours: 5, minutes: 50, seconds: 1));

      _expectInsert(
          initial: "0400",
          insert: 2,
          expectedDuration: const Duration(minutes: 40, seconds: 2));
    });

    test('insert number to hours', () {
      _expectInsert(
          initial: "10000",
          insert: 4,
          expectedDuration: const Duration(hours: 10, seconds: 4));

      _expectInsert(
          initial: "12200",
          insert: 4,
          expectedDuration: const Duration(hours: 12, minutes: 20, seconds: 4));

      _expectInsert(
          initial: "240000",
          insert: 7,
          expectedDuration: const Duration(hours: 24));
    });
  });

  group('remove last element', () {
    void _expectRemove({String initial, Duration expectedDuration}) {
      var controller =
          NumpadController.initial(value: NumpadValue(digits: initial));
      controller.removeLast();
      expect(controller.value.duration, equals(expectedDuration));
    }

    test('duration zero', () {
      _expectRemove(initial: "", expectedDuration: Duration.zero);
    });

    test('remove with set seconds', () {
      _expectRemove(initial: "4", expectedDuration: Duration.zero);

      _expectRemove(
          initial: "47", expectedDuration: const Duration(seconds: 4));
    });

    test('remove with set minutes', () {
      _expectRemove(
          initial: "400", expectedDuration: const Duration(seconds: 40));

      _expectRemove(
          initial: "4700",
          expectedDuration: const Duration(minutes: 5, seconds: 10));
    });

    test('remove with set hours', () {
      _expectRemove(
          initial: "40000", expectedDuration: const Duration(minutes: 40));
      _expectRemove(
          initial: "470000",
          expectedDuration: const Duration(hours: 5, minutes: 10));
    });
  });
}
