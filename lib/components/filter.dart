import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ocebot2_0/providers/db_data_provider.dart';
import 'package:ocebot2_0/themes.dart';
import 'package:ocebot2_0/providers/filter_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocebot2_0/services/firebase.dart';
import 'package:flutter_animate/animate.dart';

class Filter extends ConsumerWidget {
  const Filter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            FirebaseService.getDataFromFirebase(
                    ref.read(filterMonthsIntProvider))
                .then((value) =>
                    ref.watch(dbDataProvider.notifier).state = value);
          },
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(color: OcebotTheme.accentColor, offset: Offset(0, 5))
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
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 25)),
                ),
              ),
            ),
          ),
        ),
        Text(
          '< ${ref.watch(filterMonthsIntProvider)} mos',
          style: GoogleFonts.vt323(
              textStyle:
                  TextStyle(color: OcebotTheme.primaryColor, fontSize: 25)),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: OcebotTheme.secondaryColor, offset: Offset(0, 5))
                ]),
                child: GestureDetector(
                  onTap: () =>
                      ref.watch(filterMonthsIntProvider.notifier).state > 1
                          ? ref.watch(filterMonthsIntProvider.notifier).state--
                          : ref.watch(filterMonthsIntProvider.notifier).state =
                              1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: OcebotTheme.tertiaryColor,
                        boxShadow: OcebotTheme.pixelShadow),
                    width: MediaQuery.of(context).size.width * .15,
                    height: MediaQuery.of(context).size.height * .05,
                    child: Icon(Icons.remove,
                        color: OcebotTheme.primaryColor, size: 40),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(color: OcebotTheme.primaryColor, offset: Offset(0, 5))
              ]),
              child: GestureDetector(
                onTap: () =>
                    ref.watch(filterMonthsIntProvider.notifier).state < 6
                        ? ref.watch(filterMonthsIntProvider.notifier).state++
                        : ref.watch(filterMonthsIntProvider.notifier).state = 6,
                child: Container(
                  decoration: BoxDecoration(
                      color: OcebotTheme.primaryColor,
                      boxShadow: OcebotTheme.pixelShadow),
                  width: MediaQuery.of(context).size.width * .15,
                  height: MediaQuery.of(context).size.height * .05,
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
    );
  }
}
