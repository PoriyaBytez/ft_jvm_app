import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jym_app/screens/verification_screen/mobile_number_screen.dart';
import 'package:jym_app/utils/theme_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../utils/app_textstyle.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

RxBool isLoginOrSignup = false.obs;

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int selectedPageIndex = 0;
  List onBoardingPageList = [
    {
      "onBoardingImage": "assets/image/comunity_onboarding.png",
      "onBoardingTitle": "Community",
      "onBoardingDescription": "Easy to Search the members in the community",
    },
    {
      "onBoardingImage": "assets/image/news_utlities_onboarding.png",
      "onBoardingTitle": "News & Utilities",
      "onBoardingDescription":
          "Stay Up to date with the latest news from the community",
    },
    {
      "onBoardingImage": "assets/image/matrimony_onboarding.png",
      "onBoardingTitle": "Matrimony",
      "onBoardingDescription":
          "Introducing matromony section so you can easiy find your soul mate",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              color: ThemeManager().getWhiteColor,
              padding: EdgeInsets.only(top: Get.height * 0.025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ///----------------Name & Logo-------------------

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/image/splash_logo.png",
                        width: Get.width * 0.17,
                        height: Get.width * 0.17,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Get.width * 0.03),
                        child: Text(
                          "JYM Jain Sangh",
                          style: poppinsSemiBold.copyWith(
                            color: ThemeManager().getBlackColor,
                            fontSize: Get.width * 0.05,
                          ),
                        ),
                      ),
                    ],
                  ),

                  ///----------------OnBoarding Image-------------------

                  SizedBox(
                    width: Get.width,
                    height: Get.height * 0.4,
                    child: PageView.builder(
                        itemCount: onBoardingPageList.length,
                        controller: _pageController,
                        onPageChanged: (value) {
                          selectedPageIndex = value;
                          setState(() {});
                        },
                        itemBuilder: (context, index) {
                          return Image.asset(
                            onBoardingPageList[index]["onBoardingImage"],
                            width: Get.width,
                            height: Get.height * 0.45,
                            fit: index == 0 ? BoxFit.fitWidth : BoxFit.none,
                          );
                        }),
                  ),
                ],
              ),
            ),

            ///----------------Description & Button-------------------

            Container(
              height: Get.height * 0.45,
              width: Get.width,
              decoration: BoxDecoration(
                color: ThemeManager().getWhiteColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: ThemeManager().getBlackColor.withOpacity(0.06),
                    blurRadius: 3,
                    spreadRadius: 5,
                    offset: const Offset(-3, -3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SmoothPageIndicator(
                      controller: _pageController,
                      count: onBoardingPageList.length,
                      effect: ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: ThemeManager().getThemeGreenColor,
                        dotColor:
                            ThemeManager().getLightGreyColor.withOpacity(0.5),
                      ),
                      onDotClicked: (index) {}),
                  Column(
                    children: [
                      Text(
                        onBoardingPageList[selectedPageIndex]
                            ["onBoardingTitle"],
                        style: poppinsSemiBold.copyWith(
                            fontSize: Get.width * 0.06,
                            color: ThemeManager().getBlackColor),
                      ),
                      Container(
                        width: Get.width * 0.7,
                        padding: EdgeInsets.only(top: Get.height * 0.01),
                        child: Text(
                          onBoardingPageList[selectedPageIndex]
                              ["onBoardingDescription"],
                          style: poppinsRegular.copyWith(
                              fontSize: Get.width * 0.035,
                              color: ThemeManager().getLightGreyColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: Get.width,
                    height: Get.height * 0.06,
                    margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    child: ElevatedButton(
                      onPressed: () {
                        isLoginOrSignup.value = true;
                        Get.to(() => const MobileNumberScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeManager().getThemeGreenColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        "Get Started",
                        style: poppinsSemiBold.copyWith(
                          fontSize: Get.width * 0.04,
                          color: ThemeManager().getWhiteColor,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: poppinsRegular.copyWith(
                          fontSize: Get.width * 0.035,
                          color: ThemeManager().getLightGreyColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: Get.width * 0.015,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            isLoginOrSignup.value = false;
                            Get.to(() => const MobileNumberScreen());
                          },
                          child: Text(
                            "Login",
                            style: poppinsSemiBold.copyWith(
                              fontSize: Get.width * 0.035,
                              color: ThemeManager().getThemeGreenColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
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
