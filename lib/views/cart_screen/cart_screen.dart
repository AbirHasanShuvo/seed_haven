import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seed_haven/consts/consts.dart';
import 'package:seed_haven/controllers/cart_controller.dart';
import 'package:seed_haven/services/firestore_services.dart';
import 'package:seed_haven/views/cart_screen/shipping_screen.dart';
import 'package:seed_haven/widgets_common/loading_indicator.dart';
import 'package:seed_haven/widgets_common/our_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox(
            height: 60,
            child: ourButton(
                title: 'Proceed to shipping',
                onpress: () {
                  Get.to(() => const ShippingDetails());
                },
                color: redColor,
                textColor: whiteColor),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:
              'Shopping cart'.text.color(darkFontGrey).fontFamily(bold).make(),
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getCard(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('your cart is empty'),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculate(data);
              controller.productSnapshot = data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Image.network(
                                  data[index]['img'],
                                  width: 120,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                                title:
                                    '${data[index]['title']} (x${data[index]['qty']})'
                                        .text
                                        .fontFamily(semibold)
                                        .size(16)
                                        .make(),
                                subtitle: '${data[index]['tprice']}'
                                    .numCurrency
                                    .text
                                    .fontFamily(semibold)
                                    .color(redColor)
                                    .make(),
                                trailing: const Icon(
                                  Icons.delete,
                                  color: redColor,
                                ).onTap(() {
                                  FirestoreServices.deleteDocument(
                                      data[index].id);
                                }),
                              );
                            })),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        'Total price'
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        Obx(
                          () => controller.totalP.value.numCurrency.text
                              .fontFamily(semibold)
                              .color(redColor)
                              .make(),
                        ),
                      ],
                    )
                        .box
                        .padding(const EdgeInsets.all(12))
                        .color(lightgolden)
                        .width(context.screenWidth - 60)
                        .make(),
                  ],
                ),
              );
            }
          },
        ));
  }
}
