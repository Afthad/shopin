import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopin/models/cart.dart';
import 'package:shopin/pages/success_screen.dart';
import 'package:shopin/widgets/common_widgets.dart';

class PaymentPage extends StatelessWidget {
  final String amount;
  final List<Cart> products;
  const PaymentPage({
    Key? key,
    required this.amount,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              textWidget(
                  text: 'Payments', fontSize: 20, fontWeight: FontWeight.bold),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(text: 'Total Amount'),
                  textWidget(
                      fontWeight: FontWeight.w600,
                      text:
                          '₹ ${products.fold<double>(0, (previousValue, element) => (double.parse((element.products!.price)) * element.quantity!.toDouble()) + previousValue)}')
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              textWidget(text: 'Payment options', fontWeight: FontWeight.bold),
              const SizedBox(
                height: 20,
              ),
              textWidget(text: 'COD')
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: cartButton(
            text: 'Pay',
            onTap: () {
              Get.snackbar('Order is successful',
                  'Order is successful, will get email shortly');
              Get.to(SuccessScreen(products: products));
            }),
      ),
    );
  }
}
