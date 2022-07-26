import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopin/controller/order_controller.dart';
import 'package:shopin/models/cart.dart';
import 'package:shopin/pages/payment_page.dart';
import 'package:shopin/widgets/common_widgets.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final OrderController controller = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  textWidget(
                      text: 'Cart', fontSize: 30, fontWeight: FontWeight.w700),
                  const SizedBox(
                    height: 40,
                  ),
                  Obx(
                    () => ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.carts.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: _buildTile(controller.carts[index]));
                        })),
                  ),
                  if (controller.carts.isEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 200,
                        ),
                        const Icon(
                          Icons.shopping_cart_outlined,
                          size: 100,
                        ),
                        textWidget(
                            text: 'No Products in Cart',
                            fontSize: 16,
                            color: Colors.orange,
                            fontWeight: FontWeight.w600),
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: controller.carts.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(20),
                child: cartButton(
                    text: 'Proceed to Payment',
                    onTap: () {
                      Get.to(PaymentPage(
                        amount: '',
                        products: controller.carts,
                      ));
                    }),
              )
            : const SizedBox(
                height: 0,
                width: 0,
              ),
      ),
    );
  }

  Widget _buildTile(Cart cart) {
    return SizedBox(
      width: Get.width,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(width: .5, color: Colors.grey)),
        leading: CircleAvatar(
            backgroundImage: NetworkImage(cart.products!.imageUrl)),
        title: textWidget(
          text: cart.products!.title,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            textWidget(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 15,
                text:
                    '₹ ${int.parse(cart.products!.price) * (cart.quantity!)}'),
            const SizedBox(
              height: 10,
            ),
            textWidget(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                text: 'Qty : ${(cart.quantity!)}')
          ],
        ),
      ),
    );
  }
}
