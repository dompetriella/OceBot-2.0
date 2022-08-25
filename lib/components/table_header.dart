import 'package:flutter/material.dart';
import 'package:ocebot2_0/themes.dart';
import 'package:google_fonts/google_fonts.dart';

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
