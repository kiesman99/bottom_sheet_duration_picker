import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../picky.dart';

class _DurationPickerHookCreator {
  const _DurationPickerHookCreator();

  /// Creates a [DurationPickerController] that will be disposed automatically.
  ///
  /// The [duration] parameter can be used to set the initial value of the
  /// controller.
  DurationPickerController call({Duration duration, List<Object> keys}) {
    return Hook.use(_DurationPickerControllerHook(duration, keys));
  }
}

/// Creates a [DurationPickerController], with an optional initial duration.
///
/// To use a [DurationPickerController] with an optional initial duration, use
/// ```dart
/// final controller =
///   useDurationPickerController(duration: const Duration(seconds: 15));
/// ```
///
/// Changing the duration value after the widget has been built has no
/// effect whatsoever. To update the value in a callback, for instance after a
/// button was pressed, use the [DurationPickerController.value] or setter.
/// To have the [DurationPickerController] reflect changing values, you can use
/// [useEffect]. This example will update the [DurationPickerController.value]
/// whenever a provided [ValueListenable] changes:
/// ```dart
/// final controller = useDurationPickerController();
/// final update = useValueListenable(myDurationPickerControllerUpdates);
///
/// useEffect(() {
///   controller.value = update;
///   return null; // we don't need to have a special dispose logic
/// }, [update]);
/// ```
///
/// See also:
/// - [DurationPickerController], which this hook creates.
const useDurationPickerController = _DurationPickerHookCreator();

class _DurationPickerControllerHook extends Hook<DurationPickerController> {
  final Duration initialValue;

  _DurationPickerControllerHook(this.initialValue, [List<Object> keys])
      : super(keys: keys);

  @override
  _DurationPickerControllerHookState createState() =>
      _DurationPickerControllerHookState();
}

class _DurationPickerControllerHookState
    extends HookState<DurationPickerController, _DurationPickerControllerHook> {
  DurationPickerController _controller;

  @override
  void initHook() {
    if (hook.initialValue != null) {
      _controller = DurationPickerController(hook.initialValue);
    } else {
      _controller = DurationPickerController();
    }
  }

  @override
  DurationPickerController build(BuildContext context) => _controller;

  @override
  void dispose() {
    _controller?.dispose();
  }
}
