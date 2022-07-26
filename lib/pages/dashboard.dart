import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopin/controller/order_controller.dart';
import 'package:shopin/models/cart.dart';
import 'package:shopin/pages/login_screen.dart';
import 'package:shopin/prefs/prefs.dart';
import 'package:shopin/widgets/common_widgets.dart';

import '../constants/Colors.dart';
import 'cart_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final OrderController controller = Get.put(OrderController());
  List<String> _items = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: SafeArea(
        child: Scaffold(body: Obx(() => _buildList())),
      ),
    );
  }

  Widget _buildList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textWidget(
                  text: 'ShopIN', fontSize: 29, fontWeight: FontWeight.bold),
              GestureDetector(
                  onTap: () {
                    PrefsDb.saveLogin(null);
                    Get.off(LoginScreen());
                  },
                  child: Icon(Icons.logout))
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                Get.to(const CartScreen());
              },
              child: Badge(
                badgeContent: textWidget(text: '${controller.cartCount}'),
                badgeColor: AppColors.primaryColor,
                child: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.products.length,
                itemBuilder: (c, index) {
                  return !controller.isLoading.value
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Image.network(
                                        height: 200,
                                        width: Get.width * 6,
                                        controller.products[index].imageUrl),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    textWidget(
                                        text: controller.products[index].title,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 19),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    textWidget(
                                        text:
                                            '₹ ${controller.products[index].price}',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        textWidget(
                                            text: 'Qty ',
                                            color: Colors.orange,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                        DropdownButton(
                                            value: controller
                                                .products[index].addedQuantity
                                                .toString(),
                                            items: _items.map((String r) {
                                              return DropdownMenuItem<String>(
                                                child: textWidget(text: r),
                                                value: r,
                                              );
                                            }).toList(),
                                            onChanged: (s) {
                                              controller.products[index]
                                                  .addedQuantity = s.toString();
                                              setState(() {});
                                            }),
                                      ],
                                    ),
                                    cartButton(
                                        text: 'Add to Cart',
                                        onTap: () {
                                          controller.addToCart(Cart(
                                              prodId: controller
                                                  .products[index].prodId,
                                              products:
                                                  controller.products[index],
                                              quantity: int.parse(controller
                                                  .products[index]
                                                  .addedQuantity)));
                                        })
                                  ],
                                ),
                              )),
                        )
                      : const Center(child: CircularProgressIndicator());
                }),
          ),
        ],
      ),
    );
  }
}
