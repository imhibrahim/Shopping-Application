import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shoopingapp/utlis/app_constain.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailcontroller = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  ResetPasswordlink() async {
    final email = _emailcontroller.text.trim();
    if (email.isEmpty) {
      EasyLoading.showError("Please enter your email to reset password");
      return;
    }

    try {
      EasyLoading.show(status: "Sending reset email...");
      await auth.sendPasswordResetEmail(email: email);
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Reset link sent to your email");
    } catch (e) {
      EasyLoading.show(status: "Error : ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Reset Yout password")),
      body: Container(
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
            Container(
              height: 50,
              width: 250,
              margin: EdgeInsets.only(top: 30),
              child: TextButton.icon(
                onPressed: () {
                  ResetPasswordlink();
                },
                label: Text(
                  "Reset Your Password",
                  style: TextStyle(color: AppConstent.appTextColor),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppConstent.appSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
