import 'package:flutter/material.dart';
import 'package:seed_haven/consts/consts.dart';

Widget customTextfield(String? title, String? hint, controller, isPass) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title.toString(),
        style: const TextStyle(
            fontSize: 16, fontFamily: semibold, color: redColor),
      ),
      const SizedBox(
        height: 5,
      ),
      TextFormField(
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                const TextStyle(fontFamily: semibold, color: textfieldGrey),
            isDense: true,
            fillColor: lightGrey,
            filled: true,
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
              color: redColor,
            ))),
      )
    ],
  );
}
