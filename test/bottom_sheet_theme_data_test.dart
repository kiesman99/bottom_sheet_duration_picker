import 'package:picky/picky.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('create BottomSheetDurationPickerThemeData', () {
    var bottomSheetThemeData = BottomSheetThemeData();
    var dialpadTextStyle = TextStyle();
    var labelStyle = TextStyle();
    var pickedDurationTextStyle = TextStyle();
    var pickerTheme = BottomSheetDurationPickerThemeData(
        bottomSheetThemeData: bottomSheetThemeData,
        dialpadLeftIconColor: Colors.red,
        dialpadRightIconColor: Colors.green,
        dialpadTextStyle: dialpadTextStyle,
        labelStyle: labelStyle,
        pickedDurationTextStyle: pickedDurationTextStyle);

    expect(pickerTheme.dialpadLeftIconColor, equals(Colors.red));
    expect(pickerTheme.dialpadRightIconColor, equals(Colors.green));
    expect(pickerTheme.bottomSheetThemeData, equals(bottomSheetThemeData));
    expect(pickerTheme.labelStyle, equals(labelStyle));
    expect(
        pickerTheme.pickedDurationTextStyle, equals(pickedDurationTextStyle));
    expect(pickerTheme.dialpadTextStyle, equals(dialpadTextStyle));
  });

  test('BottomSheetDurationPickerThemeData without explicit icon colors', () {
    var pickerTheme = BottomSheetDurationPickerThemeData(
        dialpadTextStyle: TextStyle(color: Colors.amber));
    expect(pickerTheme.dialpadLeftIconColor, equals(Colors.amber));
    expect(pickerTheme.dialpadRightIconColor, equals(Colors.amber));
  });

  test(
      'BottomSheetDurationPickerThemeData only left icon colors explicitly set',
      () {
    var pickerTheme = BottomSheetDurationPickerThemeData(
        dialpadTextStyle: TextStyle(color: Colors.amber),
        dialpadLeftIconColor: Colors.green);
    expect(pickerTheme.dialpadLeftIconColor, equals(Colors.green));
    expect(pickerTheme.dialpadRightIconColor, equals(Colors.amber));
  });

  test(
      'BottomSheetDurationPickerThemeData only'
      'right icon colors explicitly set', () {
    var pickerTheme = BottomSheetDurationPickerThemeData(
        dialpadTextStyle: TextStyle(color: Colors.amber),
        dialpadRightIconColor: Colors.green);
    expect(pickerTheme.dialpadLeftIconColor, equals(Colors.amber));
    expect(pickerTheme.dialpadRightIconColor, equals(Colors.green));
  });
}
