import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:seed_haven/consts/consts.dart';

class CartController extends GetxController {
  var totalP = 0.obs;

  // controllers for shipping details

  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var postalcodeController = TextEditingController();
  var phoneController = TextEditingController();
  var stateController = TextEditingController();

  var paymentIndex = 0.obs;

  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }
}
