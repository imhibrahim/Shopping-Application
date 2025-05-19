import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shoopingapp/screens/Admin_penal/fatchAll.dart';
import 'package:shoopingapp/screens/Admin_penal/fatchData.dart';
import 'package:shoopingapp/utlis/app_constain.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  final DatabaseRef = FirebaseDatabase.instance.ref("Post");
  final DatabasePost = FirebaseDatabase.instance.ref("Product");
  final NameController = TextEditingController();
  final DescController = TextEditingController();
  final PriceController = TextEditingController();
  final imageController = TextEditingController();

  void AddProduct() {
    final title = NameController.text.trim();
    final desc = DescController.text.trim();
    final price = PriceController.text.trim();
    final Image = imageController.text.trim();

    if (title.isEmpty ||
        desc.isEmpty ||
        price.isEmpty ||
        Image.isEmpty ||
        SelectedTitle == null) {
      EasyLoading.showError("All fields are required!");
      return;
    }
    EasyLoading.show(status: "Uploading...");

    final String postId = DateTime.now().microsecondsSinceEpoch.toString();

    DatabasePost.child(postId)
        .set({
          'Title': title,
          'Description': desc,
          'Price': price,
          'Image': Image,
          'Category': SelectedTitle,
        })
        .then((value) {
          EasyLoading.showSuccess("Data Inserted");
          NameController.clear();
          NameController.clear();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FatchAll()),
          );
        })
        .catchError((error) {
          EasyLoading.showError("Data not inserted: $error");
        });
  }

  String? SelectedTitle;
  List<String> PostTitle = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetCategory();
  }

  void GetCategory() async {
    DatabaseEvent event = await DatabaseRef.once();
    DataSnapshot datasnapshot = event.snapshot;
    Map<dynamic, dynamic>? data = datasnapshot.value as Map<dynamic, dynamic>?;
    if (data != null) {
      List<String> titles = [];
      data.forEach((key, value) {
        if (value is Map && value.containsKey('Title')) {
          titles.add(value['Title'].toString());
        }
      });
      setState(() {
        PostTitle = titles;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product With Categories"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FatchData()),
              );
            },
            icon: Icon(Icons.data_array),
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: "Select Category",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items:
                      PostTitle.map((String title) {
                        return DropdownMenuItem<String>(
                          value: title,
                          child: Text(title),
                        );
                      }).toList(),
                  onChanged: (String? NewValue) {
                    setState(() {
                      SelectedTitle = NewValue;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: NameController,
                  cursorColor: const Color.fromRGBO(152, 18, 6, 1),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Name",
                    prefixIcon: Icon(Icons.add_card),
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
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Description",
                    prefixIcon: Icon(Icons.assignment),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: PriceController,
                  cursorColor: AppConstent.appSecondaryColor,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Price",
                    prefixIcon: Icon(Icons.money),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: imageController,
                  cursorColor: AppConstent.appSecondaryColor,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Image",
                    prefixIcon: Icon(Icons.image),
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
                  onPressed: AddProduct,
                  label: Text(
                    "Add Post",
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
      ),
    );
  }
}
