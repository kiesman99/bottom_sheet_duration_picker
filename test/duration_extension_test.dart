import 'package:flutter_test/flutter_test.dart';
import 'package:bottom_sheet_duration_picker/src/extensions/duration_extension.dart';

void main() {
  group('copyWith extension', () {
    var d = const Duration(days: 87);

    test('copy empty', () {
      expect(d.copyWith(), equals(d));
    });

    test('microseconds', () {
      expect(d.copyWith(microseconds: 1000000),
          equals(const Duration(days: 87, seconds: 1)));
    });

    test('milliseconds', () {
      expect(d.copyWith(milliseconds: 1000),
          equals(const Duration(days: 87, seconds: 1)));
    });

    test('seconds', () {
      expect(
          d.copyWith(seconds: 1), equals(const Duration(days: 87, seconds: 1)));
    });

    test('minutes', () {
      expect(
          d.copyWith(minutes: 1), equals(const Duration(days: 87, minutes: 1)));
    });

    test('hours', () {
      expect(d.copyWith(hours: 1), equals(const Duration(days: 87, hours: 1)));
    });

    test('days', () {
      expect(d.copyWith(days: 1), equals(const Duration(days: 1)));
    });
  });
}
