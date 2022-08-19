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

class MainPage extends ConsumerWidget {


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var weightData = Data.generateRandomDataList(20);

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
          child: ref.watch(authStateProvider).value?.uid != null ?
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .85,
                height: MediaQuery.of(context).size.height * .40,
                child: DataGraph(
                  data: weightData,
                )
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                child: Container(
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
                ),
              ),
              DataFirebaseTable(
                data: weightData,
              )
            ],
          )
          :
          Center(
            child: CircularProgressIndicator(
              color: OcebotTheme.primaryColor,
            )
          )
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(),
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