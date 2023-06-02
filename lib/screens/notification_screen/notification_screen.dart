import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jym_app/utils/app_textstyle.dart';
import 'package:jym_app/utils/theme_manager.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List notificationList = [
    {
      "newImage": "assets/image/cloths.png",
      "newsHeadline": "Neeraj Collection post-Approve",
      "givenTime": "37 min ago",
    },
    {
      "newImage": "assets/image/cloths.png",
      "newsHeadline": "GT Furniture post-Approve",
      "givenTime": "10 min ago",
    },
    {
      "newImage": "assets/image/cloths.png",
      "newsHeadline":
          "RIP Raju Srivastava Bollywood celebs mourn comedian's demise",
      "givenTime": "12 min ago",
    },
    {
      "newImage": "assets/image/cloths.png",
      "newsHeadline":
          "RIP RLata Mangeshkar dies at the age of 92, Bollywood is in mourning",
      "givenTime": "12 min ago",
    },
    {
      "newImage": "assets/image/cloths.png",
      "newsHeadline": "Neeraj Collection post-Approve",
      "givenTime": "14 min ago",
    },
    {
      "newImage": "assets/image/cloths.png",
      "newsHeadline": "Neeraj Collection post-Approve",
      "givenTime": "20 min ago",
    },
    {
      "newImage": "assets/image/cloths.png",
      "newsHeadline": "Neeraj Collection post-Approve",
      "givenTime": "37 min ago",
    },
    {
      "newImage": "assets/image/cloths.png",
      "newsHeadline": "Neeraj Collection post-Approve",
      "givenTime": "37 min ago",
    },
    {
      "newImage": "assets/image/cloths.png",
      "newsHeadline": "Neeraj Collection post-Approve",
      "givenTime": "37 min ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeManager().getWhiteColor,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            size: Get.width * 0.065,
            color: ThemeManager().getThemeGreenColor,
          ),
        ),
        title: Text("Notification",
            style: poppinsSemiBold.copyWith(
              fontSize: Get.width * 0.05,
              color: ThemeManager().getBlackColor,
            )),
      ),
      backgroundColor: ThemeManager().getWhiteColor,
      body: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemCount: notificationList.length,
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.05,
            vertical: Get.height * 0.025,
          ),
          separatorBuilder: (context, index) {
            return SizedBox(height: Get.height * 0.02);
          },
          itemBuilder: (context, index) {
            return Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    notificationList[index]["newImage"],
                    height: Get.width * 0.2,
                    width: Get.width * 0.2,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: Get.width*0.65,
                  margin: EdgeInsets.only(left: Get.width*0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notificationList[index]["newsHeadline"],
                        style: poppinsRegular.copyWith(
                          fontSize: Get.width * 0.037,
                          color: ThemeManager().getBlackColor,
                        ),
                      ),
                      Text(notificationList[index]["givenTime"],
                        style: poppinsRegular.copyWith(
                          fontSize: Get.width * 0.035,
                          color: ThemeManager().getLightGreyColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
