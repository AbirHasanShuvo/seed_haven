import 'package:flutter/material.dart';
import 'package:seed_haven/consts/consts.dart';

Widget featureButton({title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        fit: BoxFit.fill,
        width: 60,
      ),
      10.widthBox,
      Text(
        title,
        style: const TextStyle(fontFamily: semibold, color: darkFontGrey),
      )
    ],
  )
      .box
      .white
      .padding(const EdgeInsets.all(4))
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .roundedSM
      .outerShadow
      .make();
}
