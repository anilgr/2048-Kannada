import 'package:flutter/material.dart';
import 'package:twenty_fourty_eight_kannada/home.dart';

void main() {
  runApp(MaterialApp(
    // restorationScopeId: "root",
    title: '2048',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: Home(),
  ));
}
