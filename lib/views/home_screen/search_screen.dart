import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seed_haven/consts/consts.dart';
import 'package:seed_haven/services/firestore_services.dart';
import 'package:seed_haven/views/category_screen/item_details.dart';
import 'package:seed_haven/widgets_common/loading_indicator.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        future: FirestoreServices.searchProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No products here'),
            );
          } else {
            var data = snapshot.data!.docs;
            //upper filter will work, but in the down's filter variable is so smart and great approach
            var filtered = data
                .where((elements) => elements['p_name']
                    .toString()
                    .toLowerCase()
                    .contains(title!.toLowerCase()))
                .toList();

            return GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 300),
              children: data
                  .mapIndexed((currentValue, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            filtered[index]['p_imgs'][0],
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          const Spacer(),
                          Text(
                            filtered[index]['p_name'],
                            style: const TextStyle(
                              fontFamily: semibold,
                              color: darkFontGrey,
                            ),
                          ),
                          10.heightBox,
                          Text(
                            filtered[index]['p_price'],
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
                          .outerShadow
                          .padding(const EdgeInsets.all(8))
                          .margin(const EdgeInsets.symmetric(horizontal: 4))
                          .make()
                          .onTap(() {
                        Get.to(() => ItemDetails(
                            title: filtered[index]['p_name'],
                            data: filtered[index]));
                      }))
                  .toList(),
            );
          }
        },
      ),
    );
  }
}
