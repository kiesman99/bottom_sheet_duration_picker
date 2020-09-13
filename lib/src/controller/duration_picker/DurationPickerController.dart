import 'package:flutter/cupertino.dart';

class DurationPickerController extends ValueNotifier<Duration> {
  DurationPickerController(Duration value) : super(value);

  DurationPickerController.zero() : super(Duration.zero);
}