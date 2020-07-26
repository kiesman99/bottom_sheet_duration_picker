/// This class provides some static functions to
/// transform a [Duration] into a readable [String]
///
/// They are mainly used in [DurationPickerFormField]
/// to select which format should be used as a label.
class DurationFormatter {

  /// This function will return the [duration] in
  /// form of "00s" where 00 is replaced with the
  /// actual seconds.
  ///
  /// The seconds are NOT summed up. Meaning if
  /// the [duration] has 120 seconds the output
  /// would be 00s, because 120 second equals two
  /// minutes.
  /// 127 seconds instead would print 07s, because
  /// 122 seconds are 02m and 07 seconds.
  static String seconds(Duration duration) {
    return "${_twoDigits(duration.inSeconds.remainder(60))}s";
  }

  /// This function will return the [duration] in
  /// form of "00m00s" where the 00 are replaced
  /// with the actual seconds and minutes.
  ///
  /// The seconds (same for the minutes)
  /// are NOT summed up. Meaning if
  /// the [duration] has 120 seconds the output
  /// would be 02m00s, because 120 second equals two
  /// minutes.
  /// 122 seconds instead would print 02m02s, because
  /// 122 seconds are 02 minutes and 02 seconds.
  static String seconds_minutes(Duration duration) {
    var str = StringBuffer();
    str.write("${_twoDigits(duration.inMinutes.remainder(60))}m");
    str.write("${_twoDigits(duration.inSeconds.remainder(60))}s");
    return str.toString();
  }

  /// This function will return the [duration] in
  /// form of "00m" where 00 is replaced with the
  /// actual minutes.
  ///
  /// The minutes are NOT summed up. Meaning if
  /// the [duration] has 120 minutes the output
  /// would be 00m, because 120 minutes equals two
  /// hours.
  /// 127 minutes instead would print 07m, because
  /// 127 minutes are 02 hours and 07 minutes.
  static String minutes(Duration duration) {
    return "${_twoDigits(duration.inMinutes.remainder(60))}m";
  }

  /// This function will return the [duration] in
  /// form of "00h00m" where the 00 are replaced
  /// with the actual hours and minutes.
  ///
  /// The minutes (same for the hours) are
  /// NOT summed up. Meaning if
  /// the [duration] has 120 minutes the output
  /// would be 02h00m, because 120 minutes equals two
  /// hours.
  /// 127 minutes instead would print 02h07m, because
  /// 127 minutes are 02 hours and 07 minutes.
  static String minutes_hours(Duration duration) {
    var str = StringBuffer();
    str.write("${_twoDigits(duration.inHours.remainder(24))}h");
    str.write("${_twoDigits(duration.inMinutes.remainder(60))}m");
    return str.toString();
  }

  /// This function will return the [duration] in
  /// form of "00h" where 00 is replaced with the
  /// actual hours.
  ///
  /// The hours are NOT summed up. Meaning if
  /// the [duration] has 48 hours the output
  /// would be 00h, because 48 hours equals two
  /// days.
  /// 55 hours instead would print 07h, because
  /// 55 hours are 02 days and 07 hours.
  static String hours(Duration duration) {
    return "${_twoDigits(duration.inHours.remainder(24))}h";
  }

  /// This function will return the [duration] in
  /// form of "00h00m00s" where the 00 are replaced
  /// with the actual hours, minutes and seconds.
  ///
  /// The minutes (same for the hours and seconds)
  /// are NOT summed up. Meaning if
  /// the [duration] has 120 minutes the output
  /// would be 02h00m00s, because 120 minutes equals two
  /// hours.
  /// 127 minutes instead would print 02h07m00s, because
  /// 127 minutes are 02 hours and 07 minutes and 0 seconds.
  static String hours_minutes_seconds(Duration duration) {
    String twoDigitMinutes = _twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = _twoDigits(duration.inSeconds.remainder(60));
    return "${_twoDigits(duration.inHours.remainder(24))}h${twoDigitMinutes}m${twoDigitSeconds}s";
  }

  /// This function will turn a integer into a two integer string.
  ///
  /// Example:
  ///
  /// 0 => 00
  /// 1 => 01
  /// 22 => 22
  /// 89 => 89
  /// 10 => 10
  /// 7 => 07
  /// 879 => 879
  static String _twoDigits(int n) => n.toString().padLeft(2, "0");

}