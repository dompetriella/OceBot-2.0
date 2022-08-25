import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ocebot2_0/models/data.dart';
import 'package:ocebot2_0/providers/filter_provider.dart';
import 'package:ocebot2_0/services/firebase.dart';

final dbDataFutureProvider = FutureProvider<List<Data>>((ref) async {
  return FirebaseService.getDataFromFirebase(ref.read(filterMonthsIntProvider));
});

final dbDataProvider = StateProvider<List<Data>>((ref) => []);
