import 'package:bottom_sheet_duration_picker/src/controller/numpad/numpad_controller.dart';
import 'package:bottom_sheet_duration_picker/src/controller/numpad/numpad_value.dart';
import 'package:bottom_sheet_duration_picker/src/theme/bottom_sheet_duration_picker_theme_data.dart';
import 'package:bottom_sheet_duration_picker/src/widgets/numpad.dart';
import 'package:flutter/material.dart';

// TODO: set options to select just seconds, seconds and minutes, hours seconds and minutes
// TODO: make the dial pad fitting in the bottomSheet

/// This function will show a modal containing a
/// number selection to pick a [Duration].
///
/// The [context] is needed to tell the dialog, in which
/// [BuildContext] it should open up.
///
/// You can set [dialPadTextColor] to set the color
/// of the dialpad strings.
///
/// You can provide a [label] which will be displayed
/// at the top of the picker. Optionally you can provide
/// a [labelStyle] to customize the [label]. If no [label]
/// is defined, nothing is showed at the top.
///
/// The background of the bottomSheet is set by providing
/// the [backgroundColor] option. The default background
/// color is [Colors.white].
///
/// If you want to customize the shape of the bottomSheet
/// you can achieve this by providing the [shapeBorder].
/// If no [shapeBorder] is provided, the bottomSheet will have
/// slightly rounded corners.
///
/// Dragging to dismiss the sheet is by default disabled. If you
/// want to enable this, set the [enableDrag] option to true.
///
/// Dismissing the bottomSheet by clicking anywhere else the bottomSheet
/// itself is enabled by default. If you want to disable this behaviour
/// set [isDismissible] to false.
///
/// The [showDurationPickerBottomSheet] will return a [Duration]
/// with the picked time of the user. It is delivered via a
/// [Future].
Future<Duration> showDurationPickerBottomSheet(
    {BuildContext context,
    BottomSheetDurationPickerThemeData themeData,
    bool isDismissible = true,
    bool enableDrag = true,
    String label}) async {
  if (themeData == null) {
    themeData = BottomSheetDurationPickerThemeData();
  }

  Widget labelWidget = Container();
  if (label != null && label.isNotEmpty) {
    labelWidget = Padding(
      padding: EdgeInsets.only(
        top: 10.0,
      ),
      child: Text(label, style: themeData.labelStyle),
    );
  }

  var bottomSheetTheme = themeData.bottomSheetThemeData;
  return await showModalBottomSheet<Duration>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: bottomSheetTheme.backgroundColor,
      shape: bottomSheetTheme.shape,
      clipBehavior: bottomSheetTheme.clipBehavior,
      elevation: bottomSheetTheme.elevation,
      builder: (context) {
        NumpadController controller = NumpadController();

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            labelWidget,
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: ValueListenableBuilder(
                  valueListenable: controller,
                  builder: (BuildContext context, NumpadValue value, Widget child) {
                return Text(
                  _minutes_seconds(value),
                  style: themeData.pickedDurationTextStyle,
                );
              }),
            ),
            Expanded(
              child: Numpad(controller: controller, context: context),
            )
          ],
        );
      });
}

String _minutes_seconds(NumpadValue v) {
  return "${v.minutes}m${v.seconds}s";
}
