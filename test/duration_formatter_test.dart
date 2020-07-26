import 'package:bottom_sheet_duration_picker/src/utils/duration_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('DurationFormatter.seconds', () {
    void secondsTest(Duration duration, String wanted) {
      expect(DurationFormatter.seconds(duration), wanted);
    }

    test('duration zero', () {
      secondsTest(Duration.zero, "00s");
    });

    test('duration with hh:mm:ss', () {
      secondsTest(Duration(hours: 20, minutes: 19, seconds: 17), "17s");
    });

    test('duration with minutes > 60', () {
      secondsTest(Duration(minutes: 120), "00s");
    });

    test('duration with days', () {
      secondsTest(Duration(days: 2), "00s");
    });
  });

  group('DurationFormatter.seconds_minutes', () {
    void secondsMinutesTest(Duration duration, String wanted) {
      expect(DurationFormatter.seconds_minutes(duration), wanted);
    }

    test('duration zero', () {
      secondsMinutesTest(Duration.zero, "00m00s");
    });

    test('duration with hh:mm:ss', () {
      secondsMinutesTest(Duration(hours: 20, minutes: 19, seconds: 17), "19m17s");
    });

    test('duration with minutes > 60', () {
      secondsMinutesTest(Duration(minutes: 120), "00m00s");
    });

    test('duration with days', () {
      secondsMinutesTest(Duration(days: 2), "00m00s");
    });
  });

  group('DurationFormatter.minutes', () {
    void minutesTest(Duration duration, String wanted) {
      expect(DurationFormatter.minutes(duration), wanted);
    }

    test('duration zero', () {
      minutesTest(Duration.zero, "00m");
    });

    test('duration with hh:mm:ss', () {
      minutesTest(Duration(hours: 20, minutes: 19, seconds: 17), "19m");
    });

    test('duration with minutes > 60', () {
      minutesTest(Duration(minutes: 120), "00m");
    });

    test('duration with days', () {
      minutesTest(Duration(days: 2), "00m");
    });
  });

  group('DurationFormatter.minutes_hours', () {
    void minutesHoursTest(Duration duration, String wanted) {
      expect(DurationFormatter.minutes_hours(duration), wanted);
    }

    test('duration zero', () {
      minutesHoursTest(Duration.zero, "00h00m");
    });

    test('duration with hh:mm:ss', () {
      minutesHoursTest(Duration(hours: 20, minutes: 19, seconds: 17), "20h19m");
    });

    test('duration with minutes > 60', () {
      minutesHoursTest(Duration(minutes: 120), "02h00m");
    });

    test('duration with days', () {
      minutesHoursTest(Duration(days: 2), "00h00m");
    });
  });

  group('DurationFormatter.hours', () {
    void hoursTest(Duration duration, String wanted) {
      expect(DurationFormatter.hours(duration), wanted);
    }

    test('duration zero', () {
      hoursTest(Duration.zero, "00h");
    });

    test('duration with hh:mm:ss', () {
      hoursTest(Duration(hours: 20, minutes: 19, seconds: 17), "20h");
    });

    test('duration with minutes > 60', () {
      hoursTest(Duration(minutes: 120), "02h");
    });

    test('duration with days', () {
      hoursTest(Duration(days: 2), "00h");
    });
  });

  group('DurationFormatter.hours_minutes_seconds', () {
    void hoursMinutesSecondsTest(Duration d, String s){
      expect(DurationFormatter.hours_minutes_seconds(d), s);
    }

    test('duration zero', () {
      hoursMinutesSecondsTest(Duration.zero, "00h00m00s");
    });

    test('duration with hh:mm:ss', () {
      hoursMinutesSecondsTest(Duration(hours: 20, minutes: 19, seconds: 17), "20h19m17s");
    });

    test('duration with minutes > 60', () {
      hoursMinutesSecondsTest(Duration(minutes: 120), "02h00m00s");
    });

    test('duration with days', () {
      hoursMinutesSecondsTest(Duration(days: 2), "00h00m00s");
    });
  });

}