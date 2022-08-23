import 'package:flutter/material.dart';
import '../themes.dart';
import 'entry_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ocebot2_0/providers/auth_provider.dart';
import 'package:ocebot2_0/components/data_graph.dart';
import 'package:ocebot2_0/components/data_table.dart';
import 'package:ocebot2_0/models/data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocebot2_0/providers/db_data_provider.dart';

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
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(),
        onPressed: () => showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => EntryForm()),
        tooltip: 'Create New Entry',
        child: const Icon(Icons.add, color: Colors.white,),
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

    return ref.watch(dbDataFutureProvider).
      when(
        data: (dbData) {
          return Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .85,
                height: MediaQuery.of(context).size.height * .35,
                child: DataGraph(
                  data: ref.watch(dbDataProvider).length > 0 ? ref.watch(dbDataProvider) : dbData
                )
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: OcebotTheme.secondaryColor, offset: Offset(
                              0, 5
                            ))
                          ]
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: OcebotTheme.tertiaryColor,
                            boxShadow: OcebotTheme.pixelShadow
                          ),
                          width: MediaQuery.of(context).size.width * .15,
                          height: MediaQuery.of(context).size.height * .05,
                          child: Icon(
                            Icons.remove,
                            color: OcebotTheme.primaryColor,
                            size: 40
                          ),
                        
                        ),
                      ),
                      Text(
                        '< 5 months',
                        style: GoogleFonts.vt323(
                          textStyle: TextStyle(color: OcebotTheme.primaryColor, fontSize: 25)
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: OcebotTheme.primaryColor, offset: Offset(
                              0, 5
                            ))
                          ]
                        ),
                        child: Container(
                        decoration: BoxDecoration(
                          color: OcebotTheme.primaryColor,
                          boxShadow: OcebotTheme.pixelShadow
                        ),
                        width: MediaQuery.of(context).size.width * .15,
                        height: MediaQuery.of(context).size.height * .05,
                        child: Icon(
                          Icons.add,
                          color: OcebotTheme.tertiaryColor,
                          size: 40,
                        ),
                          ),
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
                data: ref.watch(dbDataProvider).length > 0 ? ref.watch(dbDataProvider) : dbData
              )
            ],
          );
        }, 
        error: (err, stack) => Text("An error occurred"),
        loading: () => Center(child: CircularProgressIndicator())
      );
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
                      textStyle: TextStyle(color: OcebotTheme.primaryColor, fontSize: 25)
                    ),
                  )
              ),
            ),
          ),
          
          Expanded(
            child: Center(
              child: Container(
                  child: Text(
                    'Weight (g)',
                    style: GoogleFonts.vt323(
                      textStyle: TextStyle(color: OcebotTheme.primaryColor, fontSize: 25)
                    ),
                  )
              ),
            ),
          ),
          
          Expanded(
            child: Center(
              child: Container(
                  child: Text(
                    '% Change',
                    style: GoogleFonts.vt323(
                      textStyle: TextStyle(color: OcebotTheme.primaryColor, fontSize: 25)
                    ),
                  )
                ),
            ),
          ),
        ],
      ),
    );
  }
}