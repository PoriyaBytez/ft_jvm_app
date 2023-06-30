import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/blood_group_controller.dart';
import '../../controller/relationship_controller.dart';
import '../../controller/verification_controller/city_controller.dart';
import '../../controller/verification_controller/panth_controller.dart';
import '../../controller/verification_controller/state_controller.dart';
import '../../controller/verification_controller/surname_controller.dart';
import '../../models/member_model.dart';
import '../../utils/app_textstyle.dart';
import '../../utils/theme_manager.dart';

class FamilyDetailsScreen extends StatefulWidget {
  final FamilyMember? userDataList;

  const FamilyDetailsScreen({Key? key, this.userDataList}) : super(key: key);

  @override
  State<FamilyDetailsScreen> createState() => _FamilyDetailsScreenState();
}

class _FamilyDetailsScreenState extends State<FamilyDetailsScreen> {
  final surNameController = Get.put(SurnameController());
  final stateController = Get.put(StateController());
  final panthController = Get.put(PanthController());
  final cityController = Get.put(CityController());
  final relationShipController = Get.put(RelationShipController());
  final bloodGroupController = Get.put(BloodGroupController());

  String relation = '-',
      naniyalGautra = "-",
      panth = "-",
      bloodGroup = "-",
      gender = "-";

  @override
  Widget build(BuildContext context) {
    for (var element in relationShipController.relationShipList) {
      if (widget.userDataList!.relationshipId == element.id.toString()) {
        relation = element.name;
        break;
      }
    }
    for (var element in bloodGroupController.bloodGroupList) {
      if (widget.userDataList!.bloodGroupId == element.id.toString()) {
        bloodGroup = element.name;
        break;
      }
    }
    for (var element in panthController.panthList) {
      if (element.id.toString() == widget.userDataList?.panthId) {
        panth = element.name;
        break;
      }
    }
    for (var element in surNameController.surnameList) {
      if (element.id.toString() == widget.userDataList?.naniyalGautraId) {
        naniyalGautra = element.name;
        break;
      }
    }
    if (widget.userDataList?.gender == "1") {
      gender = "Male";
      print(gender);
    } else {
      gender = "Female";
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
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: widget.userDataList!.avtar == null
                    ? const Icon(
                        Icons.account_circle,
                        size: 90,
                        color: Colors.black,
                      )
                    : Center(
                  child: Image.network(
                    "https://jymnew.spitel.com/${widget.userDataList?.avtar}",
                    height: Get.height * 0.3,
                    width: Get.width * 0.8,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              customLabelName("Full Name"),
              customDetail(widget.userDataList?.name ?? "-"),
              // customLabelName("Gautra"),
              // customDetail("-"),
              customLabelName("Relation"),
              customDetail(relation),
              customLabelName("Nanihal Gautra"),
              customDetail(naniyalGautra),
              customLabelName("Panth"),
              customDetail(panth),
              customLabelName("Gender"),
              customDetail(gender),
              customLabelName("DOB"),
              widget.userDataList?.dateOfBirth != null
                  ? customDetail(DateFormat("dd-MM-yyyy").format(
                      DateTime.parse(widget.userDataList!.dateOfBirth!)))
                  : customDetail("-"),
              customLabelName("Status"),
              widget.userDataList!.status == "1"
                  ? customDetail("Married")
                  : widget.userDataList!.status == "2"
                      ? customDetail("Unmarried")
                      : widget.userDataList!.status == "3"
                          ? customDetail("Expired")
                          : customDetail("Divorce"),
              widget.userDataList!.status == "3"
                  ? customLabelName("Birth Time")
                  : Container(),
              widget.userDataList!.status == "3"
                  ? customDetail(widget.userDataList?.dateOfExpire ?? "-")
                  : Container(),
              widget.userDataList!.status == "2"
                  ? customLabelName("Birth Time")
                  : Container(),
              widget.userDataList!.status == "2"
                  ? customDetail(widget.userDataList?.timeOfBirth ?? "-")
                  : Container(),
              widget.userDataList!.status == "2"
                  ? customLabelName("Birth Place")
                  : Container(),
              widget.userDataList!.status == "2"
                  ? customDetail(widget.userDataList?.birthPlace ?? "-")
                  : Container(),
              customLabelName("Blood Group"),
              customDetail(bloodGroup),
              customLabelName("Education"),
              customDetail(widget.userDataList?.education ?? "-"),
              customLabelName("Mobile Number"),
              widget.userDataList!.phoneNo != null
                  ? Padding(
                      padding: EdgeInsets.only(
                          left: Get.width * 0.05, top: Get.height * 0.0075),
                      child: Row(
                        children: [
                          Text(
                            widget.userDataList!.phoneNo!,
                            style: poppinsRegular.copyWith(
                              fontSize: Get.width * 0.04,
                              color: ThemeManager().getBlackColor,
                            ),
                          ),
                          InkWell(onTap: () => callToNumber(number: widget.userDataList!.phoneNo!),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: Get.width * 0.02,
                              ),
                              child: Image.asset("assets/icon/call.png"),
                            ),
                          ),
                        ],
                      ),
                    )
                  : customDetail("-"),
              SizedBox(
                height: Get.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
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

  callToNumber({required String number}) async {
    final call = Uri.parse('tel:+91 $number');
    if (await canLaunchUrl(call)) {
      launchUrl(call);
    } else {
      throw 'Could not launch $call';
    }
  }
}
