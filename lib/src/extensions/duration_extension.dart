extension DurationExtension on Duration {
  
  Duration copyWith({
    int days,
    int hours,
    int minutes,
    int seconds,
    int milliseconds,
    int microseconds}) {
    return Duration(
      days: days ?? this.inDays,
      hours: hours ?? this.inHours.remainder(24),
      minutes: minutes ?? this.inMinutes.remainder(60),
      seconds: seconds ?? this.inSeconds.remainder(60),
      milliseconds: milliseconds ?? this.inMilliseconds.remainder(1000),
      microseconds: microseconds ?? this.inMicroseconds.remainder(1000)
    );
  }
  
}