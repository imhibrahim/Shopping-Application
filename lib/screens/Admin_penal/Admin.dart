import 'package:flutter/material.dart';
import 'package:shoopingapp/widgets/admindrawer.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("My Admin Penel")),
drawer: Admindrawer(),

    );
  }
}
