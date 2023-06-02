import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../controller/verification_controller/city_controller.dart';
import '../../controller/verification_controller/city_state_wise_controller.dart';
import '../../controller/verification_controller/state_controller.dart';
import '../../utils/app_textstyle.dart';
import '../../utils/theme_manager.dart';
import 'PDF_view_screen.dart';

class UtilityInfoScreen extends StatefulWidget {
  var utilityItem;

  UtilityInfoScreen({Key? key, this.utilityItem}) : super(key: key);

  @override
  State<UtilityInfoScreen> createState() => _UtilityInfoScreenState();
}

class _UtilityInfoScreenState extends State<UtilityInfoScreen> {
  final stateController = Get.put(StateController());
  // final cityStateWiseController = Get.put(CityStateWiseController());
  final  cityStateWiseController = Get.put(CityController());

  String cityName = "";
  String stateName = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // getCityState();
    for (var element in stateController.stateList) {
      if (widget.utilityItem.stateId == element.id.toString()) {
        stateName = element.name;
        print(stateName);
        break;
      }
    }
    if(widget.utilityItem.stateId != null) {
      print("lengh ==>${cityStateWiseController.cityList.length}");
      for (var element in cityStateWiseController.cityList) {
        if (widget.utilityItem.cityId == element.id.toString()) {
          cityName = element.name;
          break;
        }
      }
    }
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
          widget.utilityItem.name,overflow: TextOverflow.clip,
          style: poppinsSemiBold.copyWith(
            fontSize: Get.width * 0.05,
            color: ThemeManager().getBlackColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: Get.height,
          color: ThemeManager().getWhiteColor,
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.05,
            vertical: Get.height * 0.045,
          ),
          child: Column(
            children: [
              widget.utilityItem.bannerUrl == null
                  ? const SizedBox()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.network(
                        "https://jymnew.spitel.com${widget.utilityItem.bannerUrl}",
                        height: Get.width * 0.3,
                        width: Get.width * 0.3,
                        fit: BoxFit.cover,
                      ),
                    ),
              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.02),
                child: Text(
                  widget.utilityItem.address,
                  style: poppinsSemiBold.copyWith(
                      fontSize: Get.width * 0.04,
                      color: ThemeManager().getBlackColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.003),
                child: Text(
                  "$cityName, $stateName",
                  style: poppinsRegular.copyWith(
                      fontSize: Get.width * 0.04,
                      color: ThemeManager().getLightGreyColor),
                ),
              ),

              ///-----------------Address-----------------

              Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ThemeManager().getThemeGreenColor.withOpacity(0.1),
                  ),
                  margin: EdgeInsets.only(top: Get.height * 0.03),
                  padding: EdgeInsets.only(
                    left: Get.width * 0.05,
                    top: Get.height * 0.02,
                    bottom: Get.height * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Address",
                        style: poppinsSemiBold.copyWith(
                          fontSize: Get.width * 0.037,
                          color: ThemeManager().getBlackColor,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.7,
                        child: Text(
                          widget.utilityItem.address,
                          style: poppinsRegular.copyWith(
                            fontSize: Get.width * 0.037,
                            color: ThemeManager().getBlackColor,
                          ),
                        ),
                      ),
                    ],
                  )),

              ///-----------------description-----------------
              Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ThemeManager().getThemeGreenColor.withOpacity(0.1),
                  ),
                  margin: EdgeInsets.only(top: Get.height * 0.015),
                  padding: EdgeInsets.only(
                    left: Get.width * 0.05,
                    top: Get.height * 0.02,
                    bottom: Get.height * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: poppinsSemiBold.copyWith(
                          fontSize: Get.width * 0.037,
                          color: ThemeManager().getBlackColor,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.7,
                        child: Text(
                          widget.utilityItem.description,
                          style: poppinsRegular.copyWith(
                            fontSize: Get.width * 0.037,
                            color: ThemeManager().getBlackColor,
                          ),
                        ),
                      ),
                    ],
                  )),
              ///-----------------Pincode & Country-----------------

              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ThemeManager().getThemeGreenColor.withOpacity(0.1),
                ),
                margin: EdgeInsets.only(top: Get.height * 0.015),
                padding: EdgeInsets.only(
                  left: Get.width * 0.05,
                  top: Get.height * 0.02,
                  bottom: Get.height * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Pin code",
                            style: poppinsSemiBold.copyWith(
                              fontSize: Get.width * 0.037,
                              color: ThemeManager().getBlackColor,
                            ),
                          ),
                          Text(
                            "123456",
                            style: poppinsRegular.copyWith(
                              fontSize: Get.width * 0.037,
                              color: ThemeManager().getBlackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: Get.height * 0.075,
                      color: ThemeManager().getThemeGreenColor.withOpacity(0.1),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.025),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Country",
                            style: poppinsSemiBold.copyWith(
                              fontSize: Get.width * 0.037,
                              color: ThemeManager().getBlackColor,
                            ),
                          ),
                          SizedBox(
                            child: Text(
                              "India",
                              style: poppinsRegular.copyWith(
                                fontSize: Get.width * 0.037,
                                color: ThemeManager().getBlackColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              ///-----------------OfficeNumber & Mobile Number-----------------

              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ThemeManager().getThemeGreenColor.withOpacity(0.1),
                ),
                margin: EdgeInsets.only(top: Get.height * 0.015),
                padding: EdgeInsets.only(
                  left: Get.width * 0.05,
                  top: Get.height * 0.02,
                  bottom: Get.height * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Office Number",
                            style: poppinsSemiBold.copyWith(
                              fontSize: Get.width * 0.037,
                              color: ThemeManager().getBlackColor,
                            ),
                          ),
                          Text(
                            widget.utilityItem.officeNo ?? "",
                            style: poppinsRegular.copyWith(
                              fontSize: Get.width * 0.037,
                              color: ThemeManager().getBlackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: Get.height * 0.075,
                      color: ThemeManager().getThemeGreenColor.withOpacity(0.1),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.025),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Mobile Number",
                            style: poppinsSemiBold.copyWith(
                              fontSize: Get.width * 0.037,
                              color: ThemeManager().getBlackColor,
                            ),
                          ),
                          SizedBox(
                            child: Text(
                              widget.utilityItem.phoneNo ?? "",
                              style: poppinsRegular.copyWith(
                                fontSize: Get.width * 0.037,
                                color: ThemeManager().getBlackColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              widget.utilityItem.otherFile != null
                  ? InkWell(onTap: () {

                    String temp = widget.utilityItem.otherFile.toString().split(".").last;
                    print("object ==> $temp");
                    if(temp == "pdf") {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) {
                        return PDFView(PDFUrl: widget.utilityItem.otherFile);
                      },));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("File format is incorrect")));
                    }
                  },
                    child: Container(alignment: Alignment.center,
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(10)),
                child: const Text("View PDF",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w500)),
                      ),
                  )
                  /*Container(height: 320,width: double.infinity,
                child: SfPdfViewer.network(
                    "https://jymnew.spitel.com${widget.utilityItem.otherFile}"),
              )*/
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
