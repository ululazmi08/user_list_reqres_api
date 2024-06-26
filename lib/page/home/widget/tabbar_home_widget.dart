import 'package:flutter/material.dart';
import 'package:test_maimaid/constant/colors.dart';
import 'package:test_maimaid/constant/typography.dart';

class TabbarHomeWidget extends StatelessWidget {
  const TabbarHomeWidget({
    Key? key,
    required this.text,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: isActive
                        ? TStyle.title.copyWith(color: kColorOrangeTab)
                        : TStyle.regText.copyWith(color: kColorRegTxtBlack),
                  )
                ],
              ),
            ),
            isActive
                ? Container(
                    width: double.infinity,
                    height: 4,
                    decoration: BoxDecoration(
                      color: kColorOrangeTab,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
                : const SizedBox(
                    height: 4,
                  ),
          ],
        ),
      ),
    );
  }
}
