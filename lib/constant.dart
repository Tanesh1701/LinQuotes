import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color secondaryColor = Color(0xffff1a75);
Color authorColor = Color(0xffa6a6a6);
Color quoteColor = Colors.white;
Color screenColor = Colors.black;

class FontProperties extends StatelessWidget {
  final String textToBeUsed;
  final Color color;
  final double sizeFont;
  FontProperties({this.textToBeUsed, this.color, this.sizeFont});

  @override
  Widget build(BuildContext context) {
    return Text(
      textToBeUsed,
      style: GoogleFonts.roboto(
          textStyle: TextStyle(color: color, fontSize: sizeFont)),
    );
  }
}

class SizeConfig {
 static MediaQueryData _mediaQueryData;
 static double screenWidth;
 static double screenHeight;
 static double blockSizeHorizontal;
 static double blockSizeVertical;
 
 void init(BuildContext context) {
  _mediaQueryData = MediaQuery.of(context);
  screenWidth = _mediaQueryData.size.width;
  screenHeight = _mediaQueryData.size.height;
  blockSizeHorizontal = screenWidth / 100;
  blockSizeVertical = screenHeight / 100;
 }
}
