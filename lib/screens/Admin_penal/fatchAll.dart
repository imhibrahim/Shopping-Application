import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shoopingapp/screens/Admin_penal/addpost.dart';
import 'package:shoopingapp/screens/Admin_penal/product.dart';
import 'package:shoopingapp/widgets/admindrawer.dart';

class FatchAll extends StatefulWidget {
  const FatchAll({super.key});

  @override
  State<FatchAll> createState() => _FatchAllState();
}

class _FatchAllState extends State<FatchAll> {
  final DatabasePost = FirebaseDatabase.instance.ref("Product");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Admindrawer(),
      appBar: AppBar(title: Text("Fetching Data"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductAdd()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: FirebaseAnimatedList(
        query: DatabasePost,
        itemBuilder: (context, snapshot, animation, index) {
          String postId = snapshot.key!;
          String title = snapshot.child("Title").value as String? ?? "No Title";
          String description =
              snapshot.child("Description").value as String? ??
              "No Description";
          String Price = snapshot.child("Price").value as String? ?? "No Price";
          String Picture =
              snapshot.child("Image").value as String? ?? "Not Image Found";

          return Card(
            color: Colors.white70,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            elevation: 20,
            child: Column(
              children: [
                ListTile(
                  title: Text(title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(description),

                      Text("Price: ₹$Price"),
                      SizedBox(height: 5),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                Colors.black, // You can change the border color
                            width: 2, // Border thickness
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                              child: Image.network(
                                Picture,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        Icon(Icons.broken_image),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.green),
                        onPressed: () {
                          // Edit logic
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
                                        // deleteData(postId);
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
    ;
  }
}
