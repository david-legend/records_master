import 'package:flutter/material.dart';
import 'package:record_master/blocs/provider.dart';
import 'package:record_master/ui/screens/qr_code_scanner_screen.dart';
import 'package:record_master/ui/screens/root_screen.dart';
import 'package:record_master/ui/screens/login_screen.dart';
import 'package:record_master/ui/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Records Master',
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => LoginScreen(),
          '/home': (BuildContext context) => RootScreen(),
          '/scan': (BuildContext context) => QrCodeScannerScreen(),
        },
        theme: kLightRecordMasterTheme,
        home: LoginScreen(),
      ),
    );
  }
}


