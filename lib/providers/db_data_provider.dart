import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ocebot2_0/models/data.dart';

final dbDataFutureProvider = FutureProvider<List<Data>>((ref) async {
  return Data.getDataFromFirebase();
});

final dbDataProvider = StateProvider<List<Data>>((ref) => []);