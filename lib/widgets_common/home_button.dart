import 'package:flutter/material.dart';
import 'package:seed_haven/consts/consts.dart';

Widget homeButton(width, height, icon, title, onPress) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 26,
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        title,
        style: const TextStyle(color: darkFontGrey, fontFamily: semibold),
      )
    ],
  ).box.rounded.white.size(width, height).shadowSm.make();
}
