import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_maimaid/constant/colors.dart';
import 'package:test_maimaid/constant/typography.dart';
import 'package:test_maimaid/controller/home/home_controller.dart';
import 'package:test_maimaid/models/list_user_model.dart';
import 'package:test_maimaid/page/home/widget/bottom_sheet_widget.dart';
import 'package:test_maimaid/page/home/widget/create_update_widget.dart';

class CardListWidget extends StatelessWidget {
  const CardListWidget({
    required this.data,
    required this.onTapDel,
    required this.onTapEdit,
    required this.name,
    required this.job,
    required this.keyForm,
    required this.item,
    Key? key,
  }) : super(key: key);

  final ListUserModel data;
  final VoidCallback onTapDel;
  final VoidCallback onTapEdit;
  final TextEditingController name;
  final TextEditingController job;
  final GlobalKey<FormState> keyForm;
  final List<String> item;

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 102,
            height: 102,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kColorMainGrey,
              image: DecorationImage(
                image: NetworkImage(data.avatar),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12, top: 11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${data.firstName} - ${data.lastName}',
                    style: TStyle.title,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    data.email,
                    style: TStyle.title.copyWith(
                      color: kColorOrange,
                    ),
                  ),
                ],
              ),
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Delete') {
                Get.bottomSheet(
                  BottomSheetWidget(
                    listItem: const [],
                    delete: true,
                    onTapDel: onTapDel,
                  ),
                  barrierColor: Colors.transparent,
                );
              } else if (value == 'Update') {
                name.text = '${data.firstName} ${data.lastName}';
                Get.to(
                  () => CreateUpdateWidget(
                    label: 'Update',
                    name: name,
                    job: job,
                    keyForm: keyForm,
                    listItem: item,
                    onTap: onTapEdit,
                  ),
                );
              } else if (value == 'Select') {
                controller.selectUser(data);
              }
            },
            icon: const Icon(
              Icons.more_horiz_rounded,
              color: kColorRegTxtBlack,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: kColorPopButton,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'Select',
                  child: Text(
                    'Select',
                    style: TStyle.regText,
                  ),
                ),
                PopupMenuItem(
                  value: 'Update',
                  child: Text(
                    'Update',
                    style: TStyle.regText,
                  ),
                ),
                PopupMenuItem(
                  value: 'Delete',
                  child: Text(
                    'Delete',
                    style: TStyle.regText.copyWith(
                      color: kColorRed,
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}
