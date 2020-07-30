import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bottom_sheet_duration_picker/src/modal/time_picker_bottom_sheet.dart';

/// This class defines all properties to style the
/// [BottomSheet] used in [showDurationPickerBottomSheet].
@immutable
class BottomSheetDurationPickerThemeData with Diagnosticable {
  /// Defines the style for the [BottomSheet] used in
  /// [showDurationPickerBottomSheet].
  final BottomSheetThemeData bottomSheetThemeData;

  /// Defines the style for the text elements in the
  /// [BottomSheet] Dial to pick numbers.
  final TextStyle dialpadTextStyle;

  Color _dialpadLeftIconColor;

  /// Defines the [Color] of the left hand side
  /// icon in the dialpad.
  ///
  /// Defaults to [dialpadTextStyle.color]
  Color get dialpadLeftIconColor => _dialpadLeftIconColor;

  Color _dialpadRightIconColor;

  /// Defines the [Color] of the right hand side
  /// icon in the dialpad.
  ///
  /// Defaults to [dialpadTextStyle.color]
  Color get dialpadRightIconColor => _dialpadRightIconColor;

  /// Defines the [TextStyle] of the label.
  ///
  /// Defaults to
  /// ```
  /// TextStyle(color: Colors.black, fontSize: 27.0)
  /// ```
  final TextStyle labelStyle;

  /// Defines the [TextStyle] of the picked
  /// [Duration] in the [showDurationPickerBottomSheet].
  ///
  /// Defaults to
  /// ```
  ///
  /// ```
  final TextStyle pickedDurationTextStyle;

  BottomSheetDurationPickerThemeData(
      {this.bottomSheetThemeData = const BottomSheetThemeData(),
      this.dialpadTextStyle = const TextStyle(),
      this.labelStyle = const TextStyle(color: Colors.black, fontSize: 27.0),
      this.pickedDurationTextStyle =
          const TextStyle(color: Colors.black, fontSize: 35.0),
      Color dialpadLeftIconColor,
      Color dialpadRightIconColor}) {
    _dialpadLeftIconColor = dialpadLeftIconColor ?? dialpadTextStyle.color;
    _dialpadRightIconColor = dialpadRightIconColor ?? dialpadTextStyle.color;
  }

  BottomSheetDurationPickerThemeData copyWith(
      {BottomSheetThemeData bottomSheetThemeData,
      TextStyle dialpadTextStyle,
      TextStyle labelStyle,
      TextStyle pickedDurationTextStyle,
      Color dialpadLeftIconColor,
      Color dialpadRightIconColor}) {
    return BottomSheetDurationPickerThemeData(
        bottomSheetThemeData: bottomSheetThemeData ?? this.bottomSheetThemeData,
        dialpadTextStyle: dialpadTextStyle ?? this.dialpadTextStyle,
        pickedDurationTextStyle:
            pickedDurationTextStyle ?? this.pickedDurationTextStyle,
        labelStyle: labelStyle ?? this.labelStyle,
        dialpadLeftIconColor: dialpadLeftIconColor ?? this.dialpadLeftIconColor,
        dialpadRightIconColor:
            dialpadRightIconColor ?? this.dialpadRightIconColor);
  }
}
