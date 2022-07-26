import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shopin/controller/notification_controller.dart';
import 'package:shopin/controller/order_controller.dart';
import 'package:shopin/models/cart.dart';
import 'package:shopin/pages/dashboard.dart';
import 'package:shopin/prefs/prefs.dart';
import 'package:shopin/widgets/common_widgets.dart';

class SuccessScreen extends StatefulWidget {
  final List<Cart> products;
  const SuccessScreen({Key? key, required this.products}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    NotificationController.showNotification(
        id: 0,
        title: 'Order Success',
        body: widget.products.map((e) => e.products!.title).toString());
    sendEmail().then((value) => print(value));
    super.initState();
  }

  final OrderController controller = Get.put(OrderController());

  Future sendEmail() async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    const serviceId = 'service_fmy3pge';
    const templateId = 'template_dda9385';
    const userId = 'CM5idVVfCjapsvdtH';
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'from_name': PrefsDb.getLoginDetails!.split('@').first,
            'from_email': PrefsDb.getLoginDetails,
            'message': widget.products.map((e) => e.products).toString()
          }
        }));
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() => Future.value(false)),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textWidget(
                    fontSize: 20,
                    text: 'Your Order is Successfully Placed!',
                    fontWeight: FontWeight.w700,
                    color: Colors.green),
                const SizedBox(
                  height: 30,
                ),
                cartButton(
                    text: 'Go to Dashboard',
                    onTap: () {
                      controller.cartCount.value = 0;
                      controller.carts.clear();
                      Get.off(const DashboardScreen());
                    })
              ],
            ),
          )),
    );
  }
}
