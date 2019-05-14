import 'package:flutter/material.dart';
import 'package:record_master/src/blocs/validationBloc.dart';

class Provider extends InheritedWidget {
  final bloc = ValidationBloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static ValidationBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }
}
