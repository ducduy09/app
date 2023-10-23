// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:example_sqflite/admin.dart';
import 'package:example_sqflite/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:example_sqflite/model/user_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

late SharedPreferences pref;
bool? isLoggedIn = false;
UserLogin? user;
void initPreferences() async {
  pref = await SharedPreferences.getInstance();
  String? userData = pref.getString("userData");
  if (userData != null) {
    user = UserLogin.fromMap(jsonDecode(userData));
  }
  isLoggedIn = pref.getBool("isLogin");
  print(user?.type.toString());
  print(isLoggedIn);
}

void main() {
  sqfliteFfiInit();
  initPreferences();
  if (kIsWeb) {
    // Change default factory on the web
    databaseFactory = databaseFactoryFfiWeb;
  } else {
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MKB App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isLoggedIn != true
          ? const LoginPage()
          : const MyAppAdmin(),
    );
  }
}
