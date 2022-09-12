import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ocebot2_0/models/data.dart';
import 'package:ocebot2_0/providers/db_data_provider.dart';
import 'package:ocebot2_0/themes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataGraph extends ConsumerWidget {
  final List<Data> data;

  const DataGraph({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 8.0),
      child: LineChart(LineChartData(
          titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: leftTitleWidgets,
                  reservedSize: 40,
                  interval: 1,
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: bottomTitleWidgets,
              ))),
          minY: ref.watch(minHeightGraphProvider).toDouble(),
          maxY: ref.watch(maxHeightGraphProvider).toDouble(),
          borderData: FlBorderData(show: false),
          lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: OcebotTheme.tertiaryColor,
          )),
          lineBarsData: [Data.DataListToCoordinates(data)])),
    );
  }
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  var style = GoogleFonts.vt323(fontSize: 22, color: OcebotTheme.primaryColor);
  String text;
  switch (value.toInt()) {
    case 40:
      text = '40g';
      break;
    case 60:
      text = '60g';
      break;
    case 80:
      text = '80g';
      break;
    case 100:
      text = '100g';
      break;
    case 120:
      text = '120g';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  var style = GoogleFonts.vt323(fontSize: 22, color: OcebotTheme.primaryColor);
  Widget text;
  switch (value.toInt()) {
    case 1:
      text = Text('JAN', style: style);
      break;
    case 32:
      text = Text('FEB', style: style);
      break;
    case 60:
      text = Text('MAR', style: style);
      break;
    case 91:
      text = Text('APR', style: style);
      break;
    case 121:
      text = Text('MAY', style: style);
      break;
    case 152:
      text = Text('JUN', style: style);
      break;
    case 182:
      text = Text('JUL', style: style);
      break;
    case 213:
      text = Text('AUG', style: style);
      break;
    case 244:
      text = Text('SEP', style: style);
      break;
    case 274:
      text = Text('OCT', style: style);
      break;
    case 305:
      text = Text('NOV', style: style);
      break;
    case 335:
      text = Text('DEC', style: style);
      break;
    default:
      text = Text('', style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 8.0,
    child: text,
  );
}
