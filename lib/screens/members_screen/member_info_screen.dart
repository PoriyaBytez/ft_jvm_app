import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../controller/business_category_controller.dart';
import '../../controller/verification_controller/city_controller.dart';
import '../../controller/verification_controller/city_state_wise_controller.dart';
import '../../controller/verification_controller/panth_controller.dart';
import '../../controller/verification_controller/state_controller.dart';
import '../../controller/verification_controller/surname_controller.dart';
import '../../models/member_model.dart';
import '../../utils/app_textstyle.dart';
import '../../utils/theme_manager.dart';

class MemberInfoScreen extends StatefulWidget {
  GetMember? userDataList;
  MemberInfoScreen(this.userDataList, {Key? key,}) : super(key: key);

  @override
  State<MemberInfoScreen> createState() => _MemberInfoScreenState();
}

class _MemberInfoScreenState extends State<MemberInfoScreen> with SingleTickerProviderStateMixin {

  final stateController = Get.put(StateController());
  final cityController = Get.put(CityController());
  final panthController = Get.put(PanthController());
  final surNameController = Get.put(SurnameController());
  final businessCategoryController = Get.put(BusineCategoryController());


  String state ="",city = "",gender = "", panth = "",surName = "",
      businessState = "",businessCity ="",businessCategory = "",
      nativeState = "",nativeCity = "",sasuralGautra = "";
  late TabController _mainTabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainTabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    for (var element in stateController.stateList) {
      if (widget.userDataList?.stateId == element.id.toString()) {
        state = element.name;
      }
      if (widget.userDataList?.businessStateId == element.id.toString()) {
        businessState = element.name;
      }
      if (widget.userDataList?.nativeStateId == element.id.toString()) {
        nativeState = element.name;
      }
    }
    for (var element in cityController.cityList) {
      if (widget.userDataList?.cityId == element.id.toString()) {
        city = element.name;
      }
      if (widget.userDataList?.businessCityId == element.id.toString()) {
        businessCity = element.name;
      }
      if (widget.userDataList?.nativeCityId == element.id.toString()) {
        nativeCity = element.name;
      }
    }
    for (var element in businessCategoryController.businessCategotyList) {
      if (widget.userDataList?.businessCategoryId == element.id.toString()) {
        businessCategory = element.name;
      }
    }
    if (widget.userDataList?.gender == "1") {
      gender = "Male";
      print(gender);
    } else {
      gender = "Female";
    }
    for (var element in panthController.panthList) {
      if (widget.userDataList?.panthId == element.id.toString()) {
        panth = element.name;
      }
    }
    for (var element in surNameController.surnameList) {
      if (widget.userDataList?.surnameId == element.id.toString()) {
        surName = element.name;
      }
      if (widget.userDataList?.sasuralGautraId == element.id.toString()) {
        sasuralGautra = element.name;
      }
    }
    print("gender ==> $gender");
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Center(
            child: Container(height: Get.height * .3,width: Get.width * 0.8,
              // borderRadius: BorderRadius.circular(100),
              child: widget.userDataList?.avtarUrl != null ? Image.network(
                "https://jymnew.spitel.com/${widget.userDataList!.avtarUrl}",
                height: Get.height * 0.3,
                width: Get.width * 0.8,
                fit: BoxFit.fill,
              ) : const Icon(Icons.account_circle,size: 55),
            ),
          ),
          ///-------------------TabBar---------------------

          Container(
            height: Get.height * 0.08,
            width: Get.width,
            // color: ThemeManager().getThemeGreenColor.withOpacity(0.1),
            child: TabBar(
                controller: _mainTabController,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                      width: 2.0, color: ThemeManager().getThemeGreenColor),
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
                tabs:  [
                  Tab(
                    child: Column(children: const [
                      Icon(Icons.account_circle),
                      Text("Profile"),
                    ],)
                  ),
                  Tab(
                    child: Column(children: const [
                      Icon(Icons.work),
                      Text("Work"),
                    ],)
                  ),
                  Tab(
                    child:Column(children: const [
                      Icon(Icons.supervisor_account_outlined),
                      Text("Family"),
                    ],),
                  ),
                ]),
          ),
         Expanded(child: TabBarView(controller: _mainTabController,children: [

           /// ------------------profile
           SingleChildScrollView(physics: const BouncingScrollPhysics(),child:
           Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
             customLabelName("Full Name"),
             customDetail(
                 "${widget.userDataList?.firstName}${widget.userDataList?.fatherHusbandName}"),
             customLabelName("Sur Name"),
             customDetail(surName),
             customLabelName("Panth"),
             customDetail(panth),
             // customLabelName("Gautra"),
             // customDetail(widget.userDataList.name),
             // customLabelName("Nanihal Gautra"),
             // customDetail(widget.userDataList.name),
             customLabelName("DOB"),
             widget.userDataList?.dateOfBirth != null ? customDetail(DateFormat("dd-MM-yyyy")
                 .format(DateTime.parse(widget.userDataList!.dateOfBirth!))) : customDetail(""),
             customLabelName("Time Of Birth"),
             customDetail(widget.userDataList?.timeOfBirth ?? ""),
             customLabelName("Birth Place"),
             customDetail(widget.userDataList?.birthPlace ?? ""),
             customLabelName("Date Of Anniversary"),
             widget.userDataList?.dateOfAnniversary != null ? customDetail(DateFormat("dd-MM-yyyy")
                 .format(DateTime.parse(widget.userDataList!.dateOfAnniversary!))) : customDetail(""),
             customLabelName("Gender"),
             customDetail(gender),
             customLabelName("Sasural Gautra"),
             customDetail(sasuralGautra),
             // customLabelName("Birth Time"),
             // customDetail(widget.userDataList.timeOfBirth ?? ""),
             // customLabelName("Birth Place"),
             // customDetail(widget.userDataList.birthPlace ?? ""),
             // customLabelName("Blood Group"),
             // customDetail(widget.userDataList.bloodGroup.name),
             customLabelName("Education"),
             customDetail(widget.userDataList?.education ?? ""),
             // customLabelName(widget.userDataList.name),
             customLabelName("Mobile Number"),
             Padding(
               padding: EdgeInsets.only(
                   left: Get.width * 0.05, top: Get.height * 0.0075),
               child: Row(
                 children: [
                   Text(
                     widget.userDataList?.phoneNo ?? "",
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
             customDetail(widget.userDataList?.emailId ?? ""),
             customLabelName("Home Address"),
             customDetail(widget.userDataList?.address ?? ""),
             customLabelName("City"),
             customDetail(city),
             customLabelName("State"),
             customDetail(state),

             customLabelName("Home Mobile Number"),
             Padding(
               padding: EdgeInsets.only(
                   left: Get.width * 0.05, top: Get.height * 0.0075),
               child: Row(
                 children: [
                   Text(
                     widget.userDataList?.altPhoneNo ?? "",
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
             customDetail(widget.userDataList?.nativeAddress ?? ""),
             customLabelName("Native PinCode"),
             customDetail(widget.userDataList?.nativePincode ?? ""),
             customLabelName("Native State"),
             customDetail(nativeState),
             customLabelName("Native City"),
             customDetail(nativeCity),
             SizedBox(
               height: Get.height * 0.05,
             ),
           ]),),

           /// -------------- work
           SingleChildScrollView(physics: BouncingScrollPhysics(),child:
           Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
             customLabelName("Business Category"),
             customDetail(businessCategory),
             customLabelName("Business Designation"),
             customDetail(widget.userDataList?.businessDesignation ?? ""),
             customLabelName("Business Address"),
             customDetail(widget.userDataList?.businessAddress ?? ""),
             customLabelName("Business Pincode"),
             customDetail(widget.userDataList?.businessPincode ?? ""),
             customLabelName("Business State"),
             customDetail(businessState),
             customLabelName("Business City"),
             customDetail(businessCity),

           ],)),

           /// ------------------ family
           Container(),
         ],))
        ],
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
}
