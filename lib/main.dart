import 'package:flutter/material.dart';
import 'package:twenty_fourty_eight_kannada/home.dart';

void main() {
  runApp(MaterialApp(
    title: '2048',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: Home(),
  ));
}
