import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocebot2_0/models/data.dart';
import 'package:ocebot2_0/themes.dart';

class DataGraphRow extends StatelessWidget {
  final Data data;
  final double percentChange;
  final int sign;
  const DataGraphRow({Key? key, required this.data, required this.percentChange, required this.sign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 0),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            boxShadow: OcebotTheme.pixelShadow,
            color: OcebotTheme.primaryColor
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Center(
                  child: Container(
                      child: Text(
                        '${data.dateTime.month.toString()}/${data.dateTime.day.toString()}',
                        style: GoogleFonts.vt323(
                          textStyle: TextStyle(color: Colors.white, fontSize: 30)
                        ),
                      )
                  ),
                ),
              ),

              Expanded(
                child: Center(
                  child: Container(
                      child: Text(
                        '${data.weight}',
                        style: GoogleFonts.vt323(
                          textStyle: TextStyle(color: Colors.white, fontSize: 30)
                        ),
                      )
                  ),
                ),
              ),

              Expanded(
                child: Center(
                  child: Container(
                      child: Text(
                        '$percentChange%',
                        style: GoogleFonts.vt323(
                          textStyle: TextStyle(color: sign < 0 ? OcebotTheme.accentColor : OcebotTheme.backgroundColor, fontSize: 30)
                        ),
                      )
                    ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}