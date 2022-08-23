import 'package:flutter/material.dart';
import '../themes.dart';
import 'entry_form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ocebot2_0/components/data_graph.dart';
import 'package:ocebot2_0/components/data_table.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocebot2_0/providers/db_data_provider.dart';
import 'package:ocebot2_0/providers/filter_provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: OcebotTheme.accentColor),
                ),
              ),
              const Text("Ocebot"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: OcebotTheme.accentColor),
                ),
              ),
            ],
          )),
      body: SafeArea(
        child: MainPageLoader(),
      ),
      floatingActionButton: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.white, width: 2)),
        child: FloatingActionButton(
          shape: const RoundedRectangleBorder(),
          onPressed: () => showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) => EntryForm()),
          tooltip: 'Create New Entry',
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }
}

class MainPageLoader extends ConsumerWidget {
  const MainPageLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(dbDataFutureProvider).when(
        data: (dbData) {
          return Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * .85,
                  height: MediaQuery.of(context).size.height * .35,
                  child: DataGraph(
                      data: ref.watch(dbDataProvider).length > 0
                          ? ref.watch(dbDataProvider)
                          : dbData)),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: OcebotTheme.accentColor,
                              offset: Offset(0, 5))
                        ]),
                        child: Container(
                          decoration: BoxDecoration(
                              color: OcebotTheme.accentColor,
                              boxShadow: OcebotTheme.pixelShadow),
                          width: MediaQuery.of(context).size.width * .28,
                          height: MediaQuery.of(context).size.height * .05,
                          child: Center(
                            child: Text(
                              'Filter',
                              style: GoogleFonts.vt323(
                                  textStyle: TextStyle(
                                      color: Colors.white, fontSize: 25)),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '< ${ref.watch(filterMonthsIntProvider)} mos',
                        style: GoogleFonts.vt323(
                            textStyle: TextStyle(
                                color: OcebotTheme.primaryColor, fontSize: 25)),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: OcebotTheme.secondaryColor,
                                    offset: Offset(0, 5))
                              ]),
                              child: GestureDetector(
                                onTap: () => ref
                                            .watch(filterMonthsIntProvider
                                                .notifier)
                                            .state >
                                        1
                                    ? ref
                                        .watch(filterMonthsIntProvider.notifier)
                                        .state--
                                    : ref
                                        .watch(filterMonthsIntProvider.notifier)
                                        .state = 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: OcebotTheme.tertiaryColor,
                                      boxShadow: OcebotTheme.pixelShadow),
                                  width:
                                      MediaQuery.of(context).size.width * .15,
                                  height:
                                      MediaQuery.of(context).size.height * .05,
                                  child: Icon(Icons.remove,
                                      color: OcebotTheme.primaryColor,
                                      size: 40),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: OcebotTheme.primaryColor,
                                  offset: Offset(0, 5))
                            ]),
                            child: GestureDetector(
                              onTap: () => ref
                                          .watch(
                                              filterMonthsIntProvider.notifier)
                                          .state <
                                      6
                                  ? ref
                                      .watch(filterMonthsIntProvider.notifier)
                                      .state++
                                  : ref
                                      .watch(filterMonthsIntProvider.notifier)
                                      .state = 6,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: OcebotTheme.primaryColor,
                                    boxShadow: OcebotTheme.pixelShadow),
                                width: MediaQuery.of(context).size.width * .15,
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Icon(
                                  Icons.add,
                                  color: OcebotTheme.tertiaryColor,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                child: TableHeader(),
              ),
              DataFirebaseTable(
                  data: ref.watch(dbDataProvider).length > 0
                      ? ref.watch(dbDataProvider)
                      : dbData)
            ],
          );
        },
        error: (err, stack) => Text("An error occurred"),
        loading: () => Center(child: CircularProgressIndicator()));
  }
}

class TableHeader extends StatelessWidget {
  const TableHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: OcebotTheme.pixelShadow,
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Container(
                  child: Text(
                'Date',
                style: GoogleFonts.vt323(
                    textStyle: TextStyle(
                        color: OcebotTheme.primaryColor, fontSize: 25)),
              )),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                  child: Text(
                'Weight (g)',
                style: GoogleFonts.vt323(
                    textStyle: TextStyle(
                        color: OcebotTheme.primaryColor, fontSize: 25)),
              )),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                  child: Text(
                '% Change',
                style: GoogleFonts.vt323(
                    textStyle: TextStyle(
                        color: OcebotTheme.primaryColor, fontSize: 25)),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
