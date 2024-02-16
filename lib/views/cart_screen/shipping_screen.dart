import 'package:flutter/material.dart';
import 'package:seed_haven/consts/consts.dart';
import 'package:seed_haven/widgets_common/custom_textfield.dart';
import 'package:seed_haven/widgets_common/our_button.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController addressController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController stateController = TextEditingController();
    TextEditingController postalController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: 'Shipping Info'
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: 60,
          child: ourButton(
              title: 'Continue',
              textColor: whiteColor,
              color: redColor,
              onpress: () {}),
        ),
      ),
      body: Column(
        children: [
          customTextfield('Address', "Address", addressController, false),
          customTextfield("City", "City", cityController, false),
          customTextfield("State", "State", stateController, false),
          customTextfield(
              "Postal Code", "Postal Code", postalController, false),
          customTextfield("Phone", "Phone", phoneController, false),
        ],
      ),
    );
  }
}
