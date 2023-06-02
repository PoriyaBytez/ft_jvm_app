import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jym_app/controller/news_screen_controller/news_controller.dart';
import 'package:jym_app/utils/app_textstyle.dart';
import 'package:jym_app/utils/theme_manager.dart';
class CustomTabBarView extends StatefulWidget {
  TabController? controller;
  String title1 = "",title2= "";
  NewsController? newsController;
   CustomTabBarView({Key? key,this.controller,required this.title1,required
   this.title2,this.newsController}) : super(key: key);

  @override
  State<CustomTabBarView> createState() => _CustomTabBarViewState();
}

class _CustomTabBarViewState extends State<CustomTabBarView> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: Get.height * 0.065,
      width: Get.width,
      margin: EdgeInsets.symmetric(
        horizontal: Get.width * 0.05,
        vertical: Get.height * 0.025,
      ),
      decoration: BoxDecoration(
        color: ThemeManager().getWhiteColor,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: ThemeManager()
                .getBlackColor
                .withOpacity(0.075),
            blurRadius: 4,
            spreadRadius: 4,
            offset: const Offset(3, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(Get.width * 0.02),
      child: TabBar(
        // isScrollable: false,
        physics: NeverScrollableScrollPhysics(), // disable swipe navigation

        onTap: (int){
          print("fv");
          widget.newsController?.newsList.clear();
        },
        controller: widget.controller,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            // Creates border
            color: ThemeManager().getThemeGreenColor),
        labelPadding: EdgeInsets.zero,
        labelColor: ThemeManager().getWhiteColor,
        unselectedLabelColor: ThemeManager().getBlackColor,
        labelStyle: poppinsSemiBold.copyWith(
          fontSize: Get.width * 0.035,
        ),
        unselectedLabelStyle: poppinsRegular.copyWith(
          fontSize: Get.width * 0.035,
        ),
        indicatorColor: ThemeManager().getThemeGreenColor,
        tabs:  [
          Tab(
            child: Text(widget.title1),
          ),
          Tab(
            child: Text(widget.title2),
          ),
        ],
      ),
    );
  }
}
