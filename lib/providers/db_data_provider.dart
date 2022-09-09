import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ocebot2_0/models/data.dart';
import 'package:ocebot2_0/models/firebaseData.dart';
import 'package:ocebot2_0/providers/filter_provider.dart';
import 'package:ocebot2_0/services/firebase.dart';

final dbDataFutureProvider = FutureProvider<FirebaseData>((ref) async {
  return FirebaseService.getDataFromFirebase(ref.read(filterMonthsIntProvider));
});

final dbDataProvider = StateProvider<FirebaseData>(
    (ref) => FirebaseData(graphMin: 30, graphMax: 130, dataFromFirebase: []));

final minHeightGraphProvider = StateProvider<int>((ref) => 30);

final maxHeightGraphProvider = StateProvider<int>((ref) => 130);
