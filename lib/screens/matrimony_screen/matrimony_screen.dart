import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jym_app/screens/drawer/add_family_members_screen.dart';
import 'package:jym_app/utils/theme_manager.dart';

import '../../common_widgets/custom_textformfield.dart';
import '../../controller/matrimony_controller/matrimony_controller.dart';
import '../../controller/verification_controller/city_controller.dart';
import '../../controller/verification_controller/surname_controller.dart';
import '../../models/matrimony_model/matrimony_model.dart';
import '../../utils/app_textstyle.dart';
import 'add_matrimony_profile_screen.dart';
import 'matrimony_user_info_screen.dart';

class MatrimonyScreen extends StatefulWidget {
  const MatrimonyScreen({Key? key}) : super(key: key);

  @override
  State<MatrimonyScreen> createState() => _MatrimonyScreenState();
}

class _MatrimonyScreenState extends State<MatrimonyScreen>
    with SingleTickerProviderStateMixin {
  late TabController _genderTabController;
  TextEditingController maleController = TextEditingController();
  TextEditingController femaleController = TextEditingController();
  List<dynamic> femaleSearchList = [];
  List<dynamic> maleSearchList = [];
  final matrimonyController = Get.put(MatrimonyController());
  final cityController = Get.put(CityController());
  final surNameController = Get.put(SurnameController());

  bool maleIsEmptySearch = false;
  bool femaleIsEmptySearch = false;

  int calculateAgeDate(String birthDate) {
    List dateList = birthDate.split("-");
    DateTime a =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTime b = DateTime(
        int.parse(dateList[0]), int.parse(dateList[1]), int.parse(dateList[2]));
    int totalDays = a.difference(b).inDays;
    int years = totalDays ~/ 365;
    int months = (totalDays - years * 365) ~/ 30;
    int days = totalDays - years * 365 - months * 30;
    return years;
  }

  @override
  void initState() {
    _genderTabController = TabController(length: 2, vsync: this);
    matrimonyController.getMatrimony();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: Get.height,
          width: Get.width,
          color: ThemeManager().getWhiteColor,
          child: Column(
            children: [
              Container(
                height: Get.height * 0.065,
                width: Get.width,
                margin: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05, vertical: Get.height * 0.025),
                decoration: BoxDecoration(
                  color: ThemeManager().getWhiteColor,
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: ThemeManager().getBlackColor.withOpacity(0.075),
                      blurRadius: 4,
                      spreadRadius: 4,
                      offset: const Offset(3, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(Get.width * 0.02),
                child: TabBar(
                  controller: _genderTabController,
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
                  tabs: const [
                    Tab(
                      child: Text("Male"),
                    ),
                    Tab(
                      child: Text("Female"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(controller: _genderTabController, children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.05,
                            top: Get.height * 0.015,
                            right: Get.width * 0.05,
                            bottom: Get.height * 0.015),
                        child: CustomTextFormField(
                          controller: maleController,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            maleIsEmptySearch = false;
                            maleSearchList.clear();
                            if (value.isEmpty) {
                              setState(() {});
                              return;
                            } else {
                              matrimonyController.matrimonyMaleList
                                  .forEach((userDetail) {
                                if (userDetail.name
                                        .toString()
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    userDetail.name
                                        .toString()
                                        .toUpperCase()
                                        .contains(value.toUpperCase())) {
                                  maleSearchList.add(userDetail);
                                }
                              });
                            }
                            if (maleSearchList.isEmpty) {
                              maleIsEmptySearch = true;
                            }
                            setState(() {});
                          },
                          prefixIcon: Image.asset(
                            "assets/icon/search.png",
                          ),
                          labelText: "Search",
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
                      Expanded(
                        child: maleIsEmptySearch == true
                            ? const Text("No result for search")
                            : ListView.separated(
                                itemCount: maleSearchList.isEmpty
                                    ? matrimonyController
                                        .matrimonyMaleList.length
                                    : maleSearchList.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.05,
                                    vertical: Get.height * 0.015),
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: Get.height * 0.02,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  String city = "", gautra = '';
                                  Datum itemList = maleSearchList.isEmpty
                                      ? matrimonyController
                                          .matrimonyMaleList[index]
                                      : maleSearchList[index];
                                  // print("city ==> ${itemList.customer!.cityId}");
                                  if (itemList.customer != null) {
                                    for (var element
                                    in cityController.cityList) {
                                      if (itemList.customer!.cityId ==
                                          element.id.toString()) {
                                        city = element.name;
                                        break;
                                      }
                                    }

                                    for (var element
                                    in surNameController.surnameList) {
                                      if (element.id.toString() ==
                                          itemList.customer!.surnameId) {
                                        gautra = element.name;
                                        break;
                                      }
                                    }
                                  }
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: ThemeManager().getWhiteColor,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ThemeManager()
                                              .getBlackColor
                                              .withOpacity(0.075),
                                          spreadRadius: 4,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.04,
                                      vertical: Get.height * 0.02,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        ///-------------User name--------------
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: Get.width * 0.42,
                                                  child: Text(
                                                    itemList.name!,
                                                    style:
                                                        poppinsMedium.copyWith(
                                                      fontSize:
                                                          Get.width * 0.045,
                                                      color: ThemeManager()
                                                          .getBlackColor,
                                                    ),
                                                    // overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.to(() =>
                                                        MatrimonyUserInfoScreen(
                                                            userDataList:
                                                                itemList));
                                                  },
                                                  child: Text(
                                                    "View More",
                                                    style: poppinsSemiBold
                                                        .copyWith(
                                                      fontSize:
                                                          Get.width * 0.04,
                                                      color: ThemeManager()
                                                          .getThemeGreenColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: Get.height * 0.015),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  ///-------------User Photo------------

                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    child: itemList.avtar !=
                                                            null
                                                        ? Image.network(
                                                            "https://jymnew.spitel.com/${itemList.avtar}",
                                                            height: Get.height *
                                                                0.12,
                                                            width: Get.height *
                                                                0.12,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: Get.height *
                                                                0.12,
                                                            width: Get.height *
                                                                0.12,
                                                            child: const Icon(
                                                              Icons.person,
                                                              size: 80,
                                                            )),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: Get.width * 0.05),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        ///-------------User name--------------

                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Gautra",
                                                              style:
                                                                  poppinsRegular
                                                                      .copyWith(
                                                                fontSize:
                                                                    Get.width *
                                                                        0.035,
                                                                color: ThemeManager()
                                                                    .getLightGreyColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        ///-------------Age--------------

                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top:
                                                                      Get.height *
                                                                          0.01),
                                                          child: Text(
                                                            "Age",
                                                            style:
                                                                poppinsRegular
                                                                    .copyWith(
                                                              fontSize:
                                                                  Get.width *
                                                                      0.035,
                                                              color: ThemeManager()
                                                                  .getLightGreyColor,
                                                            ),
                                                          ),
                                                        ),

                                                        ///-------------City--------------

                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top:
                                                                      Get.height *
                                                                          0.01),
                                                          child: Text(
                                                            "City",
                                                            style:
                                                                poppinsRegular
                                                                    .copyWith(
                                                              fontSize:
                                                                  Get.width *
                                                                      0.035,
                                                              color: ThemeManager()
                                                                  .getLightGreyColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ///-------------Gautra Name--------------

                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: Get.height * 0.01),
                                                child: Text(
                                                  gautra,
                                                  style: poppinsMedium.copyWith(
                                                    fontSize: Get.width * 0.035,
                                                    color: ThemeManager()
                                                        .getBlackColor,
                                                  ),
                                                ),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: Get.height * 0.01),
                                                child: Text(
                                                  itemList.dateOfBirth !=
                                                              null &&
                                                          itemList.dateOfBirth!
                                                              .isNotEmpty
                                                      ? "${calculateAgeDate(itemList.dateOfBirth!)} year"
                                                      : "",
                                                  style: poppinsMedium.copyWith(
                                                    fontSize: Get.width * 0.035,
                                                    color: ThemeManager()
                                                        .getBlackColor,
                                                  ),
                                                ),
                                              ),

                                              ///-------------City Name--------------

                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: Get.height * 0.01),
                                                child: Text(
                                                  city,
                                                  // itemList.phoneNo ?? "",
                                                  style: poppinsMedium.copyWith(
                                                    fontSize: Get.width * 0.035,
                                                    color: ThemeManager()
                                                        .getBlackColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.05,
                            top: Get.height * 0.015,
                            right: Get.width * 0.05,
                            bottom: Get.height * 0.015),
                        child: CustomTextFormField(
                          controller: femaleController,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            femaleIsEmptySearch = false;
                            femaleSearchList.clear();
                            if (value.isEmpty) {
                              setState(() {});
                              return;
                            } else {
                              matrimonyController.matrimonyFeMaleList
                                  .forEach((userDetail) {
                                if (userDetail.name
                                        .toString()
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    userDetail.name
                                        .toString()
                                        .toUpperCase()
                                        .contains(value.toUpperCase())) {
                                  femaleSearchList.add(userDetail);
                                }
                              });
                            }
                            if (femaleSearchList.isEmpty) {
                              femaleIsEmptySearch = true;
                            }
                            setState(() {});
                          },
                          prefixIcon: Image.asset(
                            "assets/icon/search.png",
                          ),
                          labelText: "Search",
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
                      Expanded(
                        child: femaleIsEmptySearch == true
                            ? const Text("No result for search")
                            : ListView.separated(
                                itemCount: femaleSearchList.isEmpty
                                    ? matrimonyController
                                        .matrimonyFeMaleList.length
                                    : femaleSearchList.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.05,
                                    vertical: Get.height * 0.015),
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: Get.height * 0.02,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  String city = '', gautra = '';
                                  var itemList = femaleSearchList.isEmpty
                                      ? matrimonyController
                                          .matrimonyFeMaleList[index]
                                      : femaleSearchList[index];
                                  if (itemList.customer != null) {
                                    for (var element
                                    in cityController.cityList) {
                                      if (itemList.customer.cityId ==
                                          element.id.toString()) {
                                        city = element.name;
                                        break;
                                      }
                                    }

                                    for (var element
                                    in surNameController.surnameList) {
                                      if (element.id.toString() ==
                                          itemList.customer.surnameId) {
                                        gautra = element.name;
                                        break;
                                      }
                                    }
                                  }
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: ThemeManager().getWhiteColor,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ThemeManager()
                                              .getBlackColor
                                              .withOpacity(0.075),
                                          spreadRadius: 4,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.04,
                                      vertical: Get.height * 0.02,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        ///-------------User name--------------
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: Get.width * 0.42,
                                                  child: Text(
                                                    itemList.name,
                                                    style:
                                                        poppinsMedium.copyWith(
                                                      fontSize:
                                                          Get.width * 0.045,
                                                      color: ThemeManager()
                                                          .getBlackColor,
                                                    ),
                                                  ),
                                                ),

                                                ///-------------View More--------------

                                                GestureDetector(
                                                  onTap: () {
                                                    Get.to(() =>
                                                        MatrimonyUserInfoScreen(
                                                            userDataList:
                                                                itemList));
                                                  },
                                                  child: Text(
                                                    "View More",
                                                    style: poppinsSemiBold
                                                        .copyWith(
                                                      fontSize:
                                                          Get.width * 0.04,
                                                      color: ThemeManager()
                                                          .getThemeGreenColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: Get.height * 0.015),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  ///-------------User Photo------------

                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    child: itemList.avtar !=
                                                            null
                                                        ? Image.network(
                                                            "https://jymnew.spitel.com/${itemList.avtar}",
                                                            height: Get.height *
                                                                0.12,
                                                            width: Get.height *
                                                                0.12,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: Get.height *
                                                                0.12,
                                                            width: Get.height *
                                                                0.12,
                                                            child: const Icon(
                                                              Icons.person,
                                                              size: 80,
                                                            )),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: Get.width * 0.05),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        ///-------------User name--------------

                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Gautra",
                                                              style:
                                                                  poppinsRegular
                                                                      .copyWith(
                                                                fontSize:
                                                                    Get.width *
                                                                        0.035,
                                                                color: ThemeManager()
                                                                    .getLightGreyColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        ///-------------Age--------------

                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top:
                                                                      Get.height *
                                                                          0.01),
                                                          child: Text(
                                                            "Age",
                                                            style:
                                                                poppinsRegular
                                                                    .copyWith(
                                                              fontSize:
                                                                  Get.width *
                                                                      0.035,
                                                              color: ThemeManager()
                                                                  .getLightGreyColor,
                                                            ),
                                                          ),
                                                        ),

                                                        ///-------------City--------------

                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top:
                                                                      Get.height *
                                                                          0.01),
                                                          child: Text(
                                                            "City",
                                                            style:
                                                                poppinsRegular
                                                                    .copyWith(
                                                              fontSize:
                                                                  Get.width *
                                                                      0.035,
                                                              color: ThemeManager()
                                                                  .getLightGreyColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ///-------------Gautra Name--------------

                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: Get.height * 0.01),
                                                    child: Text(
                                                      gautra,
                                                      style: poppinsMedium
                                                          .copyWith(
                                                        fontSize:
                                                            Get.width * 0.035,
                                                        color: ThemeManager()
                                                            .getBlackColor,
                                                      ),
                                                    ),
                                                  ),

                                                  ///-------------Age number--------------

                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: Get.height * 0.01),
                                                    child: Text(
                                                      "${calculateAgeDate(itemList.dateOfBirth)} year",
                                                      style: poppinsMedium
                                                          .copyWith(
                                                        fontSize:
                                                            Get.width * 0.035,
                                                        color: ThemeManager()
                                                            .getBlackColor,
                                                      ),
                                                    ),
                                                  ),

                                                  ///-------------City Name--------------

                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: Get.height * 0.01),
                                                    child: Text(
                                                      city,
                                                      style: poppinsMedium
                                                          .copyWith(
                                                        fontSize:
                                                            Get.width * 0.035,
                                                        color: ThemeManager()
                                                            .getBlackColor,
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
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: Get.height * 0.015,
          right: Get.width * 0.05,
          child: FloatingActionButton(
            onPressed: () {
              // Get.to(()=> const AddMatrimonyProfileScreen());
              Get.to(() => AddFamilyMemberScreen(pageName: "Matrimony",));
            },
            backgroundColor: ThemeManager().getThemeGreenColor,
            child: Icon(
              Icons.add,
              size: Get.width * 0.065,
              color: ThemeManager().getWhiteColor,
            ),
          ),
        )
      ],
    );
  }
}
