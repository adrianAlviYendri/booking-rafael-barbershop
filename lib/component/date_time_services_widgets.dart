// ignore_for_file: depend_on_referenced_packages, unused_import

import 'package:intl/intl.dart';

class DateTimeService {
  static List<DateTime> generateDayList() {
    List<DateTime> dayList = [];
    DateTime startDate = DateTime.now();
    DateTime endDate = startDate.add(const Duration(days: 6)); // Durasi 7 hari

    DateTime currentDate = startDate;
    while (currentDate.isBefore(endDate) ||
        currentDate.isAtSameMomentAs(endDate)) {
      dayList.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }
    return dayList;
  }

  static List<String> timeList = [
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
  ];
}
