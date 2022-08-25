import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:ocebot2_0/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  DateTime dateTime = DateTime(2022);
  double weight = 0.0;
  String units = 'g';

  Data(this.dateTime, this.weight, this.units);

  static int generateRandomInt(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  static int convertMonthAndDayToYearDay(int month, int day) {
    List<int> months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    int monthSum = 0;
    for (var i = 0; i < month; i++) {
      monthSum += months[i];
    }
    return monthSum + day;
  }

  static DateTime getDateInPastMonthsAgo(int monthsAgo) {
    DateTime currentDate = DateTime.now();
    var calculatedDays = monthsAgo * 30;
    return currentDate.subtract(Duration(days: calculatedDays));
  }

  static LineChartBarData DataListToCoordinates(List<Data> dataList) {
    List<FlSpot> flSpots = dataList
        .map((data) => FlSpot(
            convertMonthAndDayToYearDay(data.dateTime.month, data.dateTime.day)
                .toDouble(),
            data.weight))
        .toList();
    return LineChartBarData(
      spots: flSpots,
      color: OcebotTheme.primaryColor,
      isCurved: false,
      barWidth: 6,
      isStrokeCapRound: false,
    );
  }
}
