import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import '../../utils/app_textstyle.dart';
import '../../utils/theme_manager.dart';

class NewsDetailsScreen extends StatefulWidget {
  String? newsImage, newsTitle, newsPublishTime, news,categoryTitle = '',subCategoryTitle = '';

  NewsDetailsScreen({
    Key? key,
    this.newsImage,
    this.newsTitle,
    this.newsPublishTime,
    this.news,
    this.categoryTitle = '', this.subCategoryTitle = ''
  }) : super(key: key);

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  WidgetsToImageController newsImageController = WidgetsToImageController();
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
        title: Text(
          "News Details",
          style: poppinsSemiBold.copyWith(
            fontSize: Get.width * 0.05,
            color: ThemeManager().getBlackColor,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Get.width * 0.035),
            child: GestureDetector(
              onTap: () async {
                Uint8List? bytes = await newsImageController.capture();
                final tempDir = await getTemporaryDirectory();
                File file = await File('${tempDir.path}/image.png').create();
                file.writeAsBytesSync(bytes!);
                List<String>shareImage = [];
                shareImage.add(file.path);
                Share.shareFiles(shareImage, text:'${widget.categoryTitle} \n ${widget.subCategoryTitle} \n ${widget.newsTitle} \n ${widget.news}');
              },
              child: const Icon(Icons.share,color: Colors.black),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WidgetsToImage(controller: newsImageController,
              child: Image.network(
                widget.newsImage!,
                width: Get.width,
                height: Get.height * 0.45,
                fit: BoxFit.fill,
              ),
            ),
            widget.categoryTitle != "" ?  Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05,
                vertical: Get.height * 0.02,
              ),
              child: Text(
                widget.categoryTitle!,
                style: poppinsMedium.copyWith(
                  fontSize: Get.width * 0.045,
                  color: ThemeManager().getBlackColor,
                ),
              ),
            ) : Container(),
            widget.subCategoryTitle != "" ? Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05,
                vertical: Get.height * 0.02,
              ),
              child: Text(
                widget.subCategoryTitle!,
                style: poppinsMedium.copyWith(
                  fontSize: Get.width * 0.045,
                  color: ThemeManager().getBlackColor,
                ),
              ),
            ) : Container(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05,
                vertical: Get.height * 0.02,
              ),
              child: Text(
                widget.newsTitle!,
                style: poppinsMedium.copyWith(
                  fontSize: Get.width * 0.045,
                  color: ThemeManager().getBlackColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: Get.width * 0.05,
              ),
              child: Text(
                widget.newsPublishTime!,
                style: poppinsRegular.copyWith(
                  fontSize: Get.width * 0.035,
                  color: ThemeManager().getLightGreyColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: Get.width * 0.035,
                top: Get.width * 0.035,
                right: Get.width * 0.035,
              ),
              child: Text(
                widget.news!,
                style: poppinsRegular.copyWith(
                  fontSize: Get.width * 0.035,
                  color: ThemeManager().getLightGreyColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
