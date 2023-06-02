import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jym_app/controller/utilities_screen_controller/utilities_controller.dart';
import 'package:jym_app/screens/utilities_screen/utility_info_screen.dart';
import 'package:jym_app/utils/preferences.dart';

import '../../common_widgets/custom_textformfield.dart';
import '../../controller/home_screen_controller/advertisement_controller.dart';
import '../../controller/verification_controller/city_controller.dart';
import '../../utils/app_textstyle.dart';
import '../../utils/theme_manager.dart';

class UtilitiesLastScreen extends StatefulWidget {
  String? categoryId;
  String? subCategoryId;
  UtilitiesLastScreen({Key? key,this.categoryId,this.subCategoryId}) : super(key: key);

  @override
  State<UtilitiesLastScreen> createState() => _UtilitiesLastScreenState();
}

class _UtilitiesLastScreenState extends State<UtilitiesLastScreen> {
  final Preferences _preferences = Preferences();
  final utilitiesDetailController = Get.put(UtilitiesController());
  TextEditingController searchController = TextEditingController();
  TextEditingController searchCityController = TextEditingController();
  List<dynamic> searchList = [];
  final cityController = Get.put(CityController());

  @override
  void initState() {
    DateTime now = DateTime.now();
    // TODO: implement initState
    utilitiesDetailController.getUtilitiesData({
      // "filter_from": "${now.year}-${now.month}-01}",
      // "filter_to": "${now.year}-${now.month}-${DateTime(now.year, now.month + 1, 0).day}",
      "filter_from": "2022-01-01",
      "filter_to": "2023-05-31",
    "city": "",//_preferences.getCityId(),
    "category_id":"13",// widget.categoryId,
      "sub_category": "95",//widget.subCategoryId,

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
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
      backgroundColor: ThemeManager().getWhiteColor,
    ),body:  Container(
      width: Get.width,
      height: Get.height,
      color: ThemeManager().getWhiteColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: Get.width * 0.05,
              top: Get.height * 0.025,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: ThemeManager().getWhiteColor,
                      boxShadow: [
                        BoxShadow(
                          color:
                          ThemeManager().getBlackColor.withOpacity(0.065),
                          offset: const Offset(2, 3),
                          spreadRadius: 4,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: searchController,
                      style: poppinsRegular.copyWith(
                        fontSize: Get.width * 0.04,
                        color: ThemeManager().getBlackColor,
                      ),
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        searchList.clear();
                        if (value.isEmpty) {
                          setState(() {});
                          return;
                        }
                        utilitiesDetailController.utilitiesList
                            .forEach((userDetail) {
                          if (userDetail.name.toString().toLowerCase().startsWith(value.toLowerCase()) ||
                              userDetail.name.toString().toUpperCase().startsWith(value.toUpperCase())) {
                            searchList.add(userDetail);
                          }
                        });
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: "Search for Utilities ",
                        hintStyle: poppinsRegular.copyWith(
                            fontSize: Get.width * 0.04,
                            color: ThemeManager().getLightGreyColor),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: Get.height * 0.015),
                        prefixIcon: Icon(
                          Icons.search,
                          size: Get.width * 0.065,
                          color: ThemeManager().getThemeGreenColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 0.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 0.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    cityController.searchCityResultList =
                        cityController.cityList;
                    Get.dialog(
                      Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        insetPadding: EdgeInsets.symmetric(
                          vertical: Get.height * 0.05,
                        ),
                        backgroundColor: ThemeManager().getWhiteColor,
                        child: Container(
                          width: Get.width * 0.9,
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: Get.height * 0.025,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Select a location",
                                      style: poppinsSemiBold.copyWith(
                                          color: ThemeManager()
                                              .getThemeGreenColor,
                                          fontSize: Get.width * 0.065),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Icon(
                                        Icons.close,
                                        size: Get.width * 0.075,
                                        color:
                                            ThemeManager().getThemeGreenColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: Get.height * 0.02),
                                child: CustomTextFormField(
                                  controller: searchCityController,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    if (cityController
                                        .searchCityResultList.isNotEmpty) {
                                      cityController.searchCityResultList = [].obs;
                                      cityController.searchCityResultList
                                          .addAll(cityController.cityList
                                              .where((e) => e.name
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(value
                                                      .trim()
                                                      .toString()
                                                      .toLowerCase()) /* && e.city.startsWith(value.trim())*/)
                                              .toList());
                                    } else {
                                      cityController.searchCityResultList =
                                          cityController.cityList;
                                    }
                                    cityController.update();
                                    Get.forceAppUpdate();
                                    setState(() {});
                                  },
                                  prefixIcon:
                                      Image.asset("assets/icon/search.png"),
                                  labelText: "Select Location",
                                  labelStyle: poppinsRegular.copyWith(
                                    fontSize: Get.width * 0.04,
                                    color: ThemeManager().getLightGreyColor,
                                  ),
                                  mainTextStyle: poppinsRegular.copyWith(
                                    fontSize: Get.width * 0.04,
                                    color: ThemeManager().getBlackColor,
                                  ),
                                ),
                              ),
                              GetBuilder<AdvertisementController>(
                                id: "update",
                                builder: (controller) {
                                  return Expanded(
                                    child: Obx(() =>
                                        cityController.isLoading == true.obs
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(
                                                color: ThemeManager()
                                                    .getThemeGreenColor,
                                              ))

                                                : RawScrollbar(
                                                    thumbColor: ThemeManager()
                                                        .getThemeGreenColor,
                                                    child: ListView.builder(
                                                      itemCount:searchCityController.text.isNotEmpty ? cityController.searchCityResultList
                                                          .length : cityController.cityList.length,
                                                      // itemCount: locationList.length,
                                                      padding: EdgeInsets
                                                          .symmetric(
                                                              horizontal:
                                                                  Get.width *
                                                                      0.05,
                                                              vertical:
                                                                  Get.height *
                                                                      0.035),
                                                      itemBuilder:
                                                          (context, index) {
                                                        var itemName = searchCityController.text.isNotEmpty ? cityController.searchCityResultList[index]
                                                            : cityController.cityList[index];
                                                        return GestureDetector(
                                                          onTap: () {
                                                            for (int i = 0; i < cityController.searchCityResultList.length;i++) {
                                                              cityController.searchCityResultList[i].isCitySelected = false;
                                                            }
                                                            for(int i = 0;i < utilitiesDetailController.utilitiesList.length; i++){
                                                              if(utilitiesDetailController.utilitiesList[i].cityId.contains(itemName.id.toString())){
                                                                searchList.add(utilitiesDetailController.utilitiesList[i]);
                                                              }
                                                            }
                                                            itemName.isCitySelected = true;
                                                            controller.update(["update"]);
                                                            setState(() {});
                                                            Get.back();
                                                          },
                                                          child: Container(
                                                            height:
                                                                Get.height * 0.065,
                                                            decoration: BoxDecoration(
                                                              color: ThemeManager().getWhiteColor,
                                                              border: Border(bottom: BorderSide(width: 2,
                                                                  color: ThemeManager()
                                                                      .getLightGreyColor,
                                                                ),
                                                              ),
                                                            ),
                                                            padding: const EdgeInsets.only(bottom: 10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  itemName.name,
                                                                  style: poppinsRegular.copyWith(
                                                                    fontSize: Get.width *
                                                                            0.04,
                                                                    color: itemName.isCitySelected
                                                                        ? ThemeManager()
                                                                            .getThemeGreenColor
                                                                        : ThemeManager()
                                                                            .getLightGreyColor,
                                                                  ),
                                                                ),
                                                                Stack(alignment: Alignment.center,
                                                                  children: [
                                                                    Container(height: 20, width: 20,
                                                                      margin: EdgeInsets.only(right: Get.width * 0.05),
                                                                      decoration: BoxDecoration(
                                                                        shape: BoxShape.circle,
                                                                        color: itemName.isCitySelected
                                                                            ? ThemeManager().getThemeGreenColor
                                                                            : Colors.transparent,
                                                                        border: Border.all(
                                                                          color: ThemeManager().getBlackColor,
                                                                          width:
                                                                              0.5,
                                                                        ),
                                                                      ),
                                                                      alignment:
                                                                          Alignment.center,
                                                                      child: itemName.isCitySelected
                                                                          ? Container(
                                                                              height: 7,
                                                                              width: 7,
                                                                              decoration: BoxDecoration(shape: BoxShape.circle, color: ThemeManager().getWhiteColor),
                                                                            )
                                                                          : const SizedBox(),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ).whenComplete(() {
                      setState(() {});
                    });
                  },
                  child: Container(
                    height: Get.width * 0.1,
                    width: Get.width * 0.1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ThemeManager().getThemeGreenColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color:
                              ThemeManager().getBlackColor.withOpacity(0.065),
                          offset: const Offset(2, 3),
                          spreadRadius: 4,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(
                      left: Get.width * 0.035,
                      right: Get.width * 0.035,
                    ),
                    child: Image.asset(
                      "assets/icon/filter.png",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Obx(() => utilitiesDetailController.utilitiesList.isEmpty
                  ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: ThemeManager().getThemeGreenColor,
                ),
              )
                  : ListView.separated(
                  itemCount: searchList.isNotEmpty
                      ? searchList.length
                      : utilitiesDetailController.utilitiesList.length,
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05,
                    vertical: Get.height * 0.025,
                  ),
                  separatorBuilder: (context, index) {
                    return SizedBox(height: Get.height * 0.02);
                  },
                  itemBuilder: (context, index) {

                    var item = searchList.isNotEmpty
                        ? searchList[index]
                        : utilitiesDetailController.utilitiesList[index];
                    // String category = "";
                    // for (int i = 0; i < utilitiesCategoryController.utilitiesList.length; i++) {
                    //   if (item.categoryId.toString() == utilitiesCategoryController.utilitiesList[i].id.toString()) {
                    //     category = utilitiesCategoryController.utilitiesList[i].name;
                    //     break;
                    //   }
                    // }
                    return GestureDetector(
                      onTap: () {
                        // Get.to(() => UtilitiesSubcategoryScreen(utilityItem: item));
                        Get.to(
                              () => UtilityInfoScreen(
                                utilityItem: item,
                          ),
                        );
                      },
                      child: Container(
                        color: ThemeManager().getWhiteColor,
                        child: Row(
                          children: [
                            item.bannerUrl != null
                                ? Image.network(
                              "https://jymnew.spitel.com/${item.bannerUrl}",
                              height: Get.width * 0.15,
                              width: Get.width * 0.15,
                              fit: BoxFit.cover,
                            )
                                : const Icon(Icons.account_circle,
                                size: 55),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: Get.width * 0.05),
                              child: Text(
                                item.name,
                                style: poppinsMedium.copyWith(
                                  fontSize: Get.width * 0.035,
                                  color: ThemeManager().getBlackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),)
          )
        ],
      ),
    ),);
  }
}
