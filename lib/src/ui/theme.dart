import 'package:flutter/material.dart';

final ThemeData kLightRecordMasterTheme = _buildLightTheme();

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    headline: base.headline.copyWith(fontWeight: FontWeight.w500),
    title: base.title.copyWith(
      fontFamily: 'Raleway-Medium',
      fontWeight: FontWeight.w800,
      fontSize: 20.0
    ),
    //basically for Menu Titles and Captions
    subhead: base.subhead.copyWith(
      fontFamily: 'Raleway-Medium',
      fontWeight: FontWeight.w600,
      fontSize: 16.0,
      color: Color(0xFF0175c2), //primary color
    ),
    //basically for actions on the home screen
    display1: base.display1.copyWith(
      fontFamily: 'Raleway-Regular',
      fontWeight: FontWeight.w500,
      fontSize: 15.0,
      color: Color(0xFF003D75)
    ),
    //basically for text fields on the login screen
    display2: base.display2.copyWith(
        fontFamily: 'Raleway-Regular',
        fontWeight: FontWeight.w600,
        fontSize: 15.0,
        color: Color(0xFF003D75)
    ),
    //basically for Menu Titles
    display3: base.display3.copyWith(
        fontFamily: 'Raleway-Medium',
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        color: Colors.white
    ),
    body1: base.body1.copyWith(fontFamily: 'Roboto-Regular', fontWeight: FontWeight.w500, fontSize: 16.0),
    body2: base.body2.copyWith(fontFamily: 'Raleway-Regular', fontWeight: FontWeight.w500, fontSize: 16.0),
    button: base.button.copyWith(fontWeight: FontWeight.w500, fontSize: 14.0),
  );
}


ThemeData _buildLightTheme() {
  const Color primaryColor = Color(0xFF0175c2);
  const Color primaryColorDark = Color(0xFF003D75);
  const Color secondaryColor = Color(0xFF13B9FD);
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    accentColorBrightness: Brightness.dark,
    colorScheme: colorScheme,
    primaryColor: primaryColor,
    primaryColorDark: primaryColorDark,
    buttonColor: primaryColor,
    indicatorColor: Colors.white,
    toggleableActiveColor: const Color(0xFF1E88E5),
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    accentColor: secondaryColor,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    errorColor: const Color(0xFFB00020),
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
  );
  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}
