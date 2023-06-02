import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_textstyle.dart';
import '../../utils/theme_manager.dart';
import '../main_screen.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Get.to(() => const MainScreen());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeManager().getWhiteColor,
          leading: GestureDetector(
            onTap: () {
              Get.to(()=>const MainScreen());
            },
            child: Icon(
              Icons.arrow_back_rounded,
              size: Get.width * 0.065,
              color: ThemeManager().getThemeGreenColor,
            ),
          ),
          title: Text("About Us",
              style: poppinsSemiBold.copyWith(
                fontSize: Get.width * 0.05,
                color: ThemeManager().getBlackColor,
              ),
          ),
          elevation: 0,
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          color: ThemeManager().getWhiteColor,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  height: Get.height * 0.25,
                  color: ThemeManager().getLightYellowColor,
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/image/main_logo_yellow.png",
                    width: Get.width * 0.25,
                    height: Get.width * 0.25,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.045,
                    vertical: Get.height * 0.025,
                  ),
                  child: Text(
                    "Welcome to JYM",
                    style: poppinsMedium.copyWith(
                      fontSize: Get.width * 0.045,
                      color: ThemeManager().getBlackColor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.045,
                    right: Get.width * 0.045,
                  ),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
                    style: poppinsMedium.copyWith(
                      fontSize: Get.width * 0.035,
                      color: ThemeManager().getLightGreyColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
