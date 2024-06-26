import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_maimaid/constant/colors.dart';
import 'package:test_maimaid/constant/component.dart';
import 'package:test_maimaid/constant/typography.dart';
import 'package:test_maimaid/page/home/widget/bottom_sheet_widget.dart';

class CreateUpdateWidget extends StatelessWidget {
  const CreateUpdateWidget({
    required this.label,
    required this.name,
    required this.job,
    required this.onTap,
    required this.listItem,
    required this.keyForm,
    Key? key,
  }) : super(key: key);

  final String label;
  final TextEditingController name;
  final TextEditingController job;
  final VoidCallback onTap;
  final List<String> listItem;
  final GlobalKey<FormState> keyForm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 18),
                  child: Material(
                    color: kColorIcBtn,
                    borderRadius: BorderRadius.circular(100),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      borderRadius: BorderRadius.circular(100),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.close_rounded),
                      ),
                    ),
                  ),
                ),
                Text(
                  '$label User',
                  style: TStyle.regText.copyWith(
                    fontSize: 17,
                    color: kColorTitleTxtBlack,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: keyForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NAME',
                      style: TStyle.regText.copyWith(color: kColorTxtForm),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: TStyle.regText.copyWith(fontSize: 16),
                      controller: name,
                      decoration: kDecorationForm.copyWith(
                        hintText: 'NAME',
                        hintStyle: TStyle.regText.copyWith(fontSize: 16),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Fill your Name!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 31),
                    Text(
                      'JOB',
                      style: TStyle.regText.copyWith(color: kColorTxtForm),
                    ),
                    const SizedBox(height: 8),
                    Material(
                      color: kColorForm,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          Get.bottomSheet(
                                  BottomSheetWidget(
                                    listItem: listItem,
                                    delete: false,
                                    onTapDel: () {},
                                  ),
                                  backgroundColor: kColorWhite,
                                  barrierColor: Colors.transparent,
                                  isScrollControlled: true)
                              .then((value) {
                            if (value != null) {
                              job.text = value.toString();
                            }
                          });
                        },
                        child: TextFormField(
                          enabled: false,
                          controller: job,
                          style: TStyle.regText.copyWith(fontSize: 16),
                          decoration: kDecorationForm.copyWith(
                            filled: false,
                            hintText: 'JOB',
                            hintStyle: TStyle.regText.copyWith(fontSize: 16),
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: kColorTitleTxtBlack,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Choose your Job';
                            }
                            return null;
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 34),
              child: Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: onTap,
                      color: kColorOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 22,
                      ),
                      child: Text(
                        label.toUpperCase(),
                        style: TStyle.title.copyWith(color: kColorWhite),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
