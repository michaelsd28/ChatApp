import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'components/views/authentication/Login_widget.dart';

void main() {
  runApp(const GetMaterialApp(
    home: Scaffold(body: Login_widget()),
  ));
}


