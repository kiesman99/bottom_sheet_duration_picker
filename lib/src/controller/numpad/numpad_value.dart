import 'package:characters/characters.dart';

class NumpadValue {
  String digits = "";

  String get seconds => digits.padLeft(6, '0').characters.skip(4).take(2).toString();
  String get minutes => digits.padLeft(6, '0').characters.skip(2).take(2).toString();
  String get hours => digits.padLeft(6, '0').characters.take(2).toString();

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

  NumpadValue({this.digits}) : assert(digits.length <= 6);

  factory NumpadValue.empty() {
    return NumpadValue(digits: "");
  }
}
