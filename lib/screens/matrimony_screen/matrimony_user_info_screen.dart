import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jym_app/utils/theme_manager.dart';
import '../../controller/member_controller.dart';
import '../../models/family_members_model/family_members_model.dart';
import '../../models/member_model.dart';
import '../../utils/app_textstyle.dart';

class MatrimonyUserInfoScreen extends StatefulWidget {
  var userDataList;

  MatrimonyUserInfoScreen({Key? key, this.userDataList}) : super(key: key);

  @override
  State<MatrimonyUserInfoScreen> createState() =>
      _MatrimonyUserInfoScreenState();
}

class _MatrimonyUserInfoScreenState extends State<MatrimonyUserInfoScreen>
    with SingleTickerProviderStateMixin {
  late TabController _mainTabController;
  final memberController = Get.put(MemberController());
  GetMember? memberList;

  @override
  void initState() {
    _mainTabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  getMainMember() {
    for (var element in memberController.memberList) {
      if (element.id.toString() == widget.userDataList.custId.toString()) {
        memberList = element;
        print("memberList ==> $memberList");
        break;
      }
    }
  }

  Widget customLabelName(String detail) {
    return Padding(
      padding: EdgeInsets.only(left: Get.width * 0.05, top: Get.height * 0.015),
      child: Text(
        detail,
        style: poppinsRegular.copyWith(
          fontSize: Get.width * 0.035,
          color: ThemeManager().getLightGreyColor,
        ),
      ),
    );
  }

  Widget customDetail(String detail) {
    return Container(
      width: Get.width * 0.9,
      margin: EdgeInsets.only(left: Get.width * 0.05, top: Get.height * 0.0075),
      child: Text(
        detail,
        style: poppinsRegular.copyWith(
          fontSize: Get.width * 0.04,
          color: ThemeManager().getBlackColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getMainMember();
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        color: ThemeManager().getWhiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///-------------------TabBar---------------------

            Container(
              height: Get.height * 0.075,
              width: Get.width,
              color: ThemeManager().getThemeGreenColor.withOpacity(0.1),
              child: TabBar(
                  controller: _mainTabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                        width: 5.0, color: ThemeManager().getThemeGreenColor),
                  ),
                  labelPadding: EdgeInsets.zero,
                  labelColor: ThemeManager().getBlackColor,
                  unselectedLabelColor: ThemeManager().getBlackColor,
                  labelStyle: poppinsSemiBold.copyWith(
                    fontSize: Get.width * 0.04,
                  ),
                  unselectedLabelStyle: poppinsRegular.copyWith(
                    fontSize: Get.width * 0.04,
                  ),
                  indicatorColor: ThemeManager().getThemeGreenColor,
                  tabs: const [
                    Tab(
                      child: Text("Profile"),
                    ),
                    Tab(
                      child: Text("Main Member"),
                    ),
                    // Tab(
                    //   child: Text("Family"),
                    // ),
                  ]),
            ),

            Expanded(
                child: TabBarView(
              controller: _mainTabController,
              children: [
                ///-----------------Profile------------------

                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: widget.userDataList.avtar != null
                              ? Image.network(
                            "https://jymnew.spitel.com/${widget.userDataList.avtar}",
                            height: Get.width * 0.15,
                            width: Get.width * 0.15,
                            fit: BoxFit.cover,
                          ) : const Icon(Icons.account_circle, size: 60),
                        ),
                      ),
                      customLabelName("Full Name"),
                      customDetail(widget.userDataList.name),
                      customLabelName("Gautra"),
                      customDetail(widget.userDataList.name),
                      customLabelName("Nanihal Gautra"),
                      customDetail(widget.userDataList.name),
                      customLabelName("DOB"),
                      customDetail(DateFormat("dd-MM-yyyy").format(
                          DateTime.parse(widget.userDataList.dateOfBirth))),
                      customLabelName("Birth Time"),
                      customDetail(widget.userDataList.timeOfBirth ?? ""),
                      customLabelName("Birth Place"),
                      customDetail(widget.userDataList.birthPlace ?? ""),
                      customLabelName("Blood Group"),
                      customDetail(widget.userDataList.bloodGroup.name),
                      customLabelName("Education"),
                      customDetail(widget.userDataList.education),
                      customLabelName(widget.userDataList.name),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.05, top: Get.height * 0.0075),
                        child: Row(
                          children: [
                            Text(
                              widget.userDataList.name,
                              style: poppinsRegular.copyWith(
                                fontSize: Get.width * 0.04,
                                color: ThemeManager().getBlackColor,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Image.asset("assets/icon/call.png"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Image.asset("assets/icon/whatsapp.png"),
                            ),
                          ],
                        ),
                      ),
                      customLabelName("Email ID"),
                      customDetail(widget.userDataList.name),
                      customLabelName("Home Address"),
                      customDetail(widget.userDataList.name),
                      customLabelName("Home Mobile Number"),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.05, top: Get.height * 0.0075),
                        child: Row(
                          children: [
                            Text(
                              widget.userDataList.name,
                              style: poppinsRegular.copyWith(
                                fontSize: Get.width * 0.04,
                                color: ThemeManager().getBlackColor,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Image.asset("assets/icon/call.png"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Image.asset("assets/icon/whatsapp.png"),
                            ),
                          ],
                        ),
                      ),
                      customLabelName("Native Address"),
                      customDetail(widget.userDataList.name),
                      customLabelName("Native Place"),
                      customDetail(widget.userDataList.name),
                      SizedBox(
                        height: Get.height * 0.05,
                      ),
                    ],
                  ),
                ),

                ///-----------------Main member------------------

                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: Get.width * 0.27,
                          width: Get.width * 0.27,
                          margin: EdgeInsets.only(
                              top: Get.height * 0.04,
                              bottom: Get.height * 0.03),
                          decoration:  BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://jymnew.spitel.com/${memberList?.avtarUrl}" ?? ""))),
                          // child: memberList!.avtarUrl != null
                          //     ? Image.network(
                          //         "https://jymnew.spitel.com/${memberList!.avtarUrl}",
                          //         height: Get.width * 0.15,
                          //         width: Get.width * 0.15,
                          //         fit: BoxFit.cover,
                          //       )
                          //     : const Icon(Icons.account_circle, size: 55),
                        ),
                      ),
                      customLabelName("Full Name"),
                      customDetail(
                          "${memberList?.firstName} ${memberList?.fatherHusbandName}"),
                      // customLabelName("Gautra"),
                      // customDetail(widget.userDataList.name),
                      // customLabelName("Nanihal Gautra"),
                      // customDetail(widget.userDataList.name),
                      customLabelName("DOB"),
                      // customDetail(DateFormat("dd-MM-yyyy")
                      //     .format(DateTime.parse(memberList?.dateOfBirth ?? ""))),

                      // customLabelName("Birth Time"),
                      // customDetail(widget.userDataList.timeOfBirth ?? ""),
                      // customLabelName("Birth Place"),
                      // customDetail(widget.userDataList.birthPlace ?? ""),
                      // customLabelName("Blood Group"),
                      // customDetail(widget.userDataList.bloodGroup.name),
                      customLabelName("Education"),
                      customDetail(memberList?.education ?? ""),
                      // customLabelName(widget.userDataList.name),
                      customLabelName("Mobile Number"),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.05, top: Get.height * 0.0075),
                        child: Row(
                          children: [
                            Text(
                              memberList?.phoneNo ?? "",
                              style: poppinsRegular.copyWith(
                                fontSize: Get.width * 0.04,
                                color: ThemeManager().getBlackColor,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Image.asset("assets/icon/call.png"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Image.asset("assets/icon/whatsapp.png"),
                            ),
                          ],
                        ),
                      ),
                      customLabelName("Email ID"),
                      customDetail(memberList?.emailId ?? ""),
                      customLabelName("Home Address"),
                      customDetail(memberList?.address ?? ""),
                      customLabelName("Home Mobile Number"),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.05, top: Get.height * 0.0075),
                        child: Row(
                          children: [
                            Text(
                              memberList?.altPhoneNo ?? "",
                              style: poppinsRegular.copyWith(
                                fontSize: Get.width * 0.04,
                                color: ThemeManager().getBlackColor,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Image.asset("assets/icon/call.png"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Image.asset("assets/icon/whatsapp.png"),
                            ),
                          ],
                        ),
                      ),
                      customLabelName("Native Address"),
                      customDetail(memberList?.nativeAddress ?? ""),
                      customLabelName("Native Place"),
                      customDetail(widget.userDataList.name),
                      SizedBox(
                        height: Get.height * 0.05,
                      ),
                    ],
                  ),
                ),

                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.05,
                      vertical: Get.height * 0.025,
                    ),
                    child: Container(
                      color: ThemeManager().getWhiteColor,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: memberList?.avtarUrl != null
                                ? Image.network(
                                    "https://jymnew.spitel.com/${memberList!.avtarUrl}",
                                    height: Get.width * 0.15,
                                    width: Get.width * 0.15,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(Icons.account_circle, size: 55),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: Get.width * 0.05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${memberList?.firstName} ${memberList?.fatherHusbandName}",
                                  style: poppinsMedium.copyWith(
                                    fontSize: Get.width * 0.035,
                                    color: ThemeManager().getBlackColor,
                                  ),
                                ),
                                Text(
                                  memberList?.phoneNo ?? "",
                                  style: poppinsMedium.copyWith(
                                    fontSize: Get.width * 0.03,
                                    color: ThemeManager().getLightGreyColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                ///-----------------Family------------------

                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customLabelName("Father Name"),
                      customDetail(widget.userDataList.name),
                      customLabelName("Mother Name"),
                      customDetail(widget.userDataList.name),
                      customLabelName("Sister Name"),
                      customDetail(widget.userDataList.name),
                      customLabelName("Brother Name"),
                      customDetail(widget.userDataList.name),
                    ],
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
