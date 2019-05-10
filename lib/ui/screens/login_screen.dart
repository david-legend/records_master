import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:record_master/blocs/provider.dart';
import 'package:record_master/ui/widgets/custom_submit_button.dart';
import 'package:record_master/ui/widgets/custom_text_field.dart';
import 'package:record_master/blocs/validationBloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // manage state of modal progress HUD widget in login tab
  bool _isInAsyncCall_login = false;


  Widget MainScreen(BuildContext context, ValidationBloc bloc, ThemeData theme) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            DecoratedBox(
                decoration: BoxDecoration(
                    color: theme.primaryColor
                ),
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 220.0,
                )
            ),
          ],
        ),
        Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 25.0, bottom: 15.0),
                child: Image.asset(
                  'assets/images/logo_round.png',
                  color: Colors.white,
                  width: 90.0,
                  height: 90.0,
                ),
              ),
              Center(
                child: loginCard(emailField(bloc, theme), passwordField(bloc, theme), submitButton(bloc, theme)),
              )
            ]
        )
      ],
    );
  }

  Widget emailField(ValidationBloc bloc, ThemeData theme) {
    return CustomTextField(
      stream: bloc.email,
      onChanged: bloc.emailChanged,
      inputType: TextInputType.emailAddress,
      hint: "youremail@example.com",
      label: "EMAIL",
      styles: theme.textTheme.display1,
    );
  }

  Widget passwordField(ValidationBloc bloc, ThemeData theme) {
    return CustomTextField(
      stream: bloc.password,
      onChanged: bloc.passwordChanged,
      obscureText: true,
      hint: "password",
      label: "PASSWORD",
      styles: theme.textTheme.display1,
    );
  }

  Widget submitButton(ValidationBloc bloc, ThemeData theme) {
    return CustomSubmitButton(
      stream: bloc.isEmailPasswordValid,
      borderRadius: 30.0,
      elevation: 4.0,
      buttonColor: theme.primaryColor,
      splashColor: Colors.blue[200],
      onPressed: logUserIn,
      textColor: Colors.white,
      title: "S I G N  I N",
    );
  }

  Widget loginCard(Widget emailField, Widget passwordField, Widget submitButton) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 8.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      'SIGN IN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.green[500],
                        fontFamily: 'Raleway-Regular',
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: emailField,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: passwordField,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
                    child: submitButton,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: _isInAsyncCall_login,
          progressIndicator: CircularProgressIndicator(),
          child: Container(
              child: ListView(
                children: <Widget>[
                  MainScreen(context, bloc, theme),
                ],
              )
          ),
        ),
      ),
    );
  }

  navigateToHomeScreen() {
    Navigator.of(context).pushNamed("/home");
  }

  void logUserIn() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    setState(() {
      _isInAsyncCall_login = true;
    });

    //Simulate a service call
    print('submitting to backend...');
    new Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        _isInAsyncCall_login = false;
      });
      navigateToHomeScreen();
    });
  }
}
