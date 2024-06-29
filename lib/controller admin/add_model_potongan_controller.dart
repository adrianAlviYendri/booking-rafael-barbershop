// ignore_for_file: unnecessary_overrides

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rafael_barbershop_app/models/capster_models.dart';

class AddCapsterController extends GetxController {
  TextEditingController namaCapsterController = TextEditingController();

  var dataCapster = RxList<CapsterModels>();
  final db = FirebaseFirestore.instance;
  final picker = ImagePicker();
  File? imageFile;
  var pickedFile = Rx<PlatformFile?>(null);

  void selectImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      pickedFile.value = result.files.first;
    }
  }

  void uploadImageAndAddCapster() async {
    if (pickedFile.value == null) {
      return;
    }

    Reference ref = FirebaseStorage.instance
        .ref()
        .child('image_capster/${pickedFile.value!.name}');
    UploadTask uploadTask = ref.putFile(File(pickedFile.value!.path!));
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String imageUrlCapster = await taskSnapshot.ref.getDownloadURL();

    var addCapsterModels = CapsterModels(
      namaCapster: namaCapsterController.text,
      imageCapster: imageUrlCapster,
    );
    await db.collection("capster").add(addCapsterModels.toJson());
    printInfo(info: "capster added");
    namaCapsterController.clear();
    pickedFile.value = null;
  }

  @override
  void onInit() {
    super.onInit();
    getModelPotongan();
  }

  void getModelPotongan() async {
    var getCapsterModels = await db.collection("capster").get();
    for (var get in getCapsterModels.docs) {
      dataCapster.add(
        CapsterModels.fromJson(
          get.data(),
        ),
      );
    }
  }
}
