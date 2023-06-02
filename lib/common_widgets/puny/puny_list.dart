import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jym_app/controller/news_screen_controller/news_controller.dart';
import 'package:jym_app/services/api_services.dart';
import 'package:jym_app/utils/app_textstyle.dart';
import 'package:jym_app/utils/images.dart';
import 'package:jym_app/utils/theme_manager.dart';
import 'package:share_plus/share_plus.dart';

class ListWidgetPuny extends StatelessWidget {
  const ListWidgetPuny({
    super.key,
    required this.newsController,
  });

  final NewsController newsController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: newsController.newsList.length,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.05, vertical: Get.height * 0.015),
      separatorBuilder: (context, index) {
        return SizedBox(
          height: Get.height * 0.02,
        );
      },
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: ThemeManager().getWhiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: ThemeManager().getBlackColor.withOpacity(0.075),
                spreadRadius: 4,
                blurRadius: 5,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.025,
            vertical: Get.width * 0.025,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      ImageConstant.dukhadImage,
                      width: double.infinity,
                      height: 350,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      top: 45,
                      left: 115,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(55),
                            border: Border.all(width: 3, color: Colors.red)),
                        height: 100,
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(45),
                            child: Image.network(
                              mainUrl +
                                  newsController.newsList[index].bannerUrl,
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 80),
                      child: Column(
                        children: [
                          Text(
                            newsController.newsList[index].name,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: ThemeManager().brownColors,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            newsController.newsList[index].description,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 7, color: ThemeManager().brownColors),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              ///---------------Share------------------
              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.015),
                child: GestureDetector(
                  onTap: () {
                    Share.share(
                        mainUrl + newsController.newsList[index].bannerUrl,
                        subject: 'Dukhad Samachar Image');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/icon/share_green.png"),
                      Padding(
                        padding: EdgeInsets.only(left: Get.width * 0.03),
                        child: Text(
                          "Share",
                          style: poppinsRegular.copyWith(
                            fontSize: Get.width * 0.04,
                            color: ThemeManager().getThemeGreenColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
