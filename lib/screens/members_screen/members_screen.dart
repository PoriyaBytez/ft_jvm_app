import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jym_app/controller/members_controller/family_members_controller.dart';
import 'package:jym_app/utils/theme_manager.dart';

import '../../controller/member_controller.dart';
import '../../controller/verification_controller/city_controller.dart';
import '../../controller/verification_controller/surname_controller.dart';
import '../../utils/app_textstyle.dart';
import '../../utils/preferences.dart';
import 'member_info_screen.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({Key? key}) : super(key: key);

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  TextEditingController searchController = TextEditingController();
  final memberController = Get.put(MemberController());
  final surnameController = Get.put(SurnameController());
  final cityController = Get.put(CityController());

  List<dynamic> searchList = [];
  List<dynamic> memberListByCity = [];
  final Preferences _preferences = Preferences();

  bool noDataFound = false;
  @override
  Widget build(BuildContext context) {
    memberListByCity.clear();
    print(
        "memberController.memberList[0].data ==> ${memberController.memberList.length}");
    memberController.memberList.forEach((memberItem) {
      print("memberListByCity => ${memberItem.cityId}");
      if (memberItem.cityId.contains(_preferences.getCityId())) {
        memberListByCity.add(memberItem);
      }
    });
    // memberListByCity.forEach((memberItem) {
    //   for (var element in surnameController.surnameList) {
    //     // String surName = '';
    //     if (element.id.toString() == memberItem.surnameId) {
    //       memberItem.surnameId = element.name;
    //       print("memberItem.surnameId => ${memberItem.surnameId}");
    //       break;
    //     }
    //   }
    // });

    return Container(
      width: Get.width,
      height: Get.height,
      color: ThemeManager().getWhiteColor,
      alignment: Alignment.center,
      child: Obx(
        () => memberController.isLoading.value == true
            ? CircularProgressIndicator(
                color: ThemeManager().getThemeGreenColor,
              )
            : Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: Get.width * 0.05,
                      top: Get.height * 0.025,
                      right: Get.width * 0.05,
                    ),
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
                          noDataFound = false;
                          if (value.isEmpty) {
                            setState(() {});
                            return;
                          } else {
                            memberListByCity.forEach((userDetail) {
                              if (userDetail.firstName
                                      .toString()
                                      .toLowerCase()
                                      .contains(value.toLowerCase()) ||
                                  userDetail.phoneNo
                                      .toString()
                                      .toLowerCase()
                                      .contains(value.toLowerCase()) ||
                                  userDetail.fatherHusbandName
                                      .toString()
                                      .toLowerCase()
                                      .contains(value.toLowerCase()) ||
                                  userDetail.surnameGautra.name
                                      .toString()
                                      .toLowerCase()
                                      .contains(value.toLowerCase()) ||
                                  userDetail.nativeCity.city
                                      .toString()
                                      .toLowerCase()
                                      .contains(value.toLowerCase()) ||
                                  userDetail.companyFirmName
                                      .toString()
                                      .toLowerCase()
                                      .contains(value.toLowerCase())) {
                                searchList.add(userDetail);
                              }
                            });
                            if(searchList.isEmpty) {
                              noDataFound = true;
                            }
                          }
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: "Search for members",
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 0.5,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
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
                  Expanded(
                    child: noDataFound == true ? const Text("No data found") : ListView.separated(
                        itemCount: searchList.isNotEmpty
                            ? searchList.length
                            : memberListByCity.length,
                        padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.05,
                          vertical: Get.height * 0.025,
                        ),
                        separatorBuilder: (context, index) {
                          return SizedBox(height: Get.height * 0.02);
                        },
                        itemBuilder: (context, index) {
                          var member = searchList.isNotEmpty
                              ? searchList[index]
                              : memberListByCity[index];
                          // String surName = "";
                          // String nativeCity = "";

                          // print("city ====> ${member.nativeCity.city}");
                          print(
                              "surnameGautra ====> ${member.surnameGautra.name}");
                          // for (var element in surnameController.surnameList) {
                          //   if (element.id.toString() == member.surnameId) {
                          //     surName = element.name;
                          //     break;
                          //   }
                          // }
                          // for (var element in cityController.cityList) {
                          //   if (element.id.toString() == member.nativeCity.city) {
                          //     nativeCity = element.name;
                          //     break;
                          //   }
                          // }
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => MemberInfoScreen(member));
                            },
                            child: Container(
                              color: ThemeManager().getWhiteColor,
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: member.avtarUrl != null
                                        ? Image.network(
                                            "https://jymnew.spitel.com/${member.avtarUrl}",
                                            height: Get.width * 0.15,
                                            width: Get.width * 0.15,
                                            fit: BoxFit.cover,
                                          )
                                        : const Icon(Icons.account_circle,
                                            size: 55),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: Get.width * 0.05),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${member.firstName} ${member.fatherHusbandName} ${member.surnameGautra.name}",
                                          style: poppinsMedium.copyWith(
                                            fontSize: Get.width * 0.035,
                                            color: ThemeManager().getBlackColor,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0),
                                          child: Text(
                                            member.phoneNo,
                                            style: poppinsMedium.copyWith(
                                              fontSize: Get.width * 0.03,
                                              color: ThemeManager()
                                                  .getLightGreyColor,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0),
                                          child: Text(
                                            member.nativeCity != null
                                                ? member.nativeCity.city
                                                : "",
                                            style: poppinsSemiBold.copyWith(
                                              fontSize: Get.width * 0.03,
                                              color: ThemeManager()
                                                  .getLightGreyColor,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          member.companyFirmName ?? "",
                                          style: poppinsSemiBold.copyWith(
                                            fontSize: Get.width * 0.03,
                                            color: ThemeManager()
                                                .getLightGreyColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
      ),
    );
  }
}
