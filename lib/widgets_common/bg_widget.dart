import 'package:flutter/material.dart';
import 'package:seed_haven/consts/consts.dart';

Widget bgWidget(Widget? child) {
  return Container(
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imgBackground), fit: BoxFit.fill)),
    child: child,
  );
}
