import 'package:flutter/material.dart';

class MeusTemas {
  //final String appName = "Restaurant App UI KIT";
  static Color ratingBG = Colors.yellow[600];

  //final Map<dynamic, dynamic> map;

  //final Map<String , ThemeData> themesLight =  { " " , lightTheme0 } ;

  static List<Tema> meusTemas = [
    Tema(
        codigo: "1",
        descricao: "Purple",
        lightTheme: _purpleLight,
        darkTheme: _purpleDark),
    Tema(
        codigo: "2",
        descricao: "Vermelho",
        lightTheme: _vermelhoLight,
        darkTheme: _vermelhoDark),
    Tema(
        codigo: "3",
        descricao: "Verde",
        lightTheme: _verdeLight,
        darkTheme: _verdeDark),
  ];

  static List<DropdownMenuItem<String>> listDDTemas = meusTemas
      .map((e) => DropdownMenuItem<String>(
            value: e.codigo,
            child: Text(e.descricao),
          ))
      .toList();

  ///////////
  static ThemeData _purpleLight = 
      ThemeData(
        primaryColor: Colors.purple[800],
        // primaryColorLight: Color(0xff3700b3) ,
        // primaryColorDark: Color(0xff3700b3) ,

        accentColor:
            Color(0xff3700b3), //Colors.purple[900], // mais forte que primary

        // colorScheme: ColorScheme(
        //   primary: Colors.purple[800], //Color(0xff6200ee),
        //   primaryVariant: Color(0xff38006B),
        //   secondary: Color(0xff4A148C),
        //   secondaryVariant: Color(0xff12005E),
        //   surface: Color(0xffFFFFFF),
        //   background: Color(0xffFFFFFF),
        //   error: Color(0xffB00020),
        //   onPrimary: Color(0xffFFFFFF),
        //   onSecondary: Color(0xffFFFFFF),
        //   onSurface: Color(0xffFFFFFF),
        //   onBackground: Color(0xffFFFFFF),
        //   onError: Color(0xffFFFFFF),
        //   brightness: Brightness.light,
        // ),

        scaffoldBackgroundColor: Colors.grey[100],
        backgroundColor: Colors.grey[500], //lightBG,
        bottomAppBarColor: Colors.white,
      );
  static ThemeData _purpleDark = ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.purple[800],
        accentColor: Colors.purple[300], // mais fraco que primery
        scaffoldBackgroundColor: Colors.black,
        bottomAppBarColor: Colors.black,
      );
  ////////////
  ///////////
  static ThemeData _vermelhoLight = ThemeData(
    primaryColor: Color(0xffD32F2F),
    accentColor: Color(0xFFBA3720), // mais forte que primary
    scaffoldBackgroundColor: Colors.grey[50],
    backgroundColor: Colors.grey[500], //lightBG,
    bottomAppBarColor: Colors.white,
  );
  static ThemeData _vermelhoDark = ThemeData(
    brightness: Brightness.dark,
    primaryColor:  Color(0xFFBA3720),
    accentColor: Color(0xFFC76718), // mais fraco que primery
    scaffoldBackgroundColor: Colors.black,
    bottomAppBarColor: Colors.black,
  );
  ////////////
  ///////////
  static ThemeData _verdeLight = ThemeData(
    primaryColor: Colors.green[600],
    accentColor: Colors.green[900], // mais forte que primary
    scaffoldBackgroundColor: Colors.grey[50],
    backgroundColor: Colors.grey[500], //lightBG,
    bottomAppBarColor: Colors.white,
  );
  static ThemeData _verdeDark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green[600],
    accentColor: Colors.greenAccent[400], // mais fraco que primery
    scaffoldBackgroundColor: Colors.black,
    bottomAppBarColor: Colors.black,
  );
  ////////////
}

class Tema {
  String codigo;
  String descricao;
  ThemeData lightTheme;
  ThemeData darkTheme;

  Tema({this.codigo, this.descricao, this.lightTheme, this.darkTheme});
}

ThemeData buildAppTheme(MaterialColor primarySwatch, ThemeData theme) {
  final textTheme = theme.textTheme;
  final accentColor = primarySwatch[500];
  final primaryColorDark = primarySwatch[700];

  return theme.copyWith(
    textTheme: textTheme.copyWith(
      bodyText2: textTheme.bodyText2.copyWith(fontSize: 12),
      bodyText1: textTheme.bodyText1.copyWith(fontSize: 12),
      subtitle2:
          textTheme.subtitle2.copyWith(color: primarySwatch[400], fontSize: 12),
      headline6: textTheme.headline6.copyWith(color: primarySwatch[300]),
      headline5: textTheme.headline5.copyWith(color: primarySwatch),
    ),
    primaryColor: primarySwatch,
    primaryColorBrightness: ThemeData.estimateBrightnessForColor(primarySwatch),
    primaryColorLight: primarySwatch[100],
    primaryColorDark: primaryColorDark,
    toggleableActiveColor: primarySwatch[600],
    accentColor: accentColor,
    primaryIconTheme: IconThemeData.fallback().copyWith(color: Colors.yellow),
    secondaryHeaderColor: primarySwatch[50],
    textSelectionColor: primarySwatch[200],
    textSelectionHandleColor: primarySwatch[300],
    backgroundColor: primarySwatch[200],
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: primarySwatch,
      primaryColorDark: primarySwatch[700],
      accentColor: accentColor,
      cardColor: Colors.white,
    ),
  );
}

//   static ThemeData lightTheme = ThemeData(
//     backgroundColor: lightBG,
//     primaryColor: lightPrimary,
//     accentColor:  lightAccent,
//     cursorColor: lightAccent,
//     scaffoldBackgroundColor: lightBG,
//     appBarTheme: AppBarTheme(
//       color: lightPrimary,
//       textTheme: TextTheme(
//         headline6: TextStyle(
//           color: lightBG,
//           fontSize: 18.0,
//           fontWeight: FontWeight.w800,
//         ),
//       ),
// //      iconTheme: IconThemeData(
// //        color: lightAccent,
// //      ),
//     ),

//   );

//   static ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     backgroundColor: darkBG,
//     primaryColor: darkPrimary,
//     accentColor: darkAccent,
//     scaffoldBackgroundColor: darkBG,
//     cursorColor: darkAccent,
//     appBarTheme: AppBarTheme(
//       color: darkPrimary,
//       textTheme: TextTheme(
//         headline6: TextStyle(
//           color: lightBG,
//           fontSize: 18.0,
//           fontWeight: FontWeight.w800,
//         ),
//       ),
// //      iconTheme: IconThemeData(
// //        color: darkAccent,
// //      ),
//     ),
//   );

// Hex Opacity Values

// 100% — FF

// 95% — F2

// 90% — E6

// 85% — D9

// 80% — CC

// 75% — BF

// 70% — B3

// 65% — A6

// 60% — 99

// 55% — 8C

// 50% — 80

// 45% — 73

// 40% — 66

// 35% — 59

// 30% — 4D

// 25% — 40

// 20% — 33

// 15% — 26

// 10% — 1A

// 5% — 0D

// 0% — 00
