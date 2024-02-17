import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:seed_haven/consts/consts.dart';
import 'package:seed_haven/controllers/home_controller.dart';

class CartController extends GetxController {
  var totalP = 0.obs;

  // controllers for shipping details

  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var postalcodeController = TextEditingController();
  var phoneController = TextEditingController();
  var stateController = TextEditingController();

  var paymentIndex = 0.obs;
  late dynamic productSnapshot;
  var products = [];

  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  placeMyOrder(orderPaymentMethod, totalAmount) async {
    await getProductDetails();
    await firestore.collection(ordersCollection).doc().set({
      'order_code': '233981237',
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_state': stateController.text,
      'order_by_city': cityController.text,
      'order_by_phone': phoneController.text,
      'order_by_postalcode': postalcodeController.text,
      'shipping_method': 'Home Delivery',
      'payment_method': orderPaymentMethod,
      'order_place': true,
      'order_delivered': false,
      'ordered_confirmed': false,
      'ordered_on_delivery': false,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products)
    });
  }

  getProductDetails() {
    products.clear();
    for (int i = 0; i < productSnapshot.length; i++) {
      products.add({
        'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title'],
      });
    }

    print(products);
  }
}
