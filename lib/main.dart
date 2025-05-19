import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:shoopingapp/firebase_options.dart';
import 'package:shoopingapp/screens/Admin_penal/Admin.dart';
import 'package:shoopingapp/screens/Admin_penal/fatchAll.dart';
import 'package:shoopingapp/screens/Admin_penal/fatchData.dart';
import 'package:shoopingapp/screens/Admin_penal/product.dart';
import 'package:shoopingapp/screens/Auth_UI/sign_in.dart';
import 'package:shoopingapp/screens/Auth_UI/signup.dart';
import 'package:shoopingapp/screens/Auth_UI/splash.dart';
import 'package:shoopingapp/screens/Auth_UI/welcome.dart';
import 'package:shoopingapp/widgets/admindrawer.dart';
import 'screens/User_penal/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Shopping',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      //home: AdminScreen(),
      //home: Signup(),
      home: FatchData(),
      //home: SignIn(),
      builder: EasyLoading.init(),
    );
  }
}
