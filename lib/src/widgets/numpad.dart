import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../picky.dart';
import '../controller/duration_picker_controller.dart';

/// {@template numpad}
/// This Widget is the actual Numpad that is used to enter the duration.
/// It holds the following grid:
///
/// 1 | 2 | 3
/// 4 | 5 | 6
/// 7 | 8 | 9
/// c | 0 | b
///
/// where c is the check icon and b is the backspace icon.
/// {@endtempalte}
class Numpad extends StatefulWidget {
  /// The Controller that holds the information about the entered duration
  final DurationPickerController controller;

  /// The context is used to POP the stack (and therefore close the bottom
  /// sheet) if the check icon was pressed.
  final BuildContext context;

  /// The ThemeData that defines the visual behavior of the [Numpad]
  final BottomSheetDurationPickerThemeData themeData;

  final FocusNode focusNode;

  /// {@macro numpad}
  const Numpad(
      {this.controller,
      this.themeData,
      this.focusNode,
      @required this.context});

  @override
  _NumpadState createState() => _NumpadState();
}

class _NumpadState extends State<Numpad> {
  DurationPickerController _controller;
  DurationPickerController get _effectiveController =>
      widget.controller ?? _controller;

  FocusNode _focusNode;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode;

  BottomSheetDurationPickerThemeData _themeData;

  BottomSheetDurationPickerThemeData get _effectiveThemeData =>
      widget.themeData ?? _themeData;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = DurationPickerController();
    }
    if (widget.themeData == null) {
      _themeData = BottomSheetDurationPickerThemeData(
          dialpadTextStyle: TextStyle(fontSize: 12, color: Colors.black));
    }
    if (widget.focusNode == null) {
      _focusNode = FocusNode();
    }
  }

  Widget numpadButton(String text, NumpadKey key) {
    return Expanded(
      child: InkWell(
        onTap: () {
          _effectiveController.onKey(key);
        },
        child: Center(
          child: Text(text, style: _effectiveThemeData.dialpadTextStyle),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: _effectiveFocusNode,
      onKey: _rawKeyListener,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numpadButton('1', NumpadKey.num1),
                numpadButton('2', NumpadKey.num2),
                numpadButton('3', NumpadKey.num3),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numpadButton('4', NumpadKey.num4),
                numpadButton('5', NumpadKey.num5),
                numpadButton('6', NumpadKey.num6),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numpadButton('7', NumpadKey.num7),
                numpadButton('8', NumpadKey.num8),
                numpadButton('9', NumpadKey.num9),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(widget.context)
                          .pop(_effectiveController.value);
                    },
                    child: Center(
                      child: Icon(
                        Icons.check,
                        color: _effectiveThemeData.dialpadLeftIconColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _effectiveController.onKey(NumpadKey.num0);
                    },
                    child: Center(
                      child: Text("0",
                          style: _effectiveThemeData.dialpadTextStyle),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _effectiveController.onKey(NumpadKey.delete);
                    },
                    child: Center(
                      child: Icon(Icons.backspace,
                          color: _effectiveThemeData.dialpadRightIconColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _rawKeyListener(RawKeyEvent value) {
    throw UnimplementedError();
  }
}

enum NumpadKey {
  num0,
  num1,
  num2,
  num3,
  num4,
  num5,
  num6,
  num7,
  num8,
  num9,
  delete,
}
