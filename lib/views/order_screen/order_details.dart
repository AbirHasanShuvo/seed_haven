import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:seed_haven/consts/consts.dart';
import 'package:seed_haven/views/order_screen/components/order_place_details.dart';
import 'package:seed_haven/views/order_screen/components/order_status.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.data});

  final data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('Order details'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            orderStatus(
                icon: Icons.done,
                color: redColor,
                title: "Placed",
                showDone: data['order_place']),
            orderStatus(
                icon: Icons.thumb_up,
                color: Colors.blue,
                title: "Confirmed",
                showDone: data['ordered_confirmed']),
            orderStatus(
                icon: Icons.car_crash,
                color: Colors.yellow,
                title: "On Delivery",
                showDone: data['ordered_on_delivery']),
            orderStatus(
                icon: Icons.car_crash_rounded,
                color: Colors.purple,
                title: "Delivered",
                showDone: data['order_delivered']),
            const Divider(),
            10.heightBox,
            Column(
              children: [
                orderPlaceDetails(
                    title1: "Order Code",
                    title2: "Shipping Method",
                    d1: data['order_code'],
                    d2: data['shipping_method']),
                orderPlaceDetails(
                  title1: "Order Date",
                  title2: "Payment Method",
                  d1: intl.DateFormat()
                      .add_yMd()
                      .format((data['order_date']).toDate()),
                  d2: data['payment_method'] == 0
                      ? 'Paypal'
                      : data['payment_method'] == 1
                          ? 'Stripe'
                          : 'Cash on delivery',
                ),
                orderPlaceDetails(
                    title1: "Payment Status",
                    title2: "Delivery Status",
                    d1: "Unpaid",
                    d2: "Order Placed"),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Shipping Address".text.fontFamily(semibold).make(),
                          "${data['order_by_email']}".text.make(),
                          "${data['order_by_address']}".text.make(),
                          "${data['order_by_city']}".text.make(),
                          "${data['order_by_state']}".text.make(),
                          "${data['order_by_phone']}".text.make(),
                          "${data['order_by_postalcode']}".text.make(),
                        ],
                      ),
                      SizedBox(
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            'Total amount'.text.fontFamily(semibold).make(),
                            "${data['total_amount']}"
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ).box.outerShadowMd.white.make(),
            10.heightBox,
            const Divider(),
            'Ordered Products'
                .text
                .size(16)
                .color(darkFontGrey)
                .size(16)
                .makeCentered(),
            10.heightBox,
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              //because we are in a column, that's why we needed to shrinkWrap : true
              children: List.generate(data['orders'].length, (index) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetails(
                          title1: data['orders'][index]['title'],
                          title2: data['orders'][index]['tprice'],
                          d1: '${data['orders'][index]['qty']}x',
                          d2: "Refundable"),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Container(
                          height: 20,
                          width: 30,
                          color: Color(data['orders'][index]['color']),
                        ),
                      ),
                      const Divider()
                    ]);
              }).toList(),
            )
                .box
                .outerShadowMd
                .white
                .margin(const EdgeInsets.only(bottom: 4))
                .make(),


          ],
        ),
      ),
    );
  }
}
