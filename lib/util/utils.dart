import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

DateTime parseApiDateTime(String dateString) {
  try {
    // API Format: Dec 5, 2021 9:09 PM
    DateFormat dateFormat = DateFormat("MMM dd, yyyy hh:mm aaa");
    return dateFormat.parse(dateString);
  } catch (e) {
    debugPrint("Error while parsing date: ${e.toString()}");
  }

  return DateTime.fromMicrosecondsSinceEpoch(0);
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
