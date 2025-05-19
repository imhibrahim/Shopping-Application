import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shoopingapp/screens/Admin_penal/addpost.dart';

class Admindrawer extends StatefulWidget {
  const Admindrawer({super.key});

  @override
  State<Admindrawer> createState() => _AdmindrawerState();
}

class _AdmindrawerState extends State<Admindrawer> {
  String _userEmail = '';
  @override
  void initState() {
    super.initState();
    getUser();
  }
  void getUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userEmail = user.email ?? '';
      });
    } else {
      print("No user is currently signed in.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(child: Text("M.I")),
            otherAccountsPictures: [CircleAvatar(child: Text("M.I"))],
            accountName: Text("Muhamad Ibrahim"),
            accountEmail: Text(
              _userEmail.isNotEmpty
                  ? 'Email: $_userEmail'
                  : 'No user email found.',
            ),
          ),

          ListTile(
            leading: Icon(Icons.book),
            title: Text("Post"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Addpost()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.home_max),
            title: Text("Home"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Admindrawer()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Sign Out"),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
          ListTile(leading: Icon(Icons.verified_user), title: Text("Verified")),
          ListTile(leading: Icon(Icons.stacked_bar_chart), title: Text("Home")),
          ListTile(leading: Icon(Icons.money), title: Text("PKR")),
        ],
      ),
    );
  }
}
