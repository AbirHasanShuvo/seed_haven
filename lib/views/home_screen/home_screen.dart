import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seed_haven/consts/consts.dart';
import 'package:seed_haven/consts/list.dart';
import 'package:seed_haven/controllers/home_controller.dart';
import 'package:seed_haven/services/firestore_services.dart';
import 'package:seed_haven/views/category_screen/item_details.dart';
import 'package:seed_haven/views/home_screen/components/feature_button.dart';
import 'package:seed_haven/views/home_screen/search_screen.dart';
import 'package:seed_haven/widgets_common/home_button.dart';
import 'package:seed_haven/widgets_common/loading_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Container(
      color: lightGrey,
      padding: const EdgeInsets.all(12),
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.search).onTap(() {
                      if (controller.searchController.text.isNotEmpty) {
                        Get.to(() => SearchScreen(
                              title: controller.searchController.text,
                            ));
                      }
                    }),
                    filled: true,
                    fillColor: whiteColor,
                    hintText: searchAnything,
                    hintStyle: const TextStyle(color: textfieldGrey)),
              ),
            ),
            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    VxSwiper.builder(
                      height: 150,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      itemCount: sliderList.length,
                      enlargeCenterPage: true,
                      itemBuilder: (context, index) => Image.asset(
                        sliderList[index],
                        fit: BoxFit.fill,
                      )
                          .box
                          .rounded
                          .clip(Clip.antiAlias)
                          .margin(const EdgeInsets.symmetric(horizontal: 8))
                          .make(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //cool feature which make same distance between a row
                      children: List.generate(
                          2,
                          (index) => homeButton(
                              context.screenWidth / 2.5,
                              context.screenHeight * 0.15,
                              index == 0 ? icTodaysDeal : icFlashDeal,
                              index == 0 ? toadayDeal : flashSale,
                              () {})),
                    ),

                    10.heightBox,
                    //this height box is easier to type than the Sizedbox,
                    VxSwiper.builder(
                      height: 150,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      itemCount: secondsliderList.length,
                      enlargeCenterPage: true,
                      itemBuilder: (context, index) => Image.asset(
                        secondsliderList[index],
                        fit: BoxFit.fill,
                      )
                          .box
                          .rounded
                          .clip(Clip.antiAlias)
                          .margin(const EdgeInsets.symmetric(horizontal: 8))
                          .make(),
                    ),
                    10.heightBox,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          3,
                          (index) => homeButton(
                              context.screenWidth / 3.5,
                              context.screenHeight * 0.15,
                              index == 0
                                  ? icTopCategories
                                  : index == 1
                                      ? icBrands
                                      : icTopSeller,
                              index == 0
                                  ? topCategories
                                  : index == 1
                                      ? brand
                                      : topSellers,
                              () {})),
                    ),

                    20.heightBox,

                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        featureCategories,
                        style: TextStyle(
                            fontFamily: semibold,
                            color: fontGrey,
                            fontSize: 18),
                      ),
                    ),

                    10.heightBox,

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: List.generate(
                            3,
                            (index) => Column(
                                  children: [
                                    featureButton(
                                        title: featureTitles1[index],
                                        icon: featureImages1[index]),
                                    10.heightBox,
                                    featureButton(
                                        title: featureTitles2[index],
                                        icon: featureImages2[index]),
                                  ],
                                )).toList(),
                      ),
                    ),
                    20.heightBox,
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(color: redColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            featureProducts,
                            style: TextStyle(
                                fontFamily: bold,
                                fontSize: 18,
                                color: whiteColor),
                          ),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: FutureBuilder(
                              future: FirestoreServices.getFeatureProducts(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: loadingIndicator(),
                                  );
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return Center(
                                    child:
                                        "No featured product found".text.make(),
                                  );
                                } else {
                                  var featureData = snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(
                                        featureData.length,
                                        (index) => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.network(
                                                  featureData[index]['p_imgs']
                                                      [0],
                                                  width: 150,
                                                  height: 130,
                                                  fit: BoxFit.cover,
                                                ),
                                                10.heightBox,
                                                Text(
                                                  featureData[index]['p_name'],
                                                  style: const TextStyle(
                                                    fontFamily: semibold,
                                                    color: darkFontGrey,
                                                  ),
                                                ),
                                                10.heightBox,
                                                Text(
                                                  featureData[index]['p_price'],
                                                  style: const TextStyle(
                                                      color: redColor,
                                                      fontFamily: bold,
                                                      fontSize: 16),
                                                )
                                              ],
                                            )
                                                .box
                                                .white
                                                .roundedSM
                                                .padding(
                                                    const EdgeInsets.all(8))
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4))
                                                .make()
                                                .onTap(() {
                                              Get.to(() => ItemDetails(
                                                  title: featureData[index]
                                                      ['p_name'],
                                                  data: featureData[index]));
                                            })),
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),

                    //third swipper

                    20.heightBox,
                    VxSwiper.builder(
                      height: 150,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      itemCount: secondsliderList.length,
                      enlargeCenterPage: true,
                      itemBuilder: (context, index) => Image.asset(
                        secondsliderList[index],
                        fit: BoxFit.fill,
                      )
                          .box
                          .rounded
                          .clip(Clip.antiAlias)
                          .margin(const EdgeInsets.symmetric(horizontal: 8))
                          .make(),
                    ),

                    //all product section

                    20.heightBox,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: 'All Products'
                          .text
                          .fontFamily(bold)
                          .color(darkFontGrey)
                          .size(16)
                          .make(),
                    ),
                    20.heightBox,

                    StreamBuilder(
                        stream: FirestoreServices.allProducts(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return loadingIndicator();
                          } else {
                            var allproductdata = snapshot.data!.docs;
                            return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              //it won't create a scroll, it will added with the default scroll
                              shrinkWrap: true,
                              itemCount: allproductdata.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      mainAxisExtent: 300),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      allproductdata[index]['p_imgs'][0],
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    const Spacer(),
                                    Text(
                                      allproductdata[index]['p_name'],
                                      style: const TextStyle(
                                        fontFamily: semibold,
                                        color: darkFontGrey,
                                      ),
                                    ),
                                    10.heightBox,
                                    Text(
                                      allproductdata[index]['p_price'],
                                      style: const TextStyle(
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
                                    .make()
                                    .onTap(() {
                                  Get.to(() => ItemDetails(
                                      title:
                                          "${allproductdata[index]['p_name']}",
                                      data: allproductdata[index]));
                                });
                              },
                            );
                          }
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
