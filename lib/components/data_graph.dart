import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ocebot2_0/models/data.dart';

class DataGraph extends StatelessWidget {
  final List<Data> data;

  const DataGraph({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  reservedSize: 30,
                  interval: 6,
                  
                )
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false
                ),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false
                )
              )
            ),
            minY: 10,
            maxY: 90,
            borderData: FlBorderData(show: false),
            lineBarsData: [
              Data.DataListToCoordinates(data)
            ]
            )
          ),
        );
  }
}