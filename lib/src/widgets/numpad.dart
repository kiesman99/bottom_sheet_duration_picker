import 'package:flutter/material.dart';

import '../../bottom_sheet_duration_picker.dart';
import '../controller/numpad/numpad_controller.dart';

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
  final NumpadController controller;

  /// The context is used to POP the stack (and therefore close the bottom
  /// sheet) if the check icon was pressed.
  final BuildContext context;

  /// The ThemeData that defines the visual behavior of the [Numpad]
  final BottomSheetDurationPickerThemeData themeData;

  /// {@macro numpad}
  const Numpad({this.controller, this.themeData, @required this.context});

  @override
  _NumpadState createState() => _NumpadState();
}

class _NumpadState extends State<Numpad> {
  NumpadController _controller;
  NumpadController get _effectiveController => widget.controller ?? _controller;

  BottomSheetDurationPickerThemeData _themeData;
  BottomSheetDurationPickerThemeData get _effectiveThemeData =>
      widget.themeData ?? _themeData;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = NumpadController();
    }
    if (widget.themeData == null) {
      _themeData = BottomSheetDurationPickerThemeData(
          dialpadTextStyle: TextStyle(fontSize: 12, color: Colors.black));
    }
  }

  List<Widget> _numpadRow(List<int> numbers) {
    return numbers.map((i) {
      return Expanded(
        child: InkWell(
          onTap: () {
            _effectiveController.insert(i);
          },
          child: Center(
            child:
                Text(i.toString(), style: _effectiveThemeData.dialpadTextStyle),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ..._numpadRow([1, 2, 3])
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ..._numpadRow([4, 5, 6])
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ..._numpadRow([7, 8, 9])
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
                        .pop(_effectiveController.value.duration);
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
                    _effectiveController.insert(0);
                  },
                  child: Center(
                    child:
                        Text("0", style: _effectiveThemeData.dialpadTextStyle),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    _effectiveController.removeLast();
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
    );
  }
}
