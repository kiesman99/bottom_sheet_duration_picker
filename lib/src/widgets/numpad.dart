import 'package:bottom_sheet_duration_picker/src/controller/numpad/numpad_controller.dart';
import 'package:flutter/material.dart';

class Numpad extends StatefulWidget {
  final NumpadController controller;
  final BuildContext context;

  const Numpad({this.controller, @required this.context});

  @override
  _NumpadState createState() => _NumpadState();
}

class _NumpadState extends State<Numpad> {
  NumpadController _controller;
  NumpadController get _effectiveController => widget.controller ?? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = new NumpadController();
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
            child: Text(i.toString()),
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
                    Navigator.of(widget.context).pop(_effectiveController.value.duration);
                  },
                  child: Center(
                    child: Icon(Icons.check),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    _effectiveController.insert(0);
                  },
                  child: Center(
                    child: Text("0"),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    _effectiveController.removeLast();
                  },
                  child: Center(
                    child: Icon(Icons.backspace),
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
