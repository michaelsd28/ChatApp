import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/views/authentication/Login_widget.dart';
import 'components/views/dashboard/Dashboard.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(body: Login_widget()),
  ));
}


