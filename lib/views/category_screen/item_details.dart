import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seed_haven/consts/consts.dart';
import 'package:seed_haven/consts/list.dart';
import 'package:seed_haven/controllers/product_controller.dart';
import 'package:seed_haven/views/chat_screen/chat_screen.dart';
import 'package:seed_haven/widgets_common/our_button.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key, required this.title, required this.data});

  final String? title;
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
        //when in the previous page the value of quantity & price reset
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          // backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              controller.resetValues();
              Get.back();
              //when in the previous page the value of quantity & price reset
            },
          ),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                )),
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isFav.value) {
                      controller.removeFromWishlist(data.id, context);
                    } else {
                      controller.addToWishlist(data.id, context);
                    }
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: controller.isFav.value ? redColor : darkFontGrey,
                  )),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                        height: 350,
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        itemCount: data['p_imgs'].length,
                        viewportFraction: 1.0,
                        //this viewportion makes image full screen
                        itemBuilder: (context, index) {
                          return Image.network(
                            '${data['p_imgs'][index]}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          );
                        }),
                    10.heightBox,
                    Text(
                      '${data['p_name']}',
                      style: const TextStyle(
                          color: darkFontGrey, fontFamily: bold, fontSize: 16),
                    ),
                    10.heightBox,
                    VxRating(
                      isSelectable: false,
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      size: 25,
                      maxRating: 5,
                    ),
                    10.heightBox,
                    '${data['p_price']}'
                        .numCurrency
                        .text
                        .size(18)
                        .color(redColor)
                        .fontFamily(bold)
                        .make(),

                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            'Seller'.text.white.fontFamily(semibold).make(),
                            5.heightBox,
                            '${data['p_seller']}'
                                .text
                                .size(16)
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                          ],
                        )),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.message_rounded,
                            color: darkFontGrey,
                          ),
                        ).onTap(() {
                          Get.to(() => const ChatScreen(),
                              arguments: [data['p_seller'], data['vendor_id']]);
                        })
                      ],
                    )
                        .box
                        .height(60)
                        .color(textfieldGrey)
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .make(),
                    20.heightBox,
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  width: 100,
                                  child: 'Color: '
                                      .text
                                      .color(textfieldGrey)
                                      .make()),
                              Row(
                                children: List.generate(
                                    data['p_colors'].length,
                                    (index) => Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              VxBox()
                                                  .size(40, 40)
                                                  .roundedFull
                                                  .color(Color(data['p_colors']
                                                          [index])
                                                      .withOpacity(1.0))
                                                  .margin(const EdgeInsets
                                                      .symmetric(horizontal: 4))
                                                  .make()
                                                  .onTap(() {
                                                controller
                                                    .changeColorIndex(index);
                                              }),
                                              Visibility(
                                                  visible: index ==
                                                      controller
                                                          .colorIndex.value,
                                                  child: const Icon(
                                                    Icons.done,
                                                    color: Colors.white,
                                                  ))
                                            ])),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),

                          //quantity row
                          Row(
                            children: [
                              SizedBox(
                                  width: 100,
                                  child: 'Quantity: '
                                      .text
                                      .color(textfieldGrey)
                                      .make()),
                              Obx(
                                () => Row(children: [
                                  IconButton(
                                      onPressed: () {
                                        controller.decreaseQuantity();
                                        controller.calculateTotalPrice(
                                            int.parse(data['p_price']));
                                      },
                                      icon: const Icon(Icons.remove)),
                                  controller.quantity.value.text
                                      .size(16)
                                      .color(darkFontGrey)
                                      .fontFamily(bold)
                                      .make(),
                                  IconButton(
                                      onPressed: () {
                                        controller.increaseQuantity(
                                            int.parse(data['p_quantity']));
                                        controller.calculateTotalPrice(
                                            int.parse(data['p_price']));
                                      },
                                      icon: const Icon(Icons.add)),
                                  10.widthBox,
                                  '(${data['p_quantity']} available)'
                                      .text
                                      .color(textfieldGrey)
                                      .fontFamily(bold)
                                      .make(),
                                ]),
                              ),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          Row(
                            children: [
                              SizedBox(
                                  width: 100,
                                  child: 'Total: '
                                      .text
                                      .color(textfieldGrey)
                                      .make()),
                              Row(children: [
                                controller.totalPrice.value.numCurrency.text
                                    .size(16)
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .make()
                              ]),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                        ],
                      ).box.white.shadowSm.make(),
                    ),
                    //description section
                    10.heightBox,
                    const Text(
                      'Description',
                      style: TextStyle(
                        color: darkFontGrey,
                        fontFamily: semibold,
                      ),
                    ),
                    10.heightBox,
                    Text(
                      data['p_desc'],
                      style: const TextStyle(
                        color: darkFontGrey,
                      ),
                    ),
                    10.heightBox,
                    //buttons section
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      //normally it has default scroll to stop use NeverScrollableScrollPhysics()
                      shrinkWrap: true,
                      children: List.generate(
                          itemDetailsButtonList.length,
                          (index) => ListTile(
                                title: itemDetailsButtonList[index]
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                trailing: const Icon(Icons.arrow_forward),
                              )),
                    ),
                    20.heightBox,
                    productsyoumay.text.size(16).bold.make(),
                    10.heightBox,
                    //same as the home_screen widget
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: List.generate(
                            6,
                            (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      imgP1,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    10.heightBox,
                                    const Text(
                                      "Laptop 4gb/64gb",
                                      style: TextStyle(
                                        fontFamily: semibold,
                                        color: darkFontGrey,
                                      ),
                                    ),
                                    10.heightBox,
                                    const Text(
                                      '\$600',
                                      style: TextStyle(
                                          color: redColor,
                                          fontFamily: bold,
                                          fontSize: 16),
                                    )
                                  ],
                                )
                                    .box
                                    .white
                                    .roundedSM
                                    .padding(const EdgeInsets.all(8))
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .make()),
                      ),
                    )
                  ],
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(23),
              child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ourButton(
                      color: redColor,
                      onpress: () {
                        if (controller.quantity.value > 0) {
                          controller.addToCart(
                            color: data['p_colors']
                                [controller.colorIndex.value],
                            context: context,
                            vendorId: data['vendor_id'],
                            img: data['p_imgs'][0],
                            qty: controller.quantity.value,
                            sellername: data['p_seller'],
                            title: data['p_name'],
                            tprice: controller.totalPrice.value,
                          );
                          VxToast.show(context, msg: 'Item added to cart');
                        } else {
                          VxToast.show(context,
                              msg: 'Quantity should be minimum 1');
                        }
                      },
                      textColor: whiteColor,
                      title: 'Add To Cart')),
            ),
          ],
        ),
      ),
    );
  }
}
