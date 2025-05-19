import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shoopingapp/screens/Auth_UI/sign_in.dart';
import 'package:shoopingapp/utlis/app_constain.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  void register() async {
    try {
      final String email = _emailcontroller.text.trim();
      final String password = _passwordcontroller.text.trim();
      EasyLoading.show(status: "User Create successfully........");
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);

      EasyLoading.dismiss();
      print("User Create successfully........");
      _emailcontroller.clear();
      _passwordcontroller.clear();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
      );
    } catch (e) {
      EasyLoading.showError("${e}");
      EasyLoading.dismiss();
      print(e);
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
              "Sign UP",
              style: TextStyle(color: AppConstent.appTextColor),
            ),
            backgroundColor: AppConstent.appSecondaryColor,
          ),
          body: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Welcome To My App",
                    style: TextStyle(
                      color: AppConstent.appMainColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        cursorColor: AppConstent.appSecondaryColor,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "User Name",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        cursorColor: AppConstent.appSecondaryColor,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "+92 2434332432",
                          prefixIcon: Icon(Icons.numbers),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),

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
                height: 50,
                width: 250,
                margin: EdgeInsets.only(top: 30),
                child: TextButton.icon(
                  onPressed: () {
                    register();
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

              Container(
                margin: EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      color: AppConstent.appMainColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
