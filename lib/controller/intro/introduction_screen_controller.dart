import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_maimaid/routes/route_name.dart';

class IntroScreenController extends GetxController {

  var currentIndex = 0.obs;
  var pageController = PageController();

  final List introData = [
    {
      'image': 'assets/images/image1.png',
      'title': 'Loren Ipsum Sit Amet',
      'description': 'Lorem ipsum dolor sit amet, consectetur elit sit amet',
    },
    {
      'image': 'assets/images/image2.png',
      'title': 'Loren Ipsum Sit Amet',
      'description': 'Lorem ipsum dolor sit amet, consectetur elit sit amet'
    },
    {
      'image': 'assets/images/image3.png',
      'title': 'Loren Ipsum Sit Amet',
      'description': 'Lorem ipsum dolor sit amet, consectetur elit sit amet'
    },
    {
      'image': 'assets/images/image4.png',
      'title': 'Loren Ipsum Sit Amet',
      'description': 'Lorem ipsum dolor sit amet, consectetur elit sit amet'
    },
  ];


  @override
  void onInit() {
    super.onInit();
    autoPlay();
  }

  void autoPlay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (currentIndex.value < introData.length - 1) {
        currentIndex.value++;
        pageController.animateToPage(
          currentIndex.value,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        autoPlay();
      }
    });
  }

  void nextPage() {
    if (currentIndex.value < introData.length - 1) {
      currentIndex.value++;
      pageController.animateToPage(
        currentIndex.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Get.offAllNamed(RouteName.home);
    }
  }

  void skipToEnd() {
    Get.offAllNamed(RouteName.home);
  }
}
