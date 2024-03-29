import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:seed_haven/consts/consts.dart';

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;
  var username = '';

  var searchController = TextEditingController();

  getUsername() async {
    var n = await firestore
        .collection(userCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });

    username = n;
  }
}
