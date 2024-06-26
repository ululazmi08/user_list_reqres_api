import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_maimaid/constant/colors.dart';
import 'package:test_maimaid/models/list_user_model.dart';
import 'package:test_maimaid/page/home/widget/success_widget.dart';
import 'package:test_maimaid/services/home_service.dart';

class HomeController extends GetxController {
  var loadingDataList = false.obs;
  var listUser = <ListUserModel>[].obs;
  int total = 0;
  var page = 1.obs;
  var menuPage = 0.obs;
  var selectedUserList = <ListUserModel>[].obs;

  var enablePullUp = true.obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);

  final List<String> itemsJobs = [
    'Front End',
    'Back End',
    'Data Analyst',
  ];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var jobController = TextEditingController().obs;
  var nameController = TextEditingController().obs;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getListUser();
    loadSelectedUsers();
  }

  void loadSelectedUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? selectedUsersString = prefs.getStringList('selectedUsers');
    if (selectedUsersString != null) {
      selectedUserList.value = selectedUsersString.map((user) => ListUserModel.fromJson(jsonDecode(user))).toList();
    }
  }

  void saveSelectedUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> selectedUsersString = selectedUserList.map((user) => jsonEncode(user.toJson())).toList();
    await prefs.setStringList('selectedUsers', selectedUsersString);
  }

  selectUser(ListUserModel user) {
    selectedUserList.add(user);
    saveSelectedUsers();
  }

  void getListUser({bool reset = false}) async {
    if (reset) {
      page.value = 1;
      listUser.clear();
      enablePullUp.value = true;
    }
    if (page.value == 1) {
      loadingDataList.value = false;
    }
    try {
      var data = await HomeServices.dataListUser(page.value);
      if (data != null) {
        page.value += 1;
        var dataList = data['data'] as List;
        total = data['total'];
        List<ListUserModel> list =
            dataList.map((e) => ListUserModel.fromJson(e)).toList();
        if (list.isEmpty) {
          enablePullUp.value = false;
        }
        listUser.addAll(list);
      }
    } catch (e) {
      print('error getListUser : $e');
    } finally {
      loadingDataList.value = true;
    }
  }

  void addListUser() async {
    if (formKey.currentState!.validate()) {
      Get.dialog(
        barrierColor: Colors.transparent,
        const Center(
          child: CircularProgressIndicator(
            color: kColorOrange,
          ),
        ),
      );
      try {
        var data = await HomeServices.addListUserService(
            nameController.value.text, jobController.value.text);
        if (data != null) {
          nameController.value.clear();
          jobController.value.clear();
          print('Successed addListUser');
          Get.close(2);
          Get.to(()=> const SuccessWidget(label: 'Create Successful'));
        }
      } catch (e) {
        print('Error addListUser : $e');
        Get.back();
      }
    }
  }

  void updateListUser(int id) async {
    if (formKey.currentState!.validate()) {
      Get.dialog(
        barrierColor: Colors.transparent,
        const Center(
          child: CircularProgressIndicator(
            color: kColorOrange,
          ),
        ),
      );
      try {
        var data = await HomeServices.updateListUserService(
            nameController.value.text, jobController.value.text, id);
        if (data != null) {
          nameController.value.clear();
          jobController.value.clear();
          print('Successed updateListUser');
          Get.close(2);
          Get.to(()=> const SuccessWidget(label: 'Update Successful'));
        }
      } catch (e) {
        print('Error updateListUser : $e');
        Get.back();
      }
    }
  }

  void deleteListUser(int id) async {
      Get.dialog(
        barrierColor: Colors.transparent,
        const Center(
          child: CircularProgressIndicator(
            color: kColorOrange,
          ),
        ),
      );
      try {
        var data = await HomeServices.deleteListUserService(id);
        if (data != null) {
          print('Successed deleteListUser');
          Get.close(2);
          Get.to(()=> const SuccessWidget(label: 'Delete Successful'));
        }
      } catch (e) {
        print('Error deleteListUser : $e');
        Get.back();
      }

  }
}
