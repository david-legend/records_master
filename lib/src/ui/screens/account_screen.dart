import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  final SharedPreferences prefs;

  AccountScreen({this.prefs});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final String _userNamePrefs = "username";
  final String _emailPrefs = "email";
  bool _isInAsyncCall = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ModalProgressHUD(
      inAsyncCall: _isInAsyncCall,
      progressIndicator: CircularProgressIndicator(),
      child: Container(
        child: FutureBuilder(
          future: getSharedPreferences(),
          builder:
              (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                print(snapshot.data);
                return Center(child: Text('No user data'));
              case ConnectionState.waiting:
                print(snapshot.data);
                return new Center(child: new CircularProgressIndicator());
              case ConnectionState.active:
                print(snapshot.data);
                return new Text('');
              case ConnectionState.done:
                print(snapshot.data);
                if (snapshot.hasError) {
                  return Center(
                    child: new Text(
                      '${snapshot.error}',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else {
                  return new ListView(
                    children: <Widget>[
                      userInfo(
                          'Username', snapshot.data[0], Icons.person, theme),
                      userInfo('Email', snapshot.data[1], Icons.email, theme)
                    ],
                  );
                }
            }
          },
        ),
      ),
    );
  }

  Widget userInfo(
      String title, String subtitle, IconData icon, ThemeData theme) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: Icon(
          icon,
          color: theme.primaryColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(subtitle,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              fontFamily: "Roboto",
            )),
      ),
    );
  }

  Future<List<String>> getSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> userDetails = [];
    userDetails.add(prefs.getString(_userNamePrefs));
    userDetails.add(prefs.getString(_emailPrefs));

    return userDetails;
  }
}
