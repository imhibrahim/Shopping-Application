import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shoopingapp/screens/Admin_penal/fatchData.dart';
import 'package:shoopingapp/utlis/app_constain.dart';
import 'package:shoopingapp/widgets/admindrawer.dart';

class EditPost extends StatefulWidget {
  //const EditPost({super.key});

  final String postid;
  final String title;
  final String desc;
  EditPost({required this.postid, required this.title, required this.desc});
  @override
  State<EditPost> createState() => _EditPostState();}
class _EditPostState extends State<EditPost> {
  final NameController = TextEditingController();
  final DescController = TextEditingController();
  final DatabaseRef = FirebaseDatabase.instance.ref("Post");
  @override
  void initState() {
    NameController.text = widget.title;
    DescController.text = widget.desc;}
  void updatedata() {
    final title = NameController.text.trim();
    final desc = DescController.text.trim();
    if (title.isEmpty || desc.isEmpty) {
      EasyLoading.showError("All fields are required!");
      return;}
    EasyLoading.show(status: "Uploading...");
    DatabaseRef.child(widget.postid)
        .update({'Title': title, 'Description': desc})
        .then((value) {
          EasyLoading.showSuccess("Data Updated Successfully....");
          NameController.clear();
          NameController.clear();
          Navigator.push(context,MaterialPageRoute(builder: (context) => FatchData()),
          );
        })
        .catchError((error) {
          EasyLoading.showError("Data not inserted: $error");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Admindrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit Post"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FatchData()),
              );
            },
            icon: Icon(Icons.logout_sharp),
          ),
        ],
      ),

      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: NameController,
                    cursorColor: AppConstent.appSecondaryColor,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "Name",
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
                    controller: DescController,
                    cursorColor: AppConstent.appSecondaryColor,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Description",
                      prefixIcon: Icon(Icons.numbers),
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
              onPressed: updatedata,
              label: Text(
                "Edit Post",
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
    );
    ;
  }
}
