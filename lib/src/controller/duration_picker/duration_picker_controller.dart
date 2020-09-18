import 'package:flutter/foundation.dart';

/// {@template duration_picker_controller}
/// The Controller for the bottom_sheet_duration_picker.
/// Via this controller you can gain access to the
/// selected [Duration]
/// {@endtemplate}
class DurationPickerController extends ValueNotifier<Duration> {
  /// {@macro duration_picker_controller}
  DurationPickerController(Duration value) : super(value);

  /// This constructor generates a [DurationPickerController] with an initial
  /// [Duraion] value of [Duration.zero]
  DurationPickerController.zero() : super(Duration.zero);
}
