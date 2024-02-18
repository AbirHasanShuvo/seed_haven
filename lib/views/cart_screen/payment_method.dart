import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seed_haven/consts/consts.dart';
import 'package:seed_haven/consts/list.dart';
import 'package:seed_haven/controllers/cart_controller.dart';
import 'package:seed_haven/views/home_screen/home.dart';
import 'package:seed_haven/widgets_common/loading_indicator.dart';

import '../../widgets_common/our_button.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
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
            child: controller.placingOrder.value
                ? Center(
                    child: loadingIndicator(),
                  )
                : ourButton(
                    title: 'Place your order',
                    textColor: whiteColor,
                    color: redColor,
                    onpress: () async {
                      await controller.placeMyOrder(
                          controller.paymentIndex.value,
                          controller.totalP.value);
                      await controller.clearCart();
                      VxToast.show(context, msg: 'Order placed succesfully');
                      Get.off(const Home());
                    }),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodsList.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    //this boxdecoration will not work work until i use it as antialias
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            style: BorderStyle.solid,
                            color: redColor,
                            width: 4)),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Stack(alignment: Alignment.topRight, children: [
                      Transform.scale(
                        scale: 1.3,
                        child: Image.asset(
                          paymentMethodsList[index],
                          height: 120,
                          width: double.infinity,
                          //the two of line in the below is great
                          colorBlendMode: controller.paymentIndex == index
                              ? BlendMode.darken
                              : BlendMode.color,
                          color: controller.paymentIndex == index
                              ? Colors.black.withOpacity(0.4)
                              : Colors.transparent,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // ,
                      controller.paymentIndex.value == index
                          ? Checkbox(
                              activeColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              value: true,
                              onChanged: (value) {})
                          : Container(),
                      Positioned(
                          bottom: 10,
                          right: 10,
                          child: '${paymentMethods[index]}'
                              .text
                              .fontFamily(semibold)
                              .size(16)
                              .color(whiteColor)
                              .make()),
                    ]),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
