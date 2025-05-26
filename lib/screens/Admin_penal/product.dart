import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoopingapp/screens/Admin_penal/fatchAll.dart';
import 'package:shoopingapp/screens/Admin_penal/fatchData.dart';
import 'package:shoopingapp/screens/Admin_penal/productList.dart';
import 'package:shoopingapp/utlis/app_constain.dart';
import 'package:shoopingapp/widgets/admindrawer.dart';
import 'dart:html' as html;

class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  String? SelectedTitle;
  List<String> PostTitle = [];

  @override
  void initState() {
    super.initState();
    category();
  }

  void category() async {
    DatabaseEvent event = await databaseRef.once();
    DataSnapshot dataSnapshot = event.snapshot;
    Map<dynamic, dynamic>? data = dataSnapshot.value as Map<dynamic, dynamic>?;

    if (data != null) {
      List<String> titles = [];
      data.forEach((key, value) {
        if (value is Map && value.containsKey("Title")) {
          titles.add(value['Title'].toString());
        }
      });
      setState(() {
        PostTitle = titles;
      });
    }
  }

  final ProductController = TextEditingController();
  final DescController = TextEditingController();
  final PriceController = TextEditingController();
  final imageController = TextEditingController();
  bool isUploading = false;
  final ImagePicker _picker = ImagePicker();
  String? _uploadedImageBase64;
  Future<void> pickImage() async {
    if (kIsWeb) {
      final html.FileUploadInputElement uploadInput =
          html.FileUploadInputElement();
      uploadInput.accept = "image/*";
      uploadInput.click();

      uploadInput.onChange.listen((e) async {
        final files = uploadInput.files;
        if (files!.isEmpty) return;
        final reader = html.FileReader();

        reader.readAsArrayBuffer(files[0]);
        reader.onLoadEnd.listen((e) async {
          final Uint8List data = reader.result as Uint8List;
          setState(() {
            _uploadedImageBase64 = base64Encode(data);
          });

          Fluttertoast.showToast(msg: "Image selected successfully");
        });
      });
    } else {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        Uint8List data = await image.readAsBytes();
        setState(() {
          _uploadedImageBase64 = base64Encode(data);
        });
        Fluttertoast.showToast(msg: "Image selected successfully");
      }
    }
  }

  Future<void> addProductToFirestore() async {
    if (ProductController.text.isNotEmpty &&
        DescController.text.isNotEmpty &&
        PriceController.text.isNotEmpty &&
        _uploadedImageBase64 != null &&
        SelectedTitle != null) {
      try {
        await FirebaseFirestore.instance.collection('products').add({
          // 'cattitle': selectCatTitle,
          'protitle': ProductController.text,
          'Description': DescController.text,
          'price': PriceController.text,
          //'Category': ,
          'Image': _uploadedImageBase64,
        });
        EasyLoading.showSuccess("Product added successfully");

        ProductController.clear();
        DescController.clear();
        PriceController.clear();
        setState(() {
          _uploadedImageBase64 = null;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProductList()),
        );
      } catch (error) {
        EasyLoading.showError("Error adding product: $error");
      }
    } else {
      EasyLoading.showError("Please fill all fields before submitting");
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Admindrawer(),
      appBar: AppBar(title: Text("Data Uploaded"), centerTitle: true),
      body: Container(
        child: Form(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
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
                  controller: ProductController,
                  cursorColor: AppConstent.appSecondaryColor,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: "Product",
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
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: "Description",
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
                  controller: PriceController,
                  cursorColor: AppConstent.appSecondaryColor,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: "Price",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Container(
                height: 80,
                width: 300,
                child: ElevatedButton(
                  onPressed: pickImage,
                  child: Icon(
                    Icons.add_a_photo,
                    size: 50,
                    color: Colors.tealAccent,
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                margin: EdgeInsets.only(top: 30),
                child: TextButton.icon(
                  onPressed: addProductToFirestore,
                  label: Text(
                    "Post",
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
