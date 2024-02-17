import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seed_haven/consts/consts.dart';
import 'package:seed_haven/consts/list.dart';
import 'package:seed_haven/controllers/cart_controller.dart';

import '../../widgets_common/our_button.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: 'Choose Payment Method'
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(5),
        child: SizedBox(
          width: 60,
          child: ourButton(
              title: 'Place your order',
              textColor: whiteColor,
              color: redColor,
              onpress: () {
                VxToast.show(context, msg: 'Fill every field of the form');
              }),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: List.generate(paymentMethodsList.length, (index) {
            return Container(
              clipBehavior: Clip.antiAlias,
              //this boxdecoration will not work work until i use it as antialias
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: redColor,
                  border: Border.all(
                      style: BorderStyle.solid, color: redColor, width: 5)),
              margin: const EdgeInsets.only(bottom: 8),
              child: Stack(alignment: Alignment.topRight, children: [
                controller.paymentIndex.value == index
                    ? Transform.scale(
                        scale: 1.3,
                        child: Image.asset(
                          paymentMethodsList[index],
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(),
                Checkbox(
                    activeColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    value: true,
                    onChanged: (value) {})
              ]),
            );
          }),
        ),
      ),
    );
  }
}
