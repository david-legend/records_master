import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class ValidationBloc extends Object with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);

  Stream<bool> get isEmailPasswordValid =>
      Observable.combineLatest2(email, password, (e, p) => true);

  Function(String) get emailChanged => _emailController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;


  submit() {
    print('EMAIL AND PASSWORD ARE VALID');
  }


  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}