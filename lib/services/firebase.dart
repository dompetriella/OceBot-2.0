import 'package:ocebot2_0/models/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocebot2_0/providers/db_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ocebot2_0/providers/filter_provider.dart';

class FirebaseService {
  static Future<List<Data>> getDataFromFirebase(int filterInt) async {
    List<Data> returnList = [];

    var monthsAgoDate = Data.getDateInPastMonthsAgo(filterInt);

    final db = await FirebaseFirestore.instance
        .collection("dummy_weights")
        .orderBy('date')
        .where('date', isGreaterThan: monthsAgoDate)
        .get();

    db.docs.forEach((doc) {
      DateTime date = doc.get('date').toDate();
      var data = Data(date, doc.get('weight'), 'g');
      returnList.add(data);
    });
    return returnList;
  }
}
