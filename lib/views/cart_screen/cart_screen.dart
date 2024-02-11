import 'package:flutter/material.dart';
import 'package:seed_haven/consts/consts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          'Cart is empty!'
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .makeCentered(),
          // ElevatedButton(
          //     onPressed: () {
          //       print(Colors.red.value);
          //     },
          //     child: const Text('show_your_color'))
        ]));
  }
}
