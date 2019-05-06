import 'package:flutter/material.dart';
import 'package:record_master/ui/screens/backdrop.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackdropDemo(),
    );
  }
}
