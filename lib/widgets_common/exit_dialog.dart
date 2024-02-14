import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seed_haven/consts/consts.dart';
import 'package:seed_haven/widgets_common/our_button.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        'Confirm'.text.fontFamily(bold).color(darkFontGrey).size(18).make(),
        const Divider(),
        10.heightBox,
        'Are you sure want to exit ?'.text.color(darkFontGrey).size(16).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                onpress: () {
                  SystemNavigator.pop();
                  //close the entire app
                },
                color: redColor,
                textColor: whiteColor,
                title: 'Yes'),
            ourButton(
                onpress: () {
                  Navigator.of(context).pop();
                },
                color: redColor,
                textColor: whiteColor,
                title: 'No'),
          ],
        ),
      ],
    ).box.roundedSM.color(lightGrey).padding(const EdgeInsets.all(12)).make(),
  );
}
