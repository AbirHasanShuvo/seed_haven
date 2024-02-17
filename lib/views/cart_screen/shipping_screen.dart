import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seed_haven/consts/consts.dart';
import 'package:seed_haven/controllers/cart_controller.dart';
import 'package:seed_haven/views/cart_screen/payment_method.dart';
import 'package:seed_haven/widgets_common/custom_textfield.dart';
import 'package:seed_haven/widgets_common/our_button.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: 'Shipping Info'
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(5),
        child: SizedBox(
          width: 60,
          child: ourButton(
              title: 'Continue',
              textColor: whiteColor,
              color: redColor,
              onpress: () {
                Get.to(() => const PaymentMethods());
                // if (controller.addressController.text.isEmpty ||
                //     controller.cityController.text.isEmpty ||
                //     controller.postalcodeController.text.isEmpty ||
                //     controller.phoneController.text.isEmpty ||
                //     controller.stateController.text.isEmpty) {
                //   VxToast.show(context,
                //       msg: 'Fill every field of the form');
                // } else {}
              }),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            customTextfield(
                'Address', "Address", controller.addressController, false),
            customTextfield("City", "City", controller.cityController, false),
            customTextfield(
                "State", "State", controller.stateController, false),
            customTextfield("Postal Code", "Postal Code",
                controller.postalcodeController, false),
            customTextfield(
                "Phone", "Phone", controller.phoneController, false),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
