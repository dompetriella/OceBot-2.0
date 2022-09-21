import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocebot2_0/providers/filter_provider.dart';
import 'package:ocebot2_0/services/firebase.dart';
import 'package:ocebot2_0/themes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocebot2_0/providers/db_data_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

// this is your state, equal to [state, setState], it's index 0
final dataPointProvider = StateNotifierProvider<DataPointNotifier, DataPoint>(
    (ref) => DataPointNotifier());

// this is basically setState but as a class, notifier == setState ([state, setState], it's index 1)
class DataPointNotifier extends StateNotifier<DataPoint> {
  // the super is the initial state
  DataPointNotifier() : super(DataPoint());

  void changeWeight(String weight) {
    DataPoint data = DataPoint();
    data.entryDateTime = state.entryDateTime;
    data.entryUnits = state.entryUnits;
    data.entryWeight = weight;
    state = data;
  }

  void changeUnits(String units) {
    DataPoint data = DataPoint();
    data.entryDateTime = state.entryDateTime;
    data.entryUnits = units;
    data.entryWeight = state.entryWeight;
    state = data;
  }

  void changeDate(DateTime date) {
    DataPoint data = DataPoint();
    data.entryDateTime = date;
    data.entryUnits = state.entryUnits;
    data.entryWeight = state.entryWeight;
    state = data;
  }

  void wipeData() {
    DataPoint data = DataPoint();
    data.entryDateTime = DateTime.now();
    data.entryUnits = 'g';
    data.entryWeight = '';
    state = data;
  }
}

class DataPoint {
  DateTime entryDateTime = DateTime.now();
  String entryWeight = '';
  String entryUnits = 'g';

  static String formatDate(date) {
    return date.toIso8601String().split('T').first;
  }
}

class EntryForm extends ConsumerWidget {
  TextEditingController textEditingController = TextEditingController();
  double displayWidth = 350;
  double displayHeight = 200;

  final db = FirebaseFirestore.instance.collection("weights");

  double sendWeight(String units, String weight) {
    switch (units) {
      case 'oz':
        return double.parse(
            (double.parse(weight) * 28.3495).toStringAsFixed(2));
      case 'lbs':
        return double.parse(
            (double.parse(weight) * 453.592).toStringAsFixed(2));
      default:
        return double.parse((double.parse(weight).toStringAsFixed(2)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: OcebotTheme.backgroundColor,
      elevation: 5.0,
      titleTextStyle: GoogleFonts.vt323(),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Text(
            'Cancel',
            style: GoogleFonts.vt323(),
            textScaleFactor: 2,
          ),
        ),
        TextButton(
          onPressed: () async {
            var snackbar = SnackBar(
              content: Text(
                  'Added Entry: ${ref.read(dataPointProvider).entryWeight}${ref.read(dataPointProvider).entryUnits} on ${ref.read(dataPointProvider).entryDateTime}'),
            );
            ref.watch(dataPointProvider).entryWeight != ''
                ? {
                    await db.add({
                      "date": ref.read(dataPointProvider).entryDateTime,
                      "weight": sendWeight(
                          ref.read(dataPointProvider).entryUnits,
                          ref.read(dataPointProvider).entryWeight)
                    }),
                    Navigator.pop(context, 'OK'),
                    ScaffoldMessenger.of(context).showSnackBar(snackbar),
                    ref.read(dbDataProvider.notifier).state =
                        await FirebaseService.getDataFromFirebase(
                            ref.watch(filterMonthsIntProvider))
                  }
                : null;
          },
          child: Text(
            'OK',
            style: GoogleFonts.vt323(),
            textScaleFactor: 2,
          ),
        )
      ],
      content: SizedBox(
        width: displayWidth,
        height: displayHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: displayWidth,
                color: OcebotTheme.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text("Enter Weight",
                        style:
                            OcebotTheme.lightTheme.primaryTextTheme.headline3),
                  ),
                )),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Bounce(
                    duration: Duration(milliseconds: 200),
                    onPressed: () {
                      showDatePicker(
                              builder: (context, child) {
                                return Theme(
                                    data: OcebotTheme.lightTheme,
                                    child: child!);
                              },
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2019),
                              lastDate: DateTime(2100))
                          .then((date) {
                        date != null
                            ? ref
                                .watch(dataPointProvider.notifier)
                                .changeDate(date)
                            : ref
                                .watch(dataPointProvider.notifier)
                                .changeDate(DateTime.now());
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: OcebotTheme.primaryColor,
                            shape: BoxShape.rectangle,
                            boxShadow: OcebotTheme.pixelShadow),
                        child: Icon(
                          Icons.calendar_month_rounded,
                          color: OcebotTheme.backgroundColor,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 8, 2, 12),
                    child: SizedBox(
                      width: 100,
                      child: TextField(
                        style: OcebotTheme
                            .lightTheme.primaryTextTheme.displayMedium,
                        textAlign: TextAlign.center,
                        controller: textEditingController,
                        onChanged: (text) {
                          ref
                              .watch(dataPointProvider.notifier)
                              .changeWeight(text);
                        },
                      ),
                    ),
                  ),
                  UnitsDropDown()
                ],
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .slide(
          curve: Curves.decelerate,
        )
        .scale(
          begin: 0.1,
        )
        .then()
        .scale(begin: 1.1);
  }
}

class UnitsDropDown extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButton<String>(
      focusColor: Colors.transparent,
      value: ref.watch(dataPointProvider).entryUnits,
      elevation: 16,
      style: GoogleFonts.vt323(fontSize: 25, color: OcebotTheme.primaryColor),
      underline: Container(height: 10, color: Colors.transparent),
      onChanged: (String? entryUnits) {
        ref.watch(dataPointProvider.notifier).changeUnits(entryUnits!);
        print(ref.read(dataPointProvider).entryUnits);
      },
      items: <String>['g', 'lbs', 'oz']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
