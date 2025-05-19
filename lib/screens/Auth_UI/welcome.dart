import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shoopingapp/screens/Auth_UI/sign_in.dart';
import 'package:shoopingapp/screens/User_penal/main_screen.dart';
import 'package:shoopingapp/utlis/app_constain.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  void signInWithGoogle() async {
    try {
      EasyLoading.show(status: "Signing in with Google...");

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        EasyLoading.dismiss();
        EasyLoading.showInfo("Google sign-in cancelled");
        return; // User cancelled the sign-in
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
        
      );

      await auth.signInWithCredential(credential);

      EasyLoading.dismiss();
      EasyLoading.showSuccess("Signed in successfully!");

      // Navigate to MainScreen after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError("Google Sign-In Error: ${e.toString()}");
      print("Google Sign-In Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppConstent.appSecondaryColor,
        title: Text(
          "Welcome To Shopping App",
          style: TextStyle(color: AppConstent.appTextColor),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 230,
                width: double.infinity,
                decoration: BoxDecoration(color: AppConstent.appSecondaryColor),
                child: Column(
                  children: [
                    Image.asset("assets/pic/splash.gif"),
                    Image.asset("assets/pic/welcome.gif"),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: const Text(
                  "Welcome To Shopping",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                margin: const EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppConstent.appSecondaryColor,
                ),
                child: TextButton.icon(
                  onPressed: signInWithGoogle,
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/pic/google.png"),
                  ),
                  label: Text(
                    "Sign in with Google",
                    style: TextStyle(color: AppConstent.appTextColor),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppConstent.appSecondaryColor,
                ),
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/pic/mail.png"),
                  ),
                  label: Text(
                    "Sign in with Email",
                    style: TextStyle(color: AppConstent.appTextColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
