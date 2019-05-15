import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:record_master/src/providers/login_api_provider.dart';
import 'package:record_master/src/ui/screens/backdrop.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootScreen extends StatefulWidget {
  final SharedPreferences prefs;

  RootScreen({this.prefs});

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final _loginApiProvider = loginApiProvider();
  final String _accessTokenPrefs = "access_token";
  final String _emailPrefs = "email";
  final String _passwordPrefs = "password";
  bool _isInAsyncCallUserDetails = false;

  @override
  void initState() {
    super.initState();
    String email = (widget.prefs.getString(_emailPrefs) ?? null);
    String password = (widget.prefs.getString(_passwordPrefs) ?? null);
    String username = (widget.prefs.getString('username') ?? null);
    if (username == null) {
      getUserData(email, password);
    }
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to exit Record Master'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () {
                      //Navigator.of(context).pop(true);
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                    child: new Text('Yes'),
                  ),
                ],
              ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: ModalProgressHUD(
        inAsyncCall: _isInAsyncCallUserDetails,
        progressIndicator: CircularProgressIndicator(),
        child: Scaffold(
          body: BackDrop(
            prefs: widget.prefs,
          ),
        ),
      ),
    );
  }

  Future getUserData(email, password) async {
    try {
//      _turnOnProgressIndicator();
      String token = (widget.prefs.getString(_accessTokenPrefs) ?? null);
      final userData =
          await _loginApiProvider.getUserData(email, password, token);
      final String username = userData.data.name;
      print("USERNAME IS CORRECT: $username");

      if (username == null) {
        print("USER NAME : ${username}");
        _turnOffProgressIndicator();
      } else {
        _saveUserToken(userData);
        print("USER NAME REALLY: $username");
        _turnOffProgressIndicator();
      }
    } catch (e) {
      _turnOffProgressIndicator();
    }
  }

  _saveUserToken(userData) {
    widget.prefs.setString('username', userData.data.name);
    widget.prefs.setInt('email2', userData.data.email);
  }

  _turnOnProgressIndicator() {
    setState(() {
      _isInAsyncCallUserDetails = true;
    });
  }

  _turnOffProgressIndicator() {
    setState(() {
      _isInAsyncCallUserDetails = false;
    });
  }
}

//logPrefs(){
//  print('TOKEN_TYPE: ${widget.prefs.getString('token_type')}');
//  print('EXPIRES_IN: ${widget.prefs.getInt('expires_in')}');
//  print('ACCESS_TOKEN ${widget.prefs.getString('access_token')}');
//  print('REFRESH_TOKEN ${widget.prefs.getString('refresh_token')}');
//}
