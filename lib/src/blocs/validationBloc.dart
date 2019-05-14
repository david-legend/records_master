import 'dart:async';
import 'package:record_master/src/providers/login_api_provider.dart';
import 'package:http/http.dart' as http;
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class ValidationBloc extends Object with Validators {
  final _loginApiProvider = loginApiProvider();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get isEmailPasswordValid =>
      Observable.combineLatest2(email, password, (e, p) => true);

  Function(String) get emailChanged => _emailController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;

  List<String> submit() {
    final String email = _emailController.value;
    final String password = _passwordController.value;
    List<String> data = [];
    data.add(email);
    data.add(password);
    print("$email and $password");
    print("USER INFO: $data");

    return data;
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}

//  getUserData(email, password, token) async {
//    final data = await _loginApiProvider.getUserData(email, password, token);
//    String name = data.name;
//    String user_email = data.email;
//    print("USERNAME: $name and USER EMAIL: $user_email");
//  }
