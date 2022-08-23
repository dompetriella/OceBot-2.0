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

    print(db.docs.length);

    db.docs.forEach((doc) {
      DateTime date = doc.get('date').toDate();
      var data = Data(
        date,
        doc.get('weight'), 
        'g'
      );
      returnList.add(data);
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