import 'package:flutter/foundation.dart';
import 'package:characters/characters.dart';

import 'numpad_value.dart';

/// {@template numpad_controller}
/// This is an internal Controller used to display
/// the value selected via the numpad.
/// {@endtempalte}
class NumpadController extends ValueNotifier<NumpadValue> {
  /// {@macro numpad_controller}
  ///
  /// By default the Value will be empty
  NumpadController() : super(NumpadValue.empty());

  /// {@macro numpad_controller}
  ///
  /// If you want to give an inital value you can use this constructor
  NumpadController.initial({@required NumpadValue value}) : super(value);

  /// The current Duration
  Duration get duration => value.duration;

  /// Insert a [number] into the [duration]
  void insert(int number) {
    assert(number < 10);
    value = NumpadValue(
        digits: "${value.digits}$number".characters.take(6).toString());
    notifyListeners();
  }

  /// Remove the last inserted number of [duration], if [duration] is not zero.
  void removeLast() {
    var newVal;
    if (value.digits.isEmpty) {
      newVal = "";
    } else {
      newVal = value.digits.characters.take(value.digits.length - 1).toString();
    }
    value = NumpadValue(digits: newVal);
    notifyListeners();
  }
}
