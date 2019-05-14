import 'package:flutter/material.dart';
import 'package:record_master/src/ui/screens/backdrop.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootScreen extends StatefulWidget {
  final SharedPreferences prefs;

  RootScreen({this.prefs});

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackDrop(
        prefs: widget.prefs,
      ),
    );
  }
}

//logPrefs(){
//  print('TOKEN_TYPE: ${widget.prefs.getString('token_type')}');
//  print('EXPIRES_IN: ${widget.prefs.getInt('expires_in')}');
//  print('ACCESS_TOKEN ${widget.prefs.getString('access_token')}');
//  print('REFRESH_TOKEN ${widget.prefs.getString('refresh_token')}');
//}
