import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seed_haven/consts/consts.dart';
import 'package:seed_haven/controllers/product_controller.dart';
import 'package:seed_haven/services/firestore_services.dart';
import 'package:seed_haven/views/category_screen/item_details.dart';
import 'package:seed_haven/widgets_common/bg_widget.dart';
import 'package:seed_haven/widgets_common/loading_indicator.dart';

class Category_Details extends StatelessWidget {
  const Category_Details({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return bgWidget(
      Scaffold(
        appBar: AppBar(
          title: title.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: List.generate(
                      controller.subcat.length,
                      (index) => "${controller.subcat[index]}"
                          .text
                          .size(12)
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .makeCentered()
                          .box
                          .white
                          .rounded
                          .margin(const EdgeInsets.symmetric(horizontal: 4))
                          .size(120, 60)
                          .make())),
            ),
            20.heightBox,
            Expanded(
                child: StreamBuilder(
                    stream: FirestoreServices.getProducts(title),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: loadingIndicator(),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(
                            'No product found',
                            style: TextStyle(color: darkFontGrey),
                          ),
                        );
                      } else {
                        var data = snapshot.data!.docs;

                        return Container(
                          color: lightGrey,
                          child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                mainAxisExtent: 250,
                              ),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      data[index]['p_imgs'][0],
                                      width: 200,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${data[index]['p_name']}',
                                      style: const TextStyle(
                                        fontFamily: semibold,
                                        color: darkFontGrey,
                                      ),
                                    ),
                                    10.heightBox,
                                    '${data[index]['p_price']}'.numCurrency.text.color(redColor).make(),
                                  ],
                                )
                                    .box
                                    .white
                                    .roundedSM
                                    .padding(const EdgeInsets.all(8))
                                    .outerShadow
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .make()
                                    .onTap(() {
                                  Get.to(
                                      () => ItemDetails(title: data[index]['p_name'], data: data[index],));
                                });
                                ;
                              }),
                        );
                      }
                    }))
          ]),
        ),
      ),
    );
  }
}
