import 'package:intl/intl.dart';

import 'package:thaki/globals/index.dart';

class TkDateTimeHelper {
  /// Translates the week day number into the weekday
  /// string
  static String translateWeekday(int weekday, {bool shorten = true}) {
    switch (weekday) {
      case 1:
        return shorten ? kMon : kMonday;
      case 2:
        return shorten ? kTue : kTuesday;
      case 3:
        return shorten ? kWed : kWednesday;
      case 4:
        return shorten ? kThur : kThursday;
      case 5:
        return shorten ? kFri : kFriday;
      case 6:
        return shorten ? kSat : kSaturday;
      case 7:
        return shorten ? kSun : kSunday;
      default:
        return kUnknown;
    }
  }

  /// Function that takes a string date and returns
  /// the weekday number
  static int getWeekday(String date) {
    if (date == null) return null;

    DateTime formatted = DateTime.tryParse(date);
    if (formatted == null) {
      // try reversing the date
      date = date.split('-').reversed.join('-');
      formatted = DateTime.tryParse(date);
      if (formatted == null) return null;
    }

    try {
      return formatted.weekday;
    } catch (e) {
      if (kVerboseNetworkMessages) print(e);
      return 1;
    }
  }

  /// Function that takes a string date and returns
  /// the weekday and the formatted date
  static String getWeekdayString(String date) {
    if (date == null) return date;

    DateTime formatted = DateTime.tryParse(date);
    if (formatted == null) {
      // try reversing the date
      date = date.split('-').reversed.join('-');
      formatted = DateTime.tryParse(date);
      if (formatted == null) return date;
    }

    try {
      date = date.split(' ')[0].split('-').reversed.join('/');

      return translateWeekday(formatted.weekday) + kWeekDaySep + date;
    } catch (e) {
      if (kVerboseNetworkMessages) print(e);
      return date;
    }
  }

  /// Function that takes a string date and returns
  /// a user friendly version
  static String formatDate(String date) {
    if (date == null) return date;

    try {
      // Remove time
      String dateOnly = date.split(' ')[0];

      // Flip date
      return dateOnly.split('-').reversed.join('/');
    } catch (e) {
      return date;
    }
  }

  /// Function that takes a string time and
  /// removes the seconds
  static String removeSeconds(String time) {
    if (time == null) return null;

    // Split the time variable and rejoin the first two substrings
    List<String> hoursMinutes = time.split(':');
    return hoursMinutes[0] + ':' + hoursMinutes[1];
  }

  /// Function that takes a string time and
  /// removes the seconds and adds am and pm
  static String formatTime(String time) {
    if (time == null) return time;

    List<int> timeComponents = [];
    String suffix;
    String hour;
    String minute;

    for (String item in time.split(':')) {
      timeComponents.add(int.tryParse(item));
    }
    if (timeComponents.length < 2) return time;

    if (timeComponents[0] < 12) {
      // AM
      suffix = kAM;
      if (timeComponents[0] == 0) timeComponents[0] = 12;
    } else {
      // PM
      suffix = kPM;
      if (timeComponents[0] != 12) timeComponents[0] -= 12;
    }

    hour = timeComponents[0] >= 10
        ? timeComponents[0].toString()
        : '' + timeComponents[0].toString();
    minute = timeComponents[1] >= 10
        ? timeComponents[1].toString()
        : '0' + timeComponents[1].toString();

    return '$hour:$minute $suffix';
  }

  /// Calculates week number from a date
  static int getWeekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  /// Calculates the start and end of a week number for a specific year
  static List<DateTime> getDatesByWeekNumber({int week, int year}) {
    DateTime startOfaYear = DateTime.utc(year, 1, 1);
    int startOfaYearWeekDay = startOfaYear.weekday;

    // Get the first week of the year
    DateTime firstWeekOfaYear = startOfaYearWeekDay < 4
        ? startOfaYear.subtract(Duration(days: startOfaYearWeekDay - 1))
        : startOfaYear.add(Duration(days: 8 - startOfaYearWeekDay));

    // Calculate the start date of the passed week
    DateTime startOfNWeek =
        firstWeekOfaYear.add(Duration(days: (week - 1) * 7));

    // Adjustment to start the week on Sunday rather than Monday
    return [
      startOfNWeek.subtract(Duration(days: 0)),
      startOfNWeek.add(Duration(days: 6)),
    ];
  }
}
