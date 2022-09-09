import 'package:ocebot2_0/models/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocebot2_0/models/firebaseData.dart';

class FirebaseService {
  static Future<FirebaseData> getDataFromFirebase(int filterInt) async {
    List<Data> returnList = [];

    var monthsAgoDate = Data.getDateInPastMonthsAgo(filterInt);

    final db = await FirebaseFirestore.instance
        .collection("dummy_weights")
        .orderBy('date')
        .where('date', isGreaterThan: monthsAgoDate)
        .get();

    db.docs.forEach((doc) {
      DateTime date = doc.get('date').toDate();
      double weight = doc.get('weight');
      var data = Data(date, weight, 'g');
      returnList.add(data);
    });

    var graphMin = returnList[0].weight;
    var graphMax = returnList[0].weight;

    for (var i = 0; i < returnList.length; i++) {
      var testMin = returnList[i].weight;
      var testMax = returnList[i].weight;

      if (testMin < graphMin) {
        testMin = graphMin;
      }

      if (testMax > graphMax) {
        graphMax = testMax;
      }
    }

    FirebaseData returnData = FirebaseData(
        graphMin: (graphMin - 10).toInt(),
        graphMax: (graphMax + 10).toInt(),
        dataFromFirebase: returnList);

    return returnData;
  }
}
