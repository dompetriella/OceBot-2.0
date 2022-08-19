import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:ocebot2_0/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  
  DateTime dateTime = DateTime(2022);
  double weight = 0.0;
  String units = 'g';

  Data(this.dateTime, this.weight, this.units);

  static Future<List<Data>> getDataFromFirebase() async {
    List<Data> returnList = [];
    final db = await FirebaseFirestore.instance
    .collection("dummy_weights")
    .orderBy('date').get();

    db.docs.map((e) => {
      returnList.add(
        Data(
          e.get('date'),
          e.get('weight'), 
          'g'
        )
      )
    });
    
    return returnList;
  }

  static int generateRandomInt(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  static int convertMonthAndDayToYearDay(int month, int day) {
    List<int> months = [
      31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
    ];
    int monthSum = 0;
    for (var i = 0; i < month; i++) {
      monthSum += months[i];
    }
    return monthSum + day;
  }

  static List<Data> generateRandomDataList(int dataPoints) {
    List<Data> dataList = []; 
    int previousYear = 2022;
    int previousMonth = 1;
    int previousDay = 1;
    double previousWeight = 50.0;

    for (var i = 0; i < dataPoints; i++) {
      previousWeight = previousWeight < 30 || previousWeight > 120 ? generateRandomInt(50, 80).toDouble() : previousWeight + generateRandomInt(-5, 5);
      previousDay = previousDay + generateRandomInt(2, 15);
      if (previousDay > 27) {
        previousMonth++;
        previousDay = 1;
      }
      if (previousMonth > 11) {
        previousYear++;
        previousMonth = 1;
      }
      dataList.add(
        Data(DateTime(previousYear, previousMonth, previousDay), previousWeight, 'g')
      );
    }
    return dataList;
  }

  static LineChartBarData DataListToCoordinates(List<Data> dataList) {
    List<FlSpot> flSpots = dataList.map((data) => FlSpot(convertMonthAndDayToYearDay(data.dateTime.month, data.dateTime.day).toDouble(), data.weight)).toList();
    return LineChartBarData(
      spots: flSpots,
      color: OcebotTheme.primaryColor,
      isCurved: false,
      barWidth: 6,
      isStrokeCapRound: false,
    );
  }
}