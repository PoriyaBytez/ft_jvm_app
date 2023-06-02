import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jym_app/screens/utilities_screen/ustilities_subcategory_screen.dart';
import 'package:jym_app/utils/preferences.dart';
import 'package:jym_app/utils/theme_manager.dart';
import '../../common_widgets/custom_textformfield.dart';
import '../../controller/home_screen_controller/advertisement_controller.dart';
import '../../controller/utilities_screen_controller/utilities_controller.dart';
import '../../controller/utilities_screen_controller/utilities_main_category_controller.dart';
import '../../controller/verification_controller/city_controller.dart';
import '../../utils/app_textstyle.dart';
import 'utility_info_screen.dart';

class UtilitiesScreen extends StatefulWidget {
  const UtilitiesScreen({Key? key}) : super(key: key);

  @override
  State<UtilitiesScreen> createState() => _UtilitiesScreenState();
}

class _UtilitiesScreenState extends State<UtilitiesScreen> {
  TextEditingController searchController = TextEditingController();
  // final utilitiesController = Get.put(UtilitiesController());
  final cityController = Get.put(CityController());
  final utilitiesCategoryController = Get.put(UtilitiesMainCategoryController());
  List<dynamic> utilitiesFilterList = [];

  List<dynamic> searchList = [];
  List utilitiesList = [
    {
      "utilityImage": "assets/image/profile_person.jpg",
      "utilityName": "Jain Ralway Tiffin"
    },
    {
      "utilityImage": "assets/image/profile_person.jpg",
      "utilityName": "Jain Sadhu Sadhavi"
    },
    {
      "utilityImage": "assets/image/profile_person.jpg",
      "utilityName": "Jain Sangh"
    },
    {
      "utilityImage": "assets/image/profile_person.jpg",
      "utilityName": "Jain Temple"
    },
    {
      "utilityImage": "assets/image/profile_person.jpg",
      "utilityName": "Jain Terapanth Bhavan"
    },
    {
      "utilityImage": "assets/image/profile_person.jpg",
      "utilityName": "Jain Tirth"
    },
    {
      "utilityImage": "assets/image/profile_person.jpg",
      "utilityName": "Doctors"
    },
    {
      "utilityImage": "assets/image/profile_person.jpg",
      "utilityName": "Education"
    },
  ];

  @override
  void initState() {
    // utilitiesController.getUtilitiesData({
    //   // "filter_from": "${now.year}-${now.month}-01}",
    //   // "filter_to": "${now.year}-${now.month}-${DateTime(now.year, now.month + 1, 0).day}",
    //   "filter_from": "2022-01-01",
    //   "filter_to": "2022-12-30",
    //   "city": _preferences.getCityId(),
    //   "category_id": "",
    //   "sub_category": ""
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                          utilitiesCategoryController.utilitiesList
                              .forEach((userDetail) {
                            if (userDetail.name.toString().toLowerCase().startsWith(value.toLowerCase()) ||
                                userDetail.name.toString().toUpperCase().startsWith(value.toUpperCase())) {
                              searchList.add(userDetail);
                            }
                          });
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: "Search for Utilities",
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
                ],
              ),
            ),
            Expanded(
              child: Obx(() => /*(utilitiesCategoryController.isLoading.value == true)
                  ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: ThemeManager().getThemeGreenColor,
                ),
              )
                  :*/ ListView.separated(
                  itemCount: searchList.isNotEmpty
                      ? searchList.length
                      : utilitiesCategoryController.utilitiesList.length,
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
                        : utilitiesCategoryController.utilitiesList[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => UtilitiesSubcategoryScreen(utilityItem: item));
                        // Get.to(
                        //   () => UtilityInfoScreen(
                        //     utilityItem: item,
                        //   ),
                        // );
                      },
                      child: Container(
                        color: ThemeManager().getWhiteColor,
                        child: Row(
                          children: [
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
    );
  }
}
