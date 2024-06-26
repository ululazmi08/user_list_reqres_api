import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_maimaid/constant/colors.dart';
import 'package:test_maimaid/constant/typography.dart';
import 'package:test_maimaid/controller/home/home_controller.dart';
import 'package:test_maimaid/page/home/widget/card_list_widget.dart';
import 'package:test_maimaid/page/home/widget/create_update_widget.dart';
import 'package:test_maimaid/page/home/widget/tabbar_home_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      appBar: AppBar(
        backgroundColor: kColorWhite,
        title: const Text('User List'),
        titleTextStyle: TStyle.regText.copyWith(
          color: kColorTitleTxtBlack,
          fontSize: 17,
        ),
        titleSpacing: 24,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Material(
              color: kColorIcBtn,
              borderRadius: BorderRadius.circular(100),
              child: InkWell(
                onTap: () {
                  Get.to(
                    () => CreateUpdateWidget(
                      label: 'Create',
                      job: controller.jobController.value,
                      name: controller.nameController.value,
                      onTap: () {
                        controller.addListUser();
                      },
                      keyForm: controller.formKey,
                      listItem: controller.itemsJobs,
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(100),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.add,
                    color: kColorTitleTxtBlack,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: controller.enablePullUp.value,
          controller: controller.refreshController,
          onRefresh: () {
            // await Future.delayed(const Duration(milliseconds: 1000));
            controller.refreshController.refreshCompleted();
            controller.getListUser(reset: true);
          },
          onLoading: () async {
            await Future.delayed(const Duration(milliseconds: 1000));
            controller.getListUser();
            controller.refreshController.loadComplete();
          },
          child: Obx(
            () => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: Get.width,
                        child: Obx(
                          () => Row(
                            children: [
                              Expanded(
                                child: TabbarHomeWidget(
                                  onTap: () {
                                    if (controller.menuPage.value == 0) {
                                    } else {
                                      controller.menuPage.value = 0;
                                    }
                                  },
                                  isActive: controller.menuPage.value == 0,
                                  text: 'Non Selected',
                                ),
                              ),
                              Expanded(
                                child: TabbarHomeWidget(
                                  onTap: () {
                                    if (controller.menuPage.value == 1) {
                                    } else {
                                      controller.menuPage.value = 1;
                                    }
                                  },
                                  isActive: controller.menuPage.value == 1,
                                  text: 'Selected',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: Get.width,
                        height: 1,
                        color: kColorPopButton,
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  controller.menuPage.value == 0
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Text(
                                'Total ${controller.total.toString()} items',
                                textAlign: TextAlign.left,
                                style: TStyle.regText.copyWith(
                                  color: kColorRegTxtGrey,
                                ),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.listUser.length,
                              itemBuilder: (context, index) {
                                var data = controller.listUser[index];
                                return CardListWidget(
                                    data: data,
                                    onTapDel: () {
                                      controller.deleteListUser(data.id);
                                    },
                                    onTapEdit: () {
                                      controller.updateListUser(data.id);
                                    },
                                    name: controller.nameController.value,
                                    job: controller.jobController.value,
                                    keyForm: controller.formKey,
                                    item: controller.itemsJobs);
                              },
                            ),
                          ],
                        )
                      : controller.selectedUserList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.selectedUserList.length,
                              itemBuilder: (context, index) {
                                var data = controller.selectedUserList[index];
                                return CardListWidget(
                                  data: data,
                                  onTapDel: () {
                                    controller.deleteListUser(data.id);
                                  },
                                  onTapEdit: () {
                                    controller.updateListUser(data.id);
                                  },
                                  name: controller.nameController.value,
                                  job: controller.jobController.value,
                                  keyForm: controller.formKey,
                                  item: controller.itemsJobs,
                                );
                              },
                            )
                          : SizedBox(
                              height: Get.height / 2,
                              child: Center(
                                child: Text(
                                  'Empty selected user',
                                  style: TStyle.regText
                                      .copyWith(color: kColorRegTxtGrey),
                                ),
                              ),
                            )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
