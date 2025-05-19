import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/state_manager.dart';
import 'package:shoopingapp/screens/Admin_penal/Admin.dart';
import 'package:shoopingapp/screens/Auth_UI/ResetPassword.dart';
import 'package:shoopingapp/screens/Auth_UI/signup.dart';
import 'package:shoopingapp/screens/Auth_UI/splash.dart';
import 'package:shoopingapp/screens/User_penal/main_screen.dart';
import 'package:shoopingapp/utlis/app_constain.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final admin = "imh774077@gmail.com";

  void login() async {
    try {
      final String email = _emailcontroller.text.trim();
      final String password = _passwordcontroller.text.trim();

      EasyLoading.show(status: "User Login Successfully ......!");

      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);

      print("User Login Successfully ......!");
      EasyLoading.dismiss();
      _emailcontroller.clear();
      _passwordcontroller.clear();
      if (email == admin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      }
    } catch (e) {
      EasyLoading.show(status: "Error :${e}");
      EasyLoading.dismiss();
      print("Error : ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Sign In",
              style: TextStyle(color: AppConstent.appTextColor),
            ),
            backgroundColor: AppConstent.appSecondaryColor,
          ),
          body: Column(
            children: [
              Container(
                child: Column(
                  children: [Image.asset("assets/pic/signin.gif", height: 200)],
                ),
                height: 200,
                width: double.infinity,
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: _emailcontroller,
                        cursorColor: AppConstent.appSecondaryColor,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "@Example.com",
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: _passwordcontroller,
                        cursorColor: AppConstent.appSecondaryColor,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.password_outlined),
                          suffixIcon: Icon(Icons.visibility_off),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ResetPassword()),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppConstent.appMainColor,
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                margin: EdgeInsets.only(top: 30),
                child: TextButton.icon(
                  onPressed: () {
                    login();
                  },
                  label: Text(
                    "Sign in",
                    style: TextStyle(color: AppConstent.appTextColor),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppConstent.appSecondaryColor,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Text(
                          "Dont't have an account ?",
                          style: TextStyle(color: AppConstent.appMainColor),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Signup()),
                            );
                          },
                          child: Text(
                            "Sign UP",
                            style: TextStyle(
                              color: AppConstent.appMainColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
