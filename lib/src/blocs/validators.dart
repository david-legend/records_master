import 'dart:async';

Pattern pattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
mixin Validators {
  static final String emailErrorMessage = "Enter a valid email.";
  static final String passwordErrorMessage =
      "Password must have at least 5 characters";


  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if(email.contains(RegExp(pattern))) {
        sink.add(email);
      } else {
        sink.addError(emailErrorMessage);
      }
    }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if(password.toString().length >= 6) {
        sink.add(password);
      } else {
        sink.addError(passwordErrorMessage);
      }
    }
  );



}
