import 'package:picky/picky.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picky/src/widgets/numpad.dart';

void main() {
  test(
      'zero constructor builds a controller with an initial '
      'value of Duration.zero', () {
    var controller = DurationPickerController();
    expect(controller.value, Duration.zero);
  });

  test('create controller with initial value', () {
    var initialDuration = Duration(hours: 13, minutes: 50, seconds: 2);
    var controller = DurationPickerController(initialDuration);
    expect(controller.value, equals(initialDuration));
  });

  test('add number to controller', () {
    var controller = DurationPickerController();
    controller.onKey(NumpadKey.num9);
    expect(controller.value, Duration(seconds: 9));
  });

  test('add multiple numbers to controller should work fine', () {
    var controller = DurationPickerController();
    controller.onKey(NumpadKey.num2);
    controller.onKey(NumpadKey.num1);
    controller.onKey(NumpadKey.num3);
    controller.onKey(NumpadKey.num8);
    expect(controller.value, equals(Duration(minutes: 21, seconds: 38)));
  });

  test('add numbers and remove some from controller should work fine', () {
    var controller = DurationPickerController();
    controller.onKey(NumpadKey.num2);
    controller.onKey(NumpadKey.num1);
    controller.onKey(NumpadKey.num3);
    controller.onKey(NumpadKey.delete);
    controller.onKey(NumpadKey.num8);
    expect(controller.value, equals(Duration(minutes: 2, seconds: 18)));
  });

  test('add 0 with as first number should not change anything', () {
    var controller = DurationPickerController();
    controller.onKey(NumpadKey.num0);
    expect(controller.value, equals(Duration.zero));
  });

  test('while adding 8 numbers only first 6 should be acknowledged', () {
    var controller = DurationPickerController();
    controller.onKey(NumpadKey.num2);
    controller.onKey(NumpadKey.num1);
    controller.onKey(NumpadKey.num3);
    controller.onKey(NumpadKey.num5);
    controller.onKey(NumpadKey.num1);
    controller.onKey(NumpadKey.num8);
    controller.onKey(NumpadKey.num2);
    controller.onKey(NumpadKey.num1);
    expect(controller.value,
        equals(Duration(hours: 21, minutes: 35, seconds: 18)));
  });

  test(
      'adding 8 numbers and then deleting '
      'should delete 6th number entered', () {
    var controller = DurationPickerController();
    controller.onKey(NumpadKey.num2);
    controller.onKey(NumpadKey.num1);
    controller.onKey(NumpadKey.num3);
    controller.onKey(NumpadKey.num5);
    controller.onKey(NumpadKey.num1);
    controller.onKey(NumpadKey.num8);
    controller.onKey(NumpadKey.num2);
    controller.onKey(NumpadKey.num1);
    controller.onKey(NumpadKey.delete);
    expect(
        controller.value, equals(Duration(hours: 2, minutes: 13, seconds: 51)));
  });
}
