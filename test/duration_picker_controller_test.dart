import 'package:picky/picky.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      'zero constructor builds a controller with an initial '
      'value of Duration.zero', () {
    var controller = DurationPickerController.zero();
    expect(controller.value, Duration.zero);
  });

  test('create controller with inital value', () {
    var initialDuration = Duration(hours: 13, minutes: 50, seconds: 2);
    var controller = DurationPickerController(initialDuration);
    expect(controller.value, equals(initialDuration));
  });
}
