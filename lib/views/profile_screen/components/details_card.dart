import 'package:flutter/material.dart';
import 'package:seed_haven/consts/consts.dart';

Widget detailsCard({width, String? title, String? count}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
      5.heightBox,
      title!.text.fontFamily(bold).color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .rounded
      .width(width)
      .height(80)
      .padding(const EdgeInsets.all(4))
      .shadowSm
      .make();
}
