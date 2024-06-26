import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_maimaid/constant/colors.dart';
import 'package:test_maimaid/constant/typography.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    required this.listItem,
    required this.delete,
    required this.onTapDel,
    Key? key,
  }) : super(key: key);

  final bool delete;
  final List<String> listItem;
  final VoidCallback onTapDel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        color: kColorWhite,
        boxShadow: [
          BoxShadow(
            color: kColorBlack.withOpacity(0.25),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30),
          delete
              ? Column(
                  children: [
                    Text(
                      'Are You Sure ?',
                      style: TStyle.regText.copyWith(
                        fontSize: 20,
                        color: kColorTitleTxtBlack,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              onPressed: onTapDel,
                              color: kColorOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 22,
                              ),
                              child: Text(
                                'DELETE NOW',
                                style: TStyle.title.copyWith(color: kColorWhite),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                )
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listItem.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Get.back(result: listItem[index].toString());
                            },
                            child: Container(
                              width: Get.width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    listItem[index],
                                    textAlign: TextAlign.center,
                                    style:
                                        TStyle.regText.copyWith(fontSize: 20),
                                  ),
                                  const Icon(Icons.arrow_forward_ios_rounded),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
