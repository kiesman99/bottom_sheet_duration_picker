import 'package:characters/characters.dart';

/// {@template numpad_value}
/// This class resembles the current value that was entered via the numpad.
/// {@endtemplate}
class NumpadValue {
  /// {@macro numpad_value}
  NumpadValue({this.digits}) : assert(digits.length <= 6);

  /// Current duration resembled as a String
  String digits = "";

  /// Seconds of the entered Duration
  String get seconds =>
      digits.padLeft(6, '0').characters.skip(4).take(2).toString();

  /// Minutes of the entered Duration
  String get minutes =>
      digits.padLeft(6, '0').characters.skip(2).take(2).toString();

  /// Hours of the entered Duration
  String get hours => digits.padLeft(6, '0').characters.take(2).toString();

  /// The Duration of the NumpadValue
  Duration get duration {
    if (digits.isEmpty) {
      return Duration.zero;
    }

    var tmp = digits.padLeft(6, '0').characters;

    var minutes = int.parse(tmp.skip(2).take(2).toString());
    var seconds = int.parse(tmp.skip(4).take(2).toString());
    var hours = int.parse(tmp.take(2).toString());
    return Duration(seconds: seconds, minutes: minutes, hours: hours);
  }

  /// Returns a [NumpadValue] with a [Duration.zero]
  factory NumpadValue.empty() {
    return NumpadValue(digits: "");
  }
}
