import 'package:ocebot2_0/models/data.dart';

class FirebaseData {
  int graphMin = 30;
  int graphMax = 130;

  List<Data> dataFromFirebase;

  FirebaseData(
      {required this.graphMin,
      required this.graphMax,
      required this.dataFromFirebase});
}
