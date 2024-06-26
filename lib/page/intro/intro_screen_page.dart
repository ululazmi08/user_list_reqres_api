import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_maimaid/constant/colors.dart';
import 'package:test_maimaid/constant/typography.dart';
import 'package:test_maimaid/controller/intro/introduction_screen_controller.dart';

class IntroScreenPage extends StatelessWidget {
  IntroScreenPage({Key? key}) : super(key: key);

  IntroScreenController controller = Get.put(IntroScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: (index) {
                controller.currentIndex.value = index;
              },
              itemCount: controller.introData.length,
              itemBuilder: (context, index) {
                var data = controller.introData[index];
                return Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 67),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: Get.width,
                            height: Get.height / 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  image: AssetImage(
                                    data['image'],
                                  ),
                                  fit: BoxFit.cover),
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
                          const SizedBox(height: 40),
                          Text(
                            data['title']!,
                            style: TStyle.introTxt.copyWith(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 18),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              data['description']!,
                              textAlign: TextAlign.center,
                              style: TStyle.regText
                                  .copyWith(fontSize: 16, color: kColorDescTxt),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: controller.introData.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => controller.pageController.animateToPage(
                    entry.key,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  ),
                  child: Container(
                    width: 10.0,
                    height: 10.0,
                    margin: const EdgeInsets.symmetric(horizontal: 6.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.currentIndex.value == entry.key
                          ? kColorOrangeTab
                          : kColorOrangeLight,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 50),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Obx(
                  () => MaterialButton(
                    onPressed: controller.currentIndex.value ==
                            controller.introData.length - 1
                        ? () => controller.skipToEnd()
                        : controller.nextPage,
                    color: kColorOrange,
                    minWidth: Get.width,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 22,
                    ),
                    child: Text(
                      controller.currentIndex.value ==
                              controller.introData.length - 1
                          ? 'GET STARTED'
                          : 'NEXT',
                      style: TStyle.title.copyWith(
                        color: kColorWhite,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Obx(
                () => TextButton(
                  onPressed: controller.currentIndex.value ==
                          controller.introData.length - 1
                      ? null
                      : controller.skipToEnd,
                  child: Text(
                    'Skip',
                    style: TStyle.regText.copyWith(
                      fontSize: 16,
                      color: controller.currentIndex.value ==
                              controller.introData.length - 1
                          ? Colors.transparent
                          : kColorDescTxt,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
