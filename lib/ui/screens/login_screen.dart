import 'package:flutter/material.dart';
import 'package:record_master/blocs/provider.dart';
import 'package:record_master/ui/widgets/custom_submit_button.dart';
import 'package:record_master/ui/widgets/custom_text_field.dart';
import 'package:record_master/blocs/validationBloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Color theme_color = Colors.blue[700];

  Widget MainScreen(BuildContext context, ValidationBloc bloc) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            DecoratedBox(
                decoration: BoxDecoration(
                    color: theme_color
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
                child: loginCard(emailField(bloc), passwordField(bloc), submitButton(bloc)),
              )
            ]
        )
      ],
    );
  }

  Widget emailField(ValidationBloc bloc) {
    return CustomTextField(
      stream: bloc.email,
      onChanged: bloc.emailChanged,
      inputType: TextInputType.emailAddress,
      hint: "you@example.com",
      label: "EMAIL",
//      fontSize: 22.0,
      textColor: theme_color,
    );
  }

  Widget passwordField(ValidationBloc bloc) {
    return CustomTextField(
      stream: bloc.password,
      onChanged: bloc.passwordChanged,
      obscureText: true,
      hint: "your password",
      label: "PASSWORD",
//      fontSize: 22.0,
      textColor: theme_color,
    );
  }

  Widget submitButton(ValidationBloc bloc) {
    return CustomSubmitButton(
      stream: bloc.isEmailPasswordValid,
      borderRadius: 30.0,
      elevation: 4.0,
      buttonColor: theme_color,
      splashColor: Colors.blue[200],
      onPressed: bloc.submit,
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
                        fontFamily: 'Roboto',
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500
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

    return SafeArea(
      child: Scaffold(
        body: Container(
            child: ListView(
              children: <Widget>[
                MainScreen(context, bloc),
//                loginCard(emailField(bloc), passwordField(bloc), submitButton(bloc))
              ],
            )
        ),
      ),
    );
  }
}
