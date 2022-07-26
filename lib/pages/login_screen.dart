import 'dart:async';

import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shopin/pages/dashboard.dart';
import 'package:shopin/prefs/prefs.dart';
import 'package:shopin/widgets/common_widgets.dart';

import '../constants/Colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    emailAuth = EmailAuth(
      sessionName: "Sample session",
    );
    super.initState();
  }

  var emailAuth;
  bool isOtp = false;
  String? email;
  String? otp;
  final TextEditingController _emailController =
      TextEditingController(text: '');
  final TextEditingController _otpController = TextEditingController(text: '');

  void sendOtp() async {
    bool result = await emailAuth.sendOtp(
        recipientMail: _emailController.value.text, otpLength: 6);
    if (result) {
      setState(() {
        isOtp = true;
      });
    }
  }

  bool validEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool verify() {
    return emailAuth.validateOtp(
        recipientMail: _emailController.value.text,
        userOtp: _otpController.value.text);
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: Get.height * .4,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 150,
                      ),
                      textWidget(
                          text: 'ShopIN',
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        textWidget(
                            text: 'Login',
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                        const SizedBox(
                          height: 20,
                        ),
                        !isOtp
                            ? TextField(
                                controller: _emailController,
                                inputFormatters: [],
                                onChanged: (s) {
                                  email = s;
                                },
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: 'Email Address',
                                ),
                              )
                            : TextField(
                                controller: _otpController,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(6),
                                ],
                                onChanged: (s) {
                                  otp = s;
                                },
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                decoration: const InputDecoration(
                                  hintText: 'Enter OTP',
                                ),
                              ),
                        const SizedBox(
                          height: 30,
                        ),
                        !isOtp
                            ? cartButton(
                                onTap: () {
                                  if (!isLoading) {
                                    if (email!.isNotEmpty &&
                                        validEmail(_emailController.text)) {
                                      isLoading = true;
                                      sendOtp();
                                      isLoading = false;
                                      setState(() {});
                                    } else {
                                      Get.snackbar('Enter correct Email',
                                          'Check Number You have Entered');
                                    }
                                  }
                                },
                                text: 'Send OTP')
                            : cartButton(
                                onTap: () {
                                  if (!isLoading) {
                                    isLoading = true;
                                    if (otp!.isNotEmpty && verify()) {
                                      isLoading = false;
                                      PrefsDb.saveLogin(_emailController.text);
                                      setState(() {});
                                      Get.off(const DashboardScreen());
                                    } else {
                                      isLoading = false;
                                      Get.snackbar('Enter correct Otp',
                                          'Enter 6 digit Otp');
                                    }
                                  }
                                },
                                text: 'Login')
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
