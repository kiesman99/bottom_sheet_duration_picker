import 'package:flutter/foundation.dart';
import '../widgets/numpad.dart';

/// {@template duration_picker_controller}
/// The Controller for the bottom_sheet_duration_picker.
/// Via this controller you can gain access to the
/// selected [Duration]
///
/// The default [Duration] if nothing is provided is [Duration.zero].
/// {@endtemplate}
class DurationPickerController extends ValueNotifier<Duration> {
  /// {@macro duration_picker_controller}
  DurationPickerController([Duration value = Duration.zero]) : super(value) {
    var seconds = value.inSeconds.remainder(60);
    var minutes = value.inMinutes.remainder(60);
    var hours = value.inHours.remainder(24);
    _input[0] = seconds % 10;
    _input[1] = seconds ~/ 10;
    _input[2] = minutes % 10;
    _input[3] = minutes ~/ 10;
    _input[4] = hours % 10;
    _input[5] = hours ~/ 10;
  }

  @override
  Duration get value {
    var seconds = _input[1] * 10 + _input[0];
    var minutes = _input[3] * 10 + _input[2];
    var hours = _input[5] * 10 + _input[4];
    return Duration(seconds: seconds, minutes: minutes, hours: hours);
  }

  List<int> _input = <int>[0, 0, 0, 0, 0, 0];
  int _inputPointer = -1;

  /// This function is used to process a keypress
  /// on the Numpad of the bottom sheet duration picker.
  ///
  /// Inserting a [NumpadKey.num2] will result in a [Duration] of 2 seconds.
  /// Then inserting [NumpadKey.num0] will result in a [Duration] of 20 seconds.
  /// This behavior continues with ongoing inserted numbers.
  ///
  /// Inserting [NumpadKey.delete] will result in deleting in the last recently
  /// added number
  void onKey(NumpadKey key) {
    if (key == NumpadKey.delete) {
      _handleDelete();
      return;
    }
    _handleNumPress(key);
    notifyListeners();
  }

  void _handleNumPress(NumpadKey key) {
    if (_inputPointer == -1 && key == NumpadKey.num0) {
      return;
    }
    if (_inputPointer == _input.length - 1) {
      return;
    }

    _input = [key.index, ..._input.take(_input.length - 1)];
    _inputPointer++;
  }

  void _handleDelete() {
    if (_inputPointer != 0) {
      _input = [..._input.skip(1), 0];
      _inputPointer--;
    }
  }
}
