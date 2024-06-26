import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_maimaid/constant/colors.dart';
import 'package:test_maimaid/routes/route_name.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1500), () {
      Get.offAllNamed(RouteName.intro);
    });

    return Scaffold(
      backgroundColor: kColorWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 67),
        child: Center(
          child: Container(
            height: 118,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage('assets/images/maimaid.png'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: kColorBlack.withOpacity(0.25),
                  blurRadius: 1,
                  spreadRadius: 0,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
