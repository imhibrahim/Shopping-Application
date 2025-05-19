import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shoopingapp/screens/Admin_penal/Edit_Post.dart';
import 'package:shoopingapp/screens/Admin_penal/addpost.dart';
import 'package:shoopingapp/widgets/admindrawer.dart';

class FatchData extends StatefulWidget {
  @override
  State<FatchData> createState() => _FatchDataState();
}

class _FatchDataState extends State<FatchData> {
  final DatabaseRef = FirebaseDatabase.instance.ref("Post");

  void deleteData(String postId) async {
    EasyLoading.show(status: "Deleting...");
    DatabaseRef.child(postId)
        .remove()
        .then((value) {
          EasyLoading.showSuccess("Post Deleted Successfully");
        })
        .catchError((error) {
          EasyLoading.showError("Failed to delete: $error");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Admindrawer(),
      appBar: AppBar(title: Text("Fetching Data"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addpost()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: FirebaseAnimatedList(
        query: DatabaseRef,
        itemBuilder: (context, snapshot, animation, index) {
          String postId = snapshot.key!;
          String title = snapshot.child("Title").value as String? ?? "No Title";
          String description =
              snapshot.child("Description").value as String? ??
              "No Description";

          return Card(
            color: Colors.white70,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            elevation: 20,
            child: Column(
              children: [
                ListTile(
                  title: Text(title),
                  subtitle: Text(description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.green),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => EditPost(
                                    postid: postId,
                                    title: title,
                                    desc: description,
                                  ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder:
                                (value) => AlertDialog(
                                  title: Text("Confirm Delete"),
                                  content: Text(
                                    "Are you sure you want to delete this post?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        deleteData(postId);
                                      },
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
