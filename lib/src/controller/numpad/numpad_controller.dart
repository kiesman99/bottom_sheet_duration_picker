import 'package:flutter/foundation.dart';
import 'package:characters/characters.dart';

import 'numpad_value.dart';

class NumpadController extends ValueNotifier<NumpadValue> {
  NumpadController() : super(NumpadValue.empty());

  NumpadController.initial({@required NumpadValue value}) : super(value);

  Duration get duration => value.duration;

  void insert(int number) {
    assert(number < 10);
    this.value = NumpadValue(digits: "${value.digits}$number".characters.take(6).toString());
    notifyListeners();
  }

  void removeLast() {
    var newVal;
    if (value.digits.isEmpty) {
      newVal = "";
    } else {
      newVal = value.digits.characters.take(value.digits.length - 1).toString();
    }
    this.value = NumpadValue(digits: newVal);
    notifyListeners();
  }
}
