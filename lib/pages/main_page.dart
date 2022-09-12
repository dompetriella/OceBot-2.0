import 'package:flutter/material.dart';
import '../themes.dart';
import 'entry_form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ocebot2_0/components/data_graph.dart';
import 'package:ocebot2_0/components/data_table.dart';
import 'package:ocebot2_0/components/filter.dart';
import 'package:ocebot2_0/components/table_header.dart';
import 'package:ocebot2_0/providers/db_data_provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Stack(
            children: [
              GestureDetector(
                onTap: () => showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => EntryForm()),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: OcebotTheme.accentColor,
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2, color: OcebotTheme.secondaryColor),
                        BoxShadow(spreadRadius: 3, color: Colors.white),
                        BoxShadow(
                            spreadRadius: 2, color: OcebotTheme.primaryColor),
                      ],
                    ),
                    width: MediaQuery.of(context).size.width * .08,
                    height: MediaQuery.of(context).size.height * .04,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
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
              )
            ],
          )),
      body: const SafeArea(
        child: MainPageLoader(),
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
          ref.watch(minHeightGraphProvider.notifier).state = dbData.graphMin;
          ref.watch(maxHeightGraphProvider.notifier).state = dbData.graphMax;
          return Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * .85,
                  height: MediaQuery.of(context).size.height * .35,
                  child: DataGraph(
                      data:
                          ref.watch(dbDataProvider).dataFromFirebase.isNotEmpty
                              ? ref.watch(dbDataProvider).dataFromFirebase
                              : dbData.dataFromFirebase)),
              const Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 12.0),
                  child: Filter(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                child: TableHeader(),
              ),
              DataFirebaseTable(
                  data: ref.watch(dbDataProvider).dataFromFirebase.isNotEmpty
                      ? ref.watch(dbDataProvider).dataFromFirebase
                      : dbData.dataFromFirebase)
            ],
          );
        },
        error: (err, stack) => const Text("An error occurred"),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
