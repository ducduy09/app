import 'package:example_sqflite/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppAdmin extends StatefulWidget {
  const MyAppAdmin({super.key});

  @override
  State<MyAppAdmin> createState() => _MyAppAdminState();
}

class _MyAppAdminState extends State<MyAppAdmin> {

  void deleteSharedPreferencesCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void logout() async {
    setState(() {
      deleteSharedPreferencesCache();
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 51, 122, 245),
        leading: Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ))),
        title: const Text('Setting',
            style: TextStyle(
              color: Colors.white,
            )),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30.0),
            ListTile(
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.redAccent),
              ),
              trailing: const Icon(
                Icons.login,
                color: Colors.red,
              ),
              onTap: () {
                logout();
                // clearCache();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
                // //Restart.restartApp();
                // Phoenix.rebirth(context);
              },
            ),
   ] )));
  }
}