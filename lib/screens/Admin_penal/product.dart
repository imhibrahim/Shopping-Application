// import 'dart:convert';
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shoopingapp/screens/Admin_penal/fatchAll.dart';
// import 'package:shoopingapp/screens/Admin_penal/fatchData.dart';
// import 'package:shoopingapp/utlis/app_constain.dart';
// import 'package:shoopingapp/widgets/admindrawer.dart';

// class ProductAdd extends StatefulWidget {
//   const ProductAdd({super.key});

//   @override
//   State<ProductAdd> createState() => _ProductAddState();
// }

// class _ProductAddState extends State<ProductAdd> {
//   final ProductController = TextEditingController();
//   final DescController = TextEditingController();
//   final PriceController = TextEditingController();
//   final imageController = TextEditingController();
//   final DatabasePost = FirebaseDatabase.instance.ref("Product");

//   final _formKey = GlobalKey<FormState>();
//   File? _imageFile;

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _saveProduct() async {
//     if (!_formKey.currentState!.validate()) return;
//     if (_imageFile == null) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Please select an image')));
//       return;
//     }

//     // Convert the image to base64
//     final bytes = await _imageFile!.readAsBytes();
//     final base64Image = base64Encode(bytes);

//     try {
//       // Step 1: Get the highest current ID
//       QuerySnapshot snapshot =
//           await FirebaseFirestore.instance
//               .collection('Product')
//               .orderBy('id', descending: true)
//               .limit(1)
//               .get();

//       int nextId = 1; // Default ID if no products exist
//       if (snapshot.docs.isNotEmpty) {
//         final highestId = snapshot.docs.first['id'] as int;
//         nextId = highestId + 1;
//       }

//       // Step 2: Add new product with the next ID
//       await FirebaseFirestore.instance.collection('Product').add({
//         'id': nextId,
//         'Title': ProductController.text,
//         'Description': DescController,
//         'Price': PriceController,
//         'Category': SelectedTitle,
//         'image': base64Image,
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Product saved successfully!')),
//       );

//       setState(() {
//         ProductController.clear();
//         DescController.clear();
//         PriceController.clear();
//         SelectedTitle = null;
//         _imageFile = null;
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Failed to save product: $e')));
//     }
//   }

//   // void addProduct() {
//   //   final title = ProductController.text.trim();
//   //   final desc = DescController.text.trim();
//   //   final price = PriceController.text.trim();
//   //   final Pic = imageController.text.trim();
//   //   if (title.isEmpty ||
//   //       desc.isEmpty ||
//   //       price.isEmpty ||
//   //       Pic.isEmpty ||
//   //       SelectedTitle == null) {
//   //     EasyLoading.showError('All Feilds Are Required');
//   //     return;
//   //   }
//   //   EasyLoading.showInfo("Data Uploading....");

//   //   final String postId = DateTime.now().microsecondsSinceEpoch.toString();
//   //   DatabasePost.child(postId)
//   //       .set({
//   //         'ProductName': title,
//   //         'Description': desc,
//   //         "Price": price,
//   //         "Image": Pic,
//   //         "Category": SelectedTitle,
//   //       })
//   //       .then((value) {
//   //         EasyLoading.showSuccess("Data INserted");
//   //         ProductController.clear();
//   //         DescController.clear();
//   //         PriceController.clear();
//   //         imageController.clear();
//   //         Navigator.push(
//   //           context,
//   //           MaterialPageRoute(builder: (context) => FatchAll()),
//   //         );
//   //       })
//   //       .catchError((error) {
//   //         EasyLoading.showError("Data is Not Submited ${error}");
//   //       });
//   // }

//   final databaseRef = FirebaseDatabase.instance.ref('Post');
//   String? SelectedTitle;
//   List<String> PostTitle = [];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     category();
//   }

//   void category() async {
//     DatabaseEvent event = await databaseRef.once();
//     DataSnapshot dataSnapshot = event.snapshot;
//     Map<dynamic, dynamic>? data = dataSnapshot.value as Map<dynamic, dynamic>?;

//     if (data != null) {
//       List<String> titles = [];
//       data.forEach((key, value) {
//         if (value is Map && value.containsKey("Title")) {
//           titles.add(value['Title'].toString());
//         }
//       });
//       setState(() {
//         PostTitle = titles;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: Admindrawer(),
//       appBar: AppBar(title: Text("Data Uploaded"), centerTitle: true),
//       body: Container(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: DropdownButtonFormField(
//                   decoration: InputDecoration(
//                     labelText: "Category",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   items:
//                       PostTitle.map((String title) {
//                         return DropdownMenuItem<String>(
//                           value: title,
//                           child: Text(title),
//                         );
//                       }).toList(),
//                   onChanged: (String? NewValue) {
//                     setState(() {
//                       SelectedTitle = NewValue;
//                     });
//                   },
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: TextField(
//                   controller: ProductController,
//                   cursorColor: AppConstent.appSecondaryColor,
//                   keyboardType: TextInputType.name,
//                   decoration: InputDecoration(
//                     hintText: "Product",
//                     prefixIcon: Icon(Icons.person),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: TextField(
//                   controller: DescController,
//                   cursorColor: AppConstent.appSecondaryColor,
//                   keyboardType: TextInputType.name,
//                   decoration: InputDecoration(
//                     hintText: "Description",
//                     prefixIcon: Icon(Icons.person),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: TextField(
//                   controller: PriceController,
//                   cursorColor: AppConstent.appSecondaryColor,
//                   keyboardType: TextInputType.name,
//                   decoration: InputDecoration(
//                     hintText: "Price",
//                     prefixIcon: Icon(Icons.person),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: _pickImage,
//                 child: Container(
//                   height: 70,
//                   width: 200,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.teal, width: 1.5),
//                   ),
//                   child:
//                       _imageFile == null
//                           ? const Icon(
//                             Icons.add_a_photo,
//                             size: 50,
//                             color: Colors.teal,
//                           )
//                           : ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: Image.file(
//                               _imageFile!,
//                               fit: BoxFit.cover,
//                               width: double.infinity,
//                               height: 120,
//                             ),
//                           ),
//                 ),
//               ),
//               Container(
//                 height: 50,
//                 width: 250,
//                 margin: EdgeInsets.only(top: 30),
//                 child: TextButton.icon(
//                   onPressed: _saveProduct,
//                   label: Text(
//                     "Post",
//                     style: TextStyle(color: AppConstent.appTextColor),
//                   ),
//                 ),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: AppConstent.appSecondaryColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoopingapp/screens/Admin_penal/fatchAll.dart';
import 'package:shoopingapp/screens/Admin_penal/fatchData.dart';
import 'package:shoopingapp/utlis/app_constain.dart';
import 'package:shoopingapp/widgets/admindrawer.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  final ProductController = TextEditingController();
  final DescController = TextEditingController();
  final PriceController = TextEditingController();
  final imageController = TextEditingController();
  final DatabasePost = FirebaseDatabase.instance.ref("Product");

  final _formKey = GlobalKey<FormState>();
  XFile? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;
    if (_imageFile == null) {
      EasyLoading.showError("Please select an image");
      return;
    }

    try {
      final bytes = await _imageFile!.readAsBytes();
      final base64Image = base64Encode(bytes);

      final String postId = DateTime.now().microsecondsSinceEpoch.toString();

      DatabasePost.child(postId)
          .set({
            'Title': ProductController.text.trim(),
            'Description': DescController.text.trim(),
            'Price': PriceController.text.trim(),
            'Category': SelectedTitle,
            'image': _imageFile.toString(),
          })
          .then((value) {
            EasyLoading.showSuccess("Data Inserted");

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FatchAll()),
            );
          })
          .catchError((error) {
            EasyLoading.showError("Data not inserted: $error");
          });

      // QuerySnapshot snapshot =
      //     await FirebaseFirestore.instance
      //         .collection('Product')
      //         .orderBy('id', descending: true)
      //         .limit(1)
      //         .get();

      // int nextId = 1;
      // if (snapshot.docs.isNotEmpty) {
      //   final highestId = snapshot.docs.first['id'] as int;
      //   nextId = highestId + 1;
      // }

      // await FirebaseFirestore.instance.collection('Product').add({
      //   'id': nextId,
      //   'Title': ProductController.text,
      //   'Description': DescController.text,
      //   'Price': PriceController.text,
      //   'Category': SelectedTitle,
      //   'image': base64Image,
      // });

      EasyLoading.showSuccess("Product saved successfully!");
      setState(() {
        ProductController.clear();
        DescController.clear();
        PriceController.clear();
        SelectedTitle = null;
        _imageFile = null;
      });
    } catch (e) {
      EasyLoading.showError("Failed to save product: $e");
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Admindrawer(),
      appBar: AppBar(title: Text("Data Uploaded"), centerTitle: true),
      body: Container(
        child: Form(
          key: _formKey,
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
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 120,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.teal, width: 1.5),
                  ),
                  child:
                      _imageFile == null
                          ? const Icon(
                            Icons.add_a_photo,
                            size: 50,
                            color: Colors.teal,
                          )
                          : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child:
                                kIsWeb
                                    ? Image.network(
                                      _imageFile!.path,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    )
                                    : Image.file(
                                      File(_imageFile!.path),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                          ),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                margin: EdgeInsets.only(top: 30),
                child: TextButton.icon(
                  onPressed: _saveProduct,
                  icon: Icon(Icons.upload, color: AppConstent.appTextColor),
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
