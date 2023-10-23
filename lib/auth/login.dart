// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:example_sqflite/admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:example_sqflite/main.dart';
import 'package:example_sqflite/auth/signup.dart';
import 'package:example_sqflite/helper/login_helper.dart';
import 'package:example_sqflite/model/user_login.dart';
import 'package:example_sqflite/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

List<String> list = <String>['Guest', 'Admin', 'Other'];

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  String dropdownValue = "Admin"; //list.first;
  late FToast fToast;
  int? check;

  SharedPreferences? pref;
  bool? isLoggedIn;
  List<Map<String, dynamic>> dataList = [];

  void setLoginState(String type) async {
    pref = await SharedPreferences.getInstance();
    
    List<Map<String, dynamic>> updateData =
        await LoginHelper.getDataByEmail(emailController.text);
    setState(() {
      dataList = updateData;
      pref?.setBool("isLogin", true);
      isLoggedIn = pref?.getBool("isLogin");
    });
    print("dataList: $dataList");
    if (dataList.isNotEmpty) {
      UserLogin user = UserLogin(
          userId: dataList[0]["userId"],
          password: passController.text,
          userName: dataList[0]["userName"],
          email: emailController.text,
          type: dropdownValue.toString(),
          level: dataList[0]["level"]);
      String jsonString = jsonEncode(user);
      pref?.setString("userData", jsonString);
      pref?.setBool("isLogin", true);
      isLoggedIn = pref?.getBool("isLogin");
      
    print("islogin: $isLoggedIn");
      // List<Map<String, dynamic>> data =
      //     await UserHelper.getDataById(dataList[0]["userId"]);
      // setState(() {
      //   dataList = data;
      // });
      // if (type == "Guest") {
      //   final User userHp = User(
      //     id: dataList[0]["id"],
      //     avatar: dataList[0]["avatar"],
      //     name: dataList[0]["name"],
      //     age: dataList[0]["age"],
      //     address: dataList[0]["address"],
      //   );
      //   String jsonUserDt = jsonEncode(userHp);
      //   pref?.setString("user", jsonUserDt);
      //   // Map<String, dynamic> userMap = userHp.toMap();
      //   // pref.setString("user", jsonEncode(userMap));
      //   print(pref?.getString("userData"));
      //   print(pref?.getString("user"));
      //   print(user.userId.toString());
      // }
    }
  }

  @override
  void initState() {
    // initPreferences();
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.blue,
          Colors.red,
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _page(),
      ),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _icon(),
              const SizedBox(height: 50),
              _inputField("Email", emailController),
              const SizedBox(height: 20),
              _inputField("Password", passController, isPassword: true),
              const SizedBox(height: 50),
              //_dropdownButton(),
              _loginBtn(),
              const SizedBox(height: 20),
              _extraText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          shape: BoxShape.circle),
      child: const Icon(Icons.person, color: Colors.white, size: 120),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {bool isNumericType = false, isPassword = false}) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.white));

    return SizedBox(
      width: Responsive.isDesktop(context) ? 500 : 350,
      child: TextField(
        style: const TextStyle(color: Colors.white),
        controller: controller,
        inputFormatters: [getInputFormatter(isNumericType)],
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          enabledBorder: border,
          focusedBorder: border,
        ),
        obscureText: isPassword,
      ),
    );
  }

  Future<void> checkLogin() async {
    await LoginHelper.checkLogin(
            emailController.text, passController.text, "Admin")
        .then((value) {
      setState(() {
        check = LoginHelper.check;
        print(LoginHelper.check);
      });
    });
  }

  Widget _loginBtn() {
    return SizedBox(
      width: Responsive.isDesktop(context) ? 500 : 350,
      child: ElevatedButton(
        onPressed: () async {
          if (emailController.text != '' && passController.text != '') {
            await checkLogin().then((value) {
              if (check == 1) {
                print('Login success');
                if (dropdownValue.toString() == "Admin") {
                  setLoginState("Admin");
                  print(isLoggedIn);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyAppAdmin()));
                }
                fToast.showToast(
                  child: const Text('Login successfully !!',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  gravity: ToastGravity.BOTTOM,
                  toastDuration: const Duration(seconds: 2),
                );
              } else if (check == 0) {
                print('Login:${emailController.text}');
                print('Login:${passController.text}');
                print('Login:${dropdownValue.toString()}');
                fToast.showToast(
                  child: const Text('This account is not exists !!',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  gravity: ToastGravity.BOTTOM,
                  toastDuration: const Duration(seconds: 2),
                );
              } else if (LoginHelper.status == 0) {
                fToast.showToast(
                  child: const Text('Your account has been banned !!',
                      style: TextStyle(
                        color: Color.fromARGB(255, 231, 108, 7),
                      )),
                  gravity: ToastGravity.CENTER,
                  toastDuration: const Duration(seconds: 2),
                );
              }
            });
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.blue,
          backgroundColor: Colors.white,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const SizedBox(
            width: double.infinity,
            child: Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            )),
      ),
    );
  }

  Widget _dropdownButton() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _extraText() {
    return TextButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignUpPage(),
            ));
      },
      child: const Text(
        "Can't access to your account? Register",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

TextInputFormatter getInputFormatter(bool isNumericKeyBoard) {
  if (isNumericKeyBoard) {
    return FilteringTextInputFormatter.allow(RegExp('[0-9]'));
  } else {
    return FilteringTextInputFormatter.allow(
        RegExp('[^"\']*[^\'\"`]', unicode: true));
  }
}
