import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seed_haven/consts/consts.dart';
import 'package:seed_haven/consts/list.dart';
import 'package:seed_haven/controllers/auth_controller.dart';
import 'package:seed_haven/controllers/profile_controller.dart';
import 'package:seed_haven/services/firestore_services.dart';
import 'package:seed_haven/views/auth_screen/login_screen.dart';
import 'package:seed_haven/views/chat_screen/chat_screen.dart';
import 'package:seed_haven/views/order_screen/order_screen.dart';
import 'package:seed_haven/views/profile_screen/components/details_card.dart';
import 'package:seed_haven/views/profile_screen/edit_profile_screen.dart';
import 'package:seed_haven/views/wishlist_screen/wishlist_screen.dart';
import 'package:seed_haven/widgets_common/bg_widget.dart';
import 'package:seed_haven/widgets_common/loading_indicator.dart';

import '../chat_screen/messaging.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(Scaffold(
        body: StreamBuilder(
            stream: FirestoreServices.getUser(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                );
              } else {
                //data getting from the firebase
                var data = snapshot.data!.docs[0];
                return SafeArea(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        //edit section
                        const Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.edit,
                              color: whiteColor,
                            )).onTap(() {
                          Get.to(() => EditProfileScreen(
                                data: data,
                              ));
                        }),
                        Row(
                          children: [
                            data['imageUrl'] == ''
                                ? Image.asset(
                                    imgProfile2,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ).box.roundedFull.clip(Clip.antiAlias).make()
                                : Image.network(
                                    data['imageUrl'],
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ).box.roundedFull.clip(Clip.antiAlias).make(),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                '${data['name']}'
                                    .text
                                    .fontFamily(semibold)
                                    .color(whiteColor)
                                    .make(),
                                '${data['email']}'
                                    .text
                                    .color(whiteColor)
                                    .make(),
                              ],
                            )),
                            OutlinedButton(
                                //this style for bordercolor whiteining
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: whiteColor)),
                                onPressed: () async {
                                  await Get.put(
                                      AuthController().signoutMethod(context));
                                  Get.offAll(LoginScreen());
                                },
                                child: 'logout'
                                    .text
                                    .fontFamily(semibold)
                                    .color(whiteColor)
                                    .make())
                          ],
                        ),
                        20.heightBox,

                        FutureBuilder(
                            future: FirestoreServices.getCounts(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                print('else is not calling');
                                return Center(
                                  child: loadingIndicator(),
                                );
                              } else {
                                var countData = snapshot.data;
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  //this spaceevenly is so good feature
                                  children: [
                                    detailsCard(
                                        count: countData[0].toString(),
                                        title: 'in your cart',
                                        width: context.screenWidth / 3.4),
                                    detailsCard(
                                        count: countData[1].toString(),
                                        title: 'in your wish',
                                        width: context.screenWidth / 3.4),
                                    detailsCard(
                                        count: countData[2].toString(),
                                        title: 'your orders',
                                        width: context.screenWidth / 3.4),
                                  ],
                                );
                              }
                            }),

                        20.heightBox,
                        ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: lightGrey,
                            );
                          },
                          itemCount: profileButtonList.length,
                          itemBuilder: (BuildContext context, index) {
                            return ListTile(
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    Get.to(const OrderScreen());
                                    break;
                                  case 1:
                                    Get.to(WishlistScreen());
                                    break;
                                  case 2:
                                    Get.to(MessagesScreen());
                                    break;
                                }
                              },
                              leading: Image.asset(
                                profileButtonIcons[index],
                                width: 22,
                              ),
                              title: profileButtonList[index]
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                            );
                          },
                        )
                            .box
                            .rounded
                            .white
                            .padding(const EdgeInsets.symmetric(horizontal: 16))
                            .shadowSm
                            .make()
                      ],
                    ),
                  ),
                );
              }
            })));
  }
}
