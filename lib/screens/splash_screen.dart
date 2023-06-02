import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jym_app/models/get_user_model.dart';
import 'package:jym_app/screens/main_screen.dart';
import 'package:jym_app/screens/onboarding_screen.dart';
import 'package:jym_app/screens/verification_screen/profile_screen.dart';
import 'package:jym_app/services/api_services.dart';
import 'package:jym_app/utils/app_textstyle.dart';
import 'package:jym_app/utils/preferences.dart';
import 'package:jym_app/utils/theme_manager.dart';
EditProfileModel editProfileModel = EditProfileModel();

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
APIServices apiServices = APIServices();
  checkStatus()async{
    var data = await apiServices.getUserData();
    var result = json.decode(data.body);
    editProfileModel = EditProfileModel.fromJson(result);
    setState(() {

    });
    print(editProfileModel.avtarUrl);
    print(" result ==> $result");
    Timer(const Duration(seconds: 3), () {
          if (Preferences().getToken().toString().isEmpty) {
            Get.off(() => const OnBoardingScreen());
          } else {
            if(result['system_status']=="1"){
              Get.off(() => const MainScreen());
            }else {
              // Get.off(() => const MainScreen());
              // Get.off(() => ProfileScreen(number: Preferences().getNumber()));
              Get.off(() => const OnBoardingScreen());

            }
          }
        });


  }

  @override
  void initState() {
    // TODO: implement initState
    checkStatus();
    super.initState();
  }

  // @override
  // void initState() {
  //
  //   Timer(const Duration(seconds: 3), () {
  //     if (Preferences().getToken().toString().isEmpty) {
  //       Get.off(() => const OnBoardingScreen());
  //     } else {
  //       if (Preferences().getRegistered()) {
  //         Get.off(() => const MainScreen());
  //       } else {
  //         // Get.off(() => const MainScreen());
  //
  //         Get.off(() => ProfileScreen(number: Preferences().getNumber()));
  //       }
  //     }
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: ThemeManager().getWhiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/image/splash_god.png",
              width: Get.width,
              height: Get.height * 0.5,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: EdgeInsets.only(top: Get.height * 0.025),
              child: Image.asset(
                "assets/image/splash_logo.png",
                width: Get.width * 0.35,
                height: Get.width * 0.35,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Get.height * 0.01),
              child: Text(
                "JYM Jain Sangh",
                style: poppinsMedium.copyWith(
                  color: ThemeManager().getBlackColor,
                  fontSize: Get.width * 0.065,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Get.height * 0.001),
              child: Text(
                "JinKhushal Yuva Munch",
                style: poppinsMedium.copyWith(
                  color: ThemeManager().getLightGreyColor,
                  fontSize: Get.width * 0.035,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Get.height * 0.001),
              child: Text(
                "Service to Society since 2008",
                style: poppinsRegular.copyWith(
                    color: ThemeManager().getThemeGreenColor,
                    fontSize: Get.width * 0.035,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
