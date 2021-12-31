import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_user_list_calendar/util/utils.dart';

void main() {
  test('Date should be parsed correctly.', () {
    const String testDate = "Dec 24, 2021 9:19 PM";
    DateTime parsedDate = parseApiDateTime(testDate);
    expect(DateTime.parse("2021-12-24 21:19:00").millisecondsSinceEpoch,
        parsedDate.millisecondsSinceEpoch);
  });
}
