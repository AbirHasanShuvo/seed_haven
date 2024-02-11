import 'package:flutter/material.dart';
import 'package:seed_haven/consts/consts.dart';

Widget ourButton({onpress, color, textColor, title}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color, padding: const EdgeInsets.all(12)),
      onPressed: onpress,
      child: Text(
        title.toString(),
        style: TextStyle(color: textColor, fontFamily: bold),
      ));
}
