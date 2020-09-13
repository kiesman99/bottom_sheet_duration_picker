import 'package:bottom_sheet_duration_picker/src/controller/duration_picker/DurationPickerController.dart';
import 'package:bottom_sheet_duration_picker/src/modal/time_picker_bottom_sheet.dart';
import 'package:bottom_sheet_duration_picker/src/theme/bottom_sheet_duration_picker_theme_data.dart';
import 'package:bottom_sheet_duration_picker/src/utils/duration_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A string builder used to customize the string
/// that should be displayed in the  [DurationPickerFormField]
typedef String LabelBuilder(Duration duration);

/// The Form Field that should be used in a [Form].
/// If a user clicks on this field he'll get a
/// bottomSheet in which he is able to pick a [Duration]
class DurationPickerFormField extends FormField<Duration> {

  DurationPickerController controller;

  Function onTap;

  /// This constructor will provide a Form Field
  /// which can be used to gather a [Duration] from the
  /// user.
  ///
  /// By default the form field will display the
  /// [Duration] in the following format: 00h00m00s
  /// **Warning**: If the [Duration] provides a value of
  /// 120 minutes it will display 02h00m00s. Be aware that
  /// it does **NOT** sum up the minutes to 120 but rather
  /// shifts it to the hours section. Same behavior for hours
  /// and seconds.
  ///
  /// You can customize the label by either providing a custom
  /// [LabelBuilder] or by using another method from the [DateFormatter]
  /// class.
  ///
  /// ## Example for a custom [LabelBuilder]
  /// ```dart
  /// DurationPickerFormField(
  ///   // other fields ...
  ///   labelBuilder: (Duration duration) {
  ///     return "${duration.inMilliseconds}ms";
  ///   }
  ///   // other fields ...
  /// );
  ///
  /// This custom [LabelBuilder] would transform
  /// every [Duration] into it's milliseconds and
  /// display this.
  ///
  /// The values [onSaved], [validator],
  /// [initValue] and [autovalidate] are inherited by
  /// [FormField] you can look them up there.
  ///
  /// ## Customize bottom sheet
  ///
  /// To customize the bottom Sheet following options
  /// are available:
  ///
  /// Set the [modalBackgroundColor] to set the background
  /// color of the bottom sheet. Default is [Colors.white]
  ///
  /// Set the [modalEnableDrag] to allow dismissing the
  /// bottom sheet via dragging it down.
  ///
  /// Set the [modalIsDismissible] to allow dismissing
  /// the bottom sheet by clicking somewhere else.
  ///
  /// Set the [modalLabelStyle] to customize the label
  /// inside of the bottom sheet.
  ///
  /// Set the [modalShapeBorder] to customize the
  /// [ShapeBorder] of the bottom sheet. Default is
  /// set to circular edges.
  ///
  /// The title of the bottom sheet is inherited by the
  /// [DurationPickerFormField] [title] option.
  DurationPickerFormField(
      {FormFieldSetter<Duration> onSaved,
      FormFieldValidator<Duration> validator,
      Duration initialValue = Duration.zero,
      bool autovalidate = false,
      LabelBuilder labelBuilder = DurationFormatter.hours_minutes_seconds,
      bool modalEnableDrag,
      bool modalIsDismissible,
      BottomSheetDurationPickerThemeData themeData,
      this.onTap,
      this.controller,
      @required String title,})
      :
        super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<Duration> state) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(title),
                    subtitle: Text(labelBuilder.call(state.value)),
                    onTap: () async {
                      onTap?.call();
                      var d = await showDurationPickerBottomSheet(
                        context: state.context,
                        themeData: themeData,
                        enableDrag: modalEnableDrag ?? true,
                        isDismissible: modalIsDismissible ?? true,
                        label: title,
                      );
                      state.didChange( d ??
                          state.value);
                    },
                  ),
                  state.hasError
                      ? Text(
                          state.errorText,
                          style: TextStyle(color: Colors.red),
                        )
                      : Container()
                ],
              );
            });

  @override
  FormFieldState<Duration> createState() => _DurationPickerFormFieldState();
}

class _DurationPickerFormFieldState extends FormFieldState<Duration> {

  DurationPickerController _controller;
  DurationPickerController get _effectiveController => widget.controller ?? this._controller;

  @override
  void didChange(Duration value) {
    super.didChange(value);
    if (_effectiveController.value != value)
      _effectiveController.value = value;
  }

  @override
  DurationPickerFormField get widget => super.widget as DurationPickerFormField;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = DurationPickerController.zero();
    }
  }

}
