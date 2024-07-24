import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:taskyfinaly/common/customTextFiled.dart';
import 'package:taskyfinaly/common/custom_button.dart';
import 'package:uuid/uuid.dart';

class AddPro extends StatefulWidget {
  const AddPro({super.key});

  @override
  State<AddPro> createState() => _AddProState();
}

class _AddProState extends State<AddPro> {
  File? picimage;

  Future<void> requestPermission() async {
    var status = await Permission.photos.request();
    if (status.isGranted) {
      print('Permission granted');
    } else if (status.isDenied) {
      print('Permission denied');
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void uploadImage() async {
    await requestPermission();
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        picimage = File(image.path);
      });
    } else {
      print('No image selected.');
    }
  }

  String? title;
  String? description;
  String? location;
  String? fullDescription;

  String? price;
  String category = 'Airconditioning';

  void uploadprodct() async {
    try {
      var uuid = const Uuid().v4();

      final ref = FirebaseStorage.instance
          .ref()
          .child('productimags')
          .child('${uuid}jpg');

      await ref.putFile(picimage!);

      final imageurl = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('prodcut').doc(uuid).set({
        'uuid': uuid,
        'title': title,
        'description': description,
        'location': location,
        'fullDescription': fullDescription,
        'price': price,
        'imageurl': imageurl,
        'category': category
      });

      resetForm();
    } catch (e) {
      print('error');
    }
  }

  void resetForm() {
    setState(() {
      title = null;
      description = null;
      location = null;
      fullDescription = null;
      price = null;
      category = 'Airconditioning';
      picimage = null;
    });
    formState.currentState?.reset();
  }

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formState,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 30),
                  customTextFiled(
                    validator: (value) {
                      if (value == "") {
                        return 'Cannot be empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      title = value;
                    },
                    labltext: 'اسم المهندس',
                    iconData: Icons.person_2_outlined,
                  ),
                  const SizedBox(height: 20),
                  customTextFiled(
                    validator: (value) {
                      if (value == "") {
                        return 'Cannot be empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      description = value;
                    },
                    labltext: 'وصف الخدمه',
                    iconData: Icons.description_outlined,
                  ),
                  const SizedBox(height: 10),
                  customTextFiled(
                    validator: (value) {
                      if (value == "") {
                        return 'Cannot be empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      fullDescription = value;
                    },
                    labltext: 'رقم الهاتف',
                    iconData: Icons.description_outlined,
                  ),
                  const SizedBox(height: 10),
                  customTextFiled(
                    validator: (value) {
                      if (value == "") {
                        return 'Cannot be empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      location = value;
                    },
                    labltext: 'الموقع',
                    iconData: Icons.description_outlined,
                  ),
                  const SizedBox(height: 10),
                  customTextFiled(
                    validator: (value) {
                      if (value == "") {
                        return 'Cannot be empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      price = value;
                    },
                    labltext: 'السعر',
                    iconData: Icons.price_change_outlined,
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: const Text('Select'),
                      value: category,
                      onChanged: (value) {
                        setState(() {
                          category = value!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: "Electricity",
                          child: Text('Electricity'),
                        ),
                        DropdownMenuItem(
                          value: "Airconditioning",
                          child: Text('Air conditioning'),
                        ),
                        DropdownMenuItem(
                          value: "Cleaning",
                          child: Text('Cleaning'),
                        ),
                        DropdownMenuItem(
                          value: "Plumbing",
                          child: Text('Plumbing'),
                        ),
                        DropdownMenuItem(
                          value: "Construction",
                          child: Text('Construction'),
                        ),
                        DropdownMenuItem(
                          value: "Carpenter",
                          child: Text('Carpenter'),
                        ),
                        DropdownMenuItem(
                          value: "advaster",
                          child: Text('Carpenter'),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      uploadImage();
                    },
                    child: const Text('Select Image'),
                  ),
                  if (picimage != null)
                    Image.file(
                      picimage!,
                      height: 200,
                    ),
                  const SizedBox(height: 20),
                  custom_Button(
                    text: 'رفع الخدمة',
                    onPressed: () {
                      uploadprodct();
                    },
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
