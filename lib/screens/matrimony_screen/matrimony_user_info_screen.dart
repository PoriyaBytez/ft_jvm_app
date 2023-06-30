import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jym_app/utils/theme_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/member_controller.dart';
import '../../controller/relationship_controller.dart';
import '../../controller/verification_controller/city_controller.dart';
import '../../controller/verification_controller/panth_controller.dart';
import '../../controller/verification_controller/state_controller.dart';
import '../../controller/verification_controller/surname_controller.dart';
import '../../models/matrimony_model/matrimony_model.dart';
import '../../models/member_model.dart';
import '../../utils/app_textstyle.dart';

class MatrimonyUserInfoScreen extends StatefulWidget {
  Datum? userDataList;

  MatrimonyUserInfoScreen({Key? key, this.userDataList}) : super(key: key);

  @override
  State<MatrimonyUserInfoScreen> createState() =>
      _MatrimonyUserInfoScreenState();
}

class _MatrimonyUserInfoScreenState extends State<MatrimonyUserInfoScreen>
    with SingleTickerProviderStateMixin {
  late TabController _mainTabController;
  // final memberController = Get.put(MemberController());
  final surNameController = Get.put(SurnameController());
  final stateController = Get.put(StateController());
  final panthController = Get.put(PanthController());
  final cityController = Get.put(CityController());
  final relationShipController = Get.put(RelationShipController());

  late Customer memberList;

  @override
  void initState() {
    _mainTabController = TabController(length: 2, vsync: this);
    super.initState();
    memberList = widget.userDataList?.customer ?? Customer();
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

  String naniyalGautra = "-", panth = "-", surName = "-",nativeCity = "-",memberCity = "-",
      businessCity = "-",businessState = "-",state = "-",sasuralGautra = "-",relation = '-';

  @override
  Widget build(BuildContext context) {
    // getMainMember();

    for (var element in stateController.stateList) {
      if (memberList.stateId == element.id.toString()) {
        state = element.name;
      }
      if (memberList.businessStateId == element.id.toString()) {
        businessState = element.name;
      }
    }

    for (var element in relationShipController.relationShipList) {
      if (widget.userDataList!.relationshipId == element.id.toString()) {
        relation = element.name;
        break;
      }
    }

    for (var element in cityController.cityList) {
      if (memberList.nativeCityId == element.id.toString()) {
        nativeCity = element.name;
      }
      if (memberList.cityId == element.id.toString()) {
        memberCity = element.name;
      }
      if (memberList.businessCityId == element.id.toString()) {
        businessCity = element.name;
      }
    }

    for (var element in surNameController.surnameList) {
      if (element.id.toString() == widget.userDataList?.naniyalGautraId) {
        naniyalGautra = element.name;
      }
      if (element.id.toString() == memberList.surnameId) {
        surName = element.name;
      }
      if (element.id.toString() == memberList.sasuralGautraId) {
        sasuralGautra = element.name;
      }

    }

    for (var element in panthController.panthList) {
      if (element.id.toString() == widget.userDataList?.panthId) {
        panth = element.name;
        break;
      }
    }
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
                      widget.userDataList?.avtar != null ?
                      Center(
                        child: Image.network(
                          "https://jymnew.spitel.com/${widget.userDataList?.avtar}",
                          height: Get.height * 0.3,
                          width: Get.width * 0.8,
                          fit: BoxFit.fill,
                        ),
                      ) : Container(),
                      customLabelName("Full Name"),
                      customDetail(widget.userDataList?.name ?? ""),
                      customLabelName("Gautra"),
                      customDetail(surName),
                      customLabelName("Relation"),
                      customDetail(relation),
                      customLabelName("Nanihal Gautra"),
                      customDetail(naniyalGautra),
                      customLabelName("Panth"),
                      customDetail(widget.userDataList?.panth?.name ?? "-"),
                      customLabelName("DOB"),
                      widget.userDataList?.dateOfBirth != null
                          ? customDetail(DateFormat("dd-MM-yyyy").format(
                              DateTime.parse(
                                  widget.userDataList!.dateOfBirth!)))
                          : customDetail("-"),
                      customLabelName("Birth Time"),
                      customDetail(widget.userDataList?.timeOfBirth ?? "-"),
                      customLabelName("Birth Place"),
                      customDetail(widget.userDataList?.birthPlace ?? "-"),
                      customLabelName("Blood Group"),
                      customDetail(
                          widget.userDataList?.bloodGroup?.name ?? "-"),
                      customLabelName("Education"),
                      customDetail(widget.userDataList?.education  ?? "-"),

                      customLabelName("Mobile Number"),
                      widget.userDataList!.phoneNo != null
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: Get.width * 0.05,
                                  top: Get.height * 0.0075),
                              child: Row(
                                children: [
                                  Text(
                                    widget.userDataList!.phoneNo!,
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
                                    child:
                                        Image.asset("assets/icon/whatsapp.png"),
                                  ),
                                ],
                              ),
                            )
                          : customDetail("-"),
                      customLabelName("Email ID"),
                      customDetail("-"),
                      customLabelName("Home Address"),
                      customDetail("-"),
                      customLabelName("Home Mobile Number"),
                      widget.userDataList!.phoneNo != null
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: Get.width * 0.05,
                                  top: Get.height * 0.0075),
                              child: Row(
                                children: [
                                  Text(
                                    "${widget.userDataList!.phoneNo}",
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
                                    child:
                                        Image.asset("assets/icon/whatsapp.png"),
                                  ),
                                ],
                              ),
                            )
                          : customDetail("-"),
                      customLabelName("Native Address"),
                      customDetail("-"),
                      customLabelName("Native Place"),
                      customDetail("-"),
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
                      memberList.avtarUrl != null ?
                      Center(
                        child: Image.network(
                          "https://jymnew.spitel.com/${memberList.avtarUrl}",
                          height: Get.height * 0.3,
                          width: Get.width * 0.8,
                          fit: BoxFit.fill,
                        ),
                      ) : Container(),
                      customLabelName("Full Name"),
                      customDetail(
                          "${memberList.firstName} ${memberList.fatherHusbandName} $surName"),
                      customLabelName("surname"),
                      customDetail(surName),
                      // customLabelName("Nanihal Gautra"),
                      // customDetail(widget.userDataList.name),
                      customLabelName("DOB"),
                      memberList.dateOfBirth != null
                          ? customDetail(DateFormat("dd-MM-yyyy")
                              .format(DateTime.parse(memberList.dateOfBirth!)))
                          : customDetail("-"),
                      customLabelName("Date of Anniversary"),
                      memberList.dateOfAnniversary != null
                          ? customDetail(DateFormat("dd-MM-yyyy").format(
                              DateTime.parse(memberList.dateOfAnniversary!)))
                          : customDetail("-"),
                      customLabelName("Birth Time"),
                      customDetail(memberList.timeOfBirth ?? "-"),
                      customLabelName("Birth Place"),
                      customDetail(memberList.birthPlace ?? "-"),
                      customLabelName("City"),
                      customDetail(memberCity),
                      customLabelName("State"),
                      customDetail(state),
                      customLabelName("Company Firm Name"),
                      customDetail(memberList.companyFirmName ?? "-"),
                      customLabelName("Business Address"),
                      customDetail(memberList.businessAddress ?? "-"),
                      customLabelName("Business Pincode"),
                      customDetail(memberList.businessPincode ?? "-"),
                      customLabelName("Business City"),
                      customDetail(businessCity),
                      customLabelName("Business State"),
                      customDetail(businessState),
                      // customLabelName("Blood Group"),
                      // customDetail(memberList.bloodGroupId ?? "-"),
                      customLabelName("Education"),
                      customDetail(memberList.education ?? "-"),
                      customLabelName("Mobile Number"),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.05, top: Get.height * 0.0075),
                        child: Row(
                          children: [
                            Text(
                              memberList.phoneNo ?? "-",
                              style: poppinsRegular.copyWith(
                                fontSize: Get.width * 0.04,
                                color: ThemeManager().getBlackColor,
                              ),
                            ),
                            InkWell(onTap: () => callToNumber(number: memberList.phoneNo!),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: Get.width * 0.02,
                                ),
                                child: Image.asset("assets/icon/call.png"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      customLabelName("Alternative Mobile Number"),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.05, top: Get.height * 0.0075),
                        child: Row(
                          children: [
                            Text(
                              memberList.altPhoneNo ?? "-",
                              style: poppinsRegular.copyWith(
                                fontSize: Get.width * 0.04,
                                color: ThemeManager().getBlackColor,
                              ),
                            ),
                            InkWell(onTap: () => callToNumber(number: memberList.altPhoneNo!),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: Get.width * 0.02,
                                ),
                                child: Image.asset("assets/icon/call.png"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      customLabelName("Email ID"),
                      customDetail(memberList.emailId ?? "-"),
                      customLabelName("Sasural Gautra"),
                      customDetail(sasuralGautra),

                      customLabelName("Home Address"),
                      customDetail(memberList.address ?? "-"),
                      customLabelName("Address"),
                      customDetail(memberList.address ?? "-"),
                      customLabelName("Native Pincode"),
                      customDetail(memberList.nativePincode ?? "-"),
                      customLabelName("Native Address"),
                      customDetail(memberList.nativeAddress ?? "-"),
                      customLabelName("Native City"),
                      customDetail(nativeCity),
                      SizedBox(
                        height: Get.height * 0.05,
                      ),
                    ],
                  ),
                ),

                // SingleChildScrollView(
                //   physics: const BouncingScrollPhysics(),
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(
                //       horizontal: Get.width * 0.05,
                //       vertical: Get.height * 0.025,
                //     ),
                //     child: Container(
                //       color: ThemeManager().getWhiteColor,
                //       child: Row(
                //         children: [
                //           ClipRRect(
                //             borderRadius: BorderRadius.circular(50),
                //             child: memberList?.avtarUrl != null
                //                 ? Image.network(
                //                     "https://jymnew.spitel.com/${memberList!.avtarUrl}",
                //                     height: Get.width * 0.15,
                //                     width: Get.width * 0.15,
                //                     fit: BoxFit.cover,
                //                   )
                //                 : const Icon(Icons.account_circle, size: 55),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(left: Get.width * 0.05),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   "${memberList?.firstName} ${memberList?.fatherHusbandName}",
                //                   style: poppinsMedium.copyWith(
                //                     fontSize: Get.width * 0.035,
                //                     color: ThemeManager().getBlackColor,
                //                   ),
                //                 ),
                //                 Text(
                //                   memberList?.phoneNo ?? "",
                //                   style: poppinsMedium.copyWith(
                //                     fontSize: Get.width * 0.03,
                //                     color: ThemeManager().getLightGreyColor,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),

                ///-----------------Family------------------

                // SingleChildScrollView(
                //   physics: const BouncingScrollPhysics(),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       customLabelName("Father Name"),
                //       customDetail(widget.userDataList?.name ?? ""),
                //       customLabelName("Mother Name"),
                //       customDetail(widget.userDataList?.name ?? ""),
                //       customLabelName("Sister Name"),
                //       customDetail(widget.userDataList?.name ?? ""),
                //       customLabelName("Brother Name"),
                //       customDetail(widget.userDataList?.name ?? ""),
                //     ],
                //   ),
                // )
              ],
            )),
          ],
        ),
      ),
    );
  }
  callToNumber({required String number}) async {
    final call = Uri.parse('tel:+91 $number');
    if (await canLaunchUrl(call)) {
      launchUrl(call);
    } else {
      throw 'Could not launch $call';
    }
  }
}
