import 'package:flutter/material.dart';
import 'package:ocebot2_0/themes.dart';
import 'package:ocebot2_0/models/data.dart';
import 'data_graph_row.dart';

class DataFirebaseTable extends StatelessWidget {
  final List<Data> data;
  const DataFirebaseTable({Key? key, required this.data}) : super(key: key);

  List<DataGraphRow> createDataList(List<Data> data) {
    
    List<DataGraphRow> rows = [];
    double previousWeight = 0;
    double percentDouble = 0.0;

    for(var i = 0; i < data.length; i++) {
      var sign = previousWeight > data[i].weight ? -1 : 1;
      double percent = ((((data[i].weight - previousWeight).abs()) / previousWeight) * 100) * sign;
      previousWeight = data[i].weight;
      percentDouble = double.parse((percent).toStringAsFixed(1));
      if (percentDouble == double.infinity) {
        rows.add(DataGraphRow(data: data[i], percentChange: 0, sign: sign,));
      }
      else {
        rows.add(DataGraphRow(data: data[i], percentChange: percentDouble, sign: sign));
      }
      
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
        child: Container(
          decoration: BoxDecoration(boxShadow: OcebotTheme.pixelShadow),
          child: ListView(
            children: createDataList(data)
          ),
        ),
      )
    );
  }
}