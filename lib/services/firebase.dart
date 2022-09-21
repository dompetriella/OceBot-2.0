import 'package:ocebot2_0/models/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocebot2_0/models/firebaseData.dart';

class FirebaseService {
  static Future<FirebaseData> getDataFromFirebase(int filterInt) async {
    List<Data> returnList = [];

    var monthsAgoDate = Data.getDateInPastMonthsAgo(filterInt);

    final db = await FirebaseFirestore.instance
        .collection("weights")
        .orderBy('date')
        .where('date', isGreaterThan: monthsAgoDate)
        .get();

    db.docs.forEach((doc) {
      DateTime date = doc.get('date').toDate();
      double weight = doc.get('weight');
      var data = Data(date, weight, 'g');
      returnList.add(data);
    });

    double graphMin = 70;
    double graphMax = 120;

    if (returnList.length > 0) {
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
    }

    FirebaseData returnData = FirebaseData(
        graphMin: (graphMin - 10).toInt(),
        graphMax: (graphMax + 10).toInt(),
        dataFromFirebase: returnList);

    return returnData;
  }
}
