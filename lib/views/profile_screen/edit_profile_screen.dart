import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seed_haven/consts/consts.dart';
import 'package:seed_haven/controllers/profile_controller.dart';
import 'package:seed_haven/widgets_common/bg_widget.dart';
import 'package:seed_haven/widgets_common/custom_textfield.dart';
import 'package:seed_haven/widgets_common/our_button.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, this.data});

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController oldpasswordController = TextEditingController();
    TextEditingController newpasswordController = TextEditingController();
    // var controller = Get.put(ProfileController());
    var controller = Get.find<ProfileController>();
    //here i find profilecontroller class from it
    nameController.text = data['name'];

    return bgWidget(Scaffold(
      appBar: AppBar(),
      body: Obx(
        //for this obx UI will always update and you dont need to use setstate, its great
            () =>
            Column(
              mainAxisSize: MainAxisSize.min,
              //this thing is like wrap content
              children: [
                controller.profielImgPath.isEmpty && data['imageUrl'] == ''
                    ? Image
                    .asset(
                  imgProfile2,
                  width: 100,
                  fit: BoxFit.cover,
                )
                    .box
                    .roundedFull
                    .clip(Clip.antiAlias)
                    .make()
                    : data['imageUrl'] != '' &&
                    controller.profielImgPath.isEmpty
                    ? Image
                    .network(
                  data['imageUrl'],
                  width: 100,
                  fit: BoxFit.cover,
                )
                    .box
                    .roundedFull
                    .clip(Clip.antiAlias)
                    .make()
                    : Image
                    .file(
                  File(
                    controller.profielImgPath.value,
                  ),
                  width: 100,
                  fit: BoxFit.cover,
                )
                    .box
                    .roundedFull
                    .clip(Clip.antiAlias)
                    .make(),

                10.heightBox,
                ourButton(
                    color: redColor,
                    onpress: () {
                      controller.changeImg(context);
                    },
                    title: 'Change',
                    textColor: whiteColor),
                const Divider(),
                //this divider makes a division space in between two widget
                20.heightBox,
                customTextfield(name, nameHint, nameController, false),
                10.heightBox,
                customTextfield(
                    oldpass, passwordHint, oldpasswordController, true),
                10.heightBox,
                customTextfield(
                    newpass, passwordHint, newpasswordController, true),
                20.heightBox,
                SizedBox(
                  width: context.screenWidth - 60,
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                      : ourButton(
                      color: redColor,
                      onpress: () async {
                        controller.isLoading(true);

                        //if any picture i select
                        if (controller.profielImgPath.isNotEmpty) {
                          await controller.uploadProfileImage();
                        }
                        //else we will provide the old image link as new one
                        else {
                          controller.profileImageLink = data['imageUrl'];
                        }

                        //if old password matches with the new one
                        if (oldpasswordController.text == data['password']) {
                          await controller.changeAuthPassword(
                              email: data['email'],
                              password: oldpasswordController.text,
                              newpassword: newpasswordController.text);

                          await controller.updateProfile(
                              name: nameController.text,
                              password: newpasswordController.text,
                              //because we will update with the new password
                              imgUrl: controller.profileImageLink);
                          VxToast.show(context, msg: 'Updated');
                          controller.isLoading(false);
                        } else {
                          VxToast.show(context, msg: 'Incorrect old password');
                          controller.isLoading(false);
                        }
                      },
                      title: 'Save',
                      textColor: whiteColor),
                ),
              ],
            )
                .box
                .white
                .shadowSm
                .padding(const EdgeInsets.all(16))
                .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
                .rounded
                .make(),
      ),
    ));
  }
}
