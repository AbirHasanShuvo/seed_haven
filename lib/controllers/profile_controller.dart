import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seed_haven/consts/consts.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profielImgPath = ''.obs;
  var profileImageLink = '';
  var isLoading = false.obs;

  // TextEditingController nameController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();

  changeImg(context) async {
    try {
      // final img = await ImagePicker()
      //     .pickImage(source: ImageSource.gallery, imageQuality: 70);
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      profielImgPath.value = image.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage() async {
    var filename = basename(profielImgPath.value);
    var destination = 'images/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profielImgPath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  updateProfile({name, password, imgUrl}) async {
    var store = firestore.collection(userCollection).doc(currentUser!.uid);
    await store.set({'name': name, 'password': password, 'imageUrl': imgUrl},
        SetOptions(merge: true));
    isLoading(false);
  }

//change auth password
//normally i updated the password in the firestore, this function will work to change the login password or we can say the auth password

  changeAuthPassword({email, password, newpassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newpassword);
    }).catchError((error) {
      print(error.toString());
    });
  }
}
