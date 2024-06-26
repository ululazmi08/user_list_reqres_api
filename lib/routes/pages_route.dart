import 'package:get/get.dart';
import 'package:test_maimaid/page/home/home_page.dart';
import 'package:test_maimaid/page/intro/intro_screen_page.dart';
import 'package:test_maimaid/routes/route_name.dart';

class PagesRoute {
  static final pages = [
    GetPage(name: RouteName.home, page: ()=> HomePage()),
    GetPage(name: RouteName.intro, page: ()=> IntroScreenPage()),
  ];
}