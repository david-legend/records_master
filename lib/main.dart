import 'package:flutter/material.dart';
import 'package:record_master/src/blocs/provider.dart';
import 'package:record_master/src/ui/screens/login_screen.dart';
import 'package:record_master/src/ui/screens/qr_code_scanner_screen.dart';
import 'package:record_master/src/ui/screens/root_screen.dart';
import 'package:record_master/src/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SharedPreferences.getInstance().then((prefs) {
    runApp(MyApp(
      prefs: prefs,
    ));
  });
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final String _accessTokenPrefs = "access_token";

  MyApp({this.prefs});

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Records Master',
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => LoginScreen(prefs: prefs),
          '/home': (BuildContext context) => RootScreen(prefs: prefs),
          '/scan': (BuildContext context) => QrCodeScannerScreen(),
        },
        theme: kLightRecordMasterTheme,
        home: _handleScreenToBeShown(),
      ),
    );
  }

  Widget _handleScreenToBeShown() {
    String userHasLoggedIn = (prefs.getString(_accessTokenPrefs) ?? null);
    if (userHasLoggedIn == null) {
      return LoginScreen(
        prefs: prefs,
      );
    }
    return RootScreen(
      prefs: prefs,
    );
  }
}
