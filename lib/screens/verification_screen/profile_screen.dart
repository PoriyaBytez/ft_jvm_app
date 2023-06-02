import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jym_app/controller/verification_controller/city_controller.dart';
import 'package:jym_app/controller/verification_controller/state_controller.dart';
import 'package:jym_app/screens/main_screen.dart';
import 'package:jym_app/screens/onboarding_screen.dart';
import 'package:jym_app/utils/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_widgets/custom_dropDownField.dart';
import '../../common_widgets/custom_dropdown2.dart';
import '../../common_widgets/custom_textformfield.dart';
import '../../common_widgets/list_view_common.dart';
import '../../controller/verification_controller/city_state_wise_controller.dart';
import '../../controller/verification_controller/panth_controller.dart';
import '../../controller/verification_controller/surname_controller.dart';
import '../../services/api_services.dart';
import '../../utils/app_textstyle.dart';
import '../../utils/theme_manager.dart';

class ProfileScreen extends StatefulWidget {
  String? number;

  ProfileScreen({super.key, this.number});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController anniController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController searchYouStateController = TextEditingController();
  TextEditingController searchCurrentCityController = TextEditingController();
  TextEditingController searchBusinessCategory = TextEditingController();
  TextEditingController searchSurNameController = TextEditingController();
  TextEditingController searchPanthController = TextEditingController();
  DateTime? birthDate;
  DateTime? birthDateAnni;
  DateTime? birthDateExpiry;

  String selectedGender = "";
  TextEditingController stateDropDownValue = TextEditingController();
  TextEditingController cityDropDownValue = TextEditingController();
  TextEditingController nativePlaceDropDownValue = TextEditingController();
  TextEditingController panthDropDownValue = TextEditingController();
  TextEditingController surNameDropDownValue = TextEditingController();
  var statusDropDownValue;
  List<String> stateList = ["Karnataka", "West Bengal", "Gujarat", "Punjab"];
  List<String> cityList = ["Hubali", "Kolkata", "Delhi", "Mumbai"];
  List<String> nativeList = ["Khundala", "Chroyasi", "Kandala", "Utils"];
  List statusList = ["Married", "Unmarried", "Expired", "Divorce"];
  List<dynamic> searchList = [];
  final GlobalKey<FormState> _validatorKey = GlobalKey();
  File? _pickedImage;
  String? _pickedImagePath;
  final _picker = ImagePicker();
  final panthController = Get.put(PanthController());
  final stateController = Get.put(StateController());
  final cityStateWiseController = Get.put(CityStateWiseController());
  final cityController = Get.put(CityController());
  final surNameController = Get.put(SurnameController());
  APIServices apiServices = APIServices();
  String? nativeId = "",
      cityId = "",
      stateId = "",
      panthId = "",
      surNameId = "";
  final _formKey = GlobalKey<FormState>();

  ///------------------Image Picker--------------------

  Future<void> openImagePicker(String imageSource) async {
    final XFile? pickedImage = await _picker.pickImage(
        source: imageSource == "Gallery"
            ? ImageSource.gallery
            : ImageSource.camera);
    if (pickedImage != null) {
      _pickedImage = File(pickedImage.path);
      _pickedImagePath = pickedImage.path;
      setState(() {});
    }
  }

  String urlVtar = '';

  ///____________________upload avtar____________
  Future<void> uploadAvtarApi(String image) async {
    var data = await apiServices.uploadImageAvtar(image);
    setState(() {
      urlVtar = data["file_url"];
    });
  }

  ///-----------------Send User Data------------------
  final Preferences _preferences = Preferences();

  Future<void> sendUserData(dataBody) async {
    var data = await apiServices.postUserData(dataBody,context);
    if (data != null) {
      Get.dialog(
          WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              insetPadding: EdgeInsets.symmetric(
                vertical: Get.height * 0.15,
              ),
              backgroundColor: ThemeManager().getWhiteColor,
              child: SizedBox(
                width: Get.width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: Get.height * 0.045,
                      ),
                      child: Image.asset(
                        "assets/icon/registration_under_process.png",
                        height: Get.width * 0.25,
                        width: Get.width * 0.25,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: Get.height * 0.035,
                      ),
                      child: Text(
                        "Registration under process.",
                        style: poppinsSemiBold.copyWith(
                          color: ThemeManager().getThemeGreenColor,
                          fontSize: Get.width * 0.055,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: Get.height * 0.025,
                      ),
                      child: SizedBox(
                        width: Get.width * 0.7,
                        child: Text(
                          "Your Registration is under process. Thank you for your Patience.",
                          style: poppinsRegular.copyWith(
                            color: ThemeManager().getLightGreyColor,
                            fontSize: Get.width * 0.04,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: Get.height * 0.025,
                      ),
                      child: Row(children: <Widget>[
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(
                                left: Get.width * 0.05,
                                right: Get.width * 0.035,
                              ),
                              child: Divider(
                                color: ThemeManager().getBlackColor,
                                height: 2,
                              )),
                        ),
                        Text(
                          "Contact US",
                          style: poppinsRegular.copyWith(
                            fontSize: Get.width * 0.045,
                            color: ThemeManager().getBlackColor,
                          ),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(
                                left: Get.width * 0.035,
                                right: Get.width * 0.05,
                              ),
                              child: Divider(
                                color: ThemeManager().getBlackColor,
                                height: 2,
                              )),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: Get.height * 0.025,
                      ),
                      child: Text(
                        "contactus@jym.com",
                        style: poppinsRegular.copyWith(
                          color: ThemeManager().getLightGreyColor,
                          fontSize: Get.width * 0.04,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: Get.height * 0.015,
                      ),
                      child: Text(
                        "+91 ${mobileNumberController.text}",
                        style: poppinsRegular.copyWith(
                          color: ThemeManager().getLightGreyColor,
                          fontSize: Get.width * 0.04,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: Get.width,
                      height: Get.height * 0.06,
                      margin: EdgeInsets.only(
                          left: Get.width * 0.05,
                          top: Get.height * 0.045,
                          right: Get.width * 0.05),
                      child: ElevatedButton(
                        onPressed: () {
                          // SystemNavigator.pop();
                          // Get.back();
                          // Get.off(() => const MainScreen());
                          Get.off(() => const OnBoardingScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeManager().getThemeGreenColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.25,
                            vertical: Get.height * 0.015,
                          ),
                        ),
                        child: Text(
                          "ok",
                          style: poppinsSemiBold.copyWith(
                            fontSize: Get.width * 0.045,
                            color: ThemeManager().getWhiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          barrierColor: ThemeManager().getBlackColor.withOpacity(0.3),
          barrierDismissible: false);
    } else {
      Get.showSnackbar(
        GetSnackBar(
          messageText: Text(
            "Sorry, couldn't send your data",
            style: poppinsRegular.copyWith(
              fontSize: Get.width * 0.035,
              color: ThemeManager().getWhiteColor,
            ),
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ThemeManager().getRedColor,
          borderRadius: 20,
          margin: EdgeInsets.symmetric(
              horizontal: Get.width * 0.05, vertical: Get.height * 0.02),
          duration: const Duration(seconds: 3),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mobileNumberController.text = _preferences.getNumber() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              height: Get.height,
              width: Get.width,
              color: ThemeManager().getWhiteColor,
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05,
                vertical: Get.height * 0.02,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _validatorKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///----------------Back button-------------------

                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: Get.width * 0.1,
                          width: Get.width * 0.1,
                          decoration: BoxDecoration(
                            color: ThemeManager().getWhiteColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: ThemeManager()
                                      .getBlackColor
                                      .withOpacity(0.075),
                                  spreadRadius: 4,
                                  blurRadius: 3),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.arrow_back_rounded,
                            size: Get.width * 0.065,
                            color: ThemeManager().getThemeGreenColor,
                          ),
                        ),
                      ),

                      ///----------------Main title text-------------------

                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.025),
                        child: Text(
                          "Lets’s Get Started",
                          style: poppinsLight.copyWith(
                            color: ThemeManager().getBlackColor,
                            fontSize: Get.width * 0.065,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.01),
                        child: SizedBox(
                          width: Get.width * 0.8,
                          child: Text(
                            "Please enter below details to Register with us",
                            style: poppinsLight.copyWith(
                              color: ThemeManager().getLightGreyColor,
                              fontSize: Get.width * 0.04,
                            ),
                          ),
                        ),
                      ),

                      ///---------------User picture----------------

                      Center(
                        child: Stack(
                          children: [
                            Container(
                              height: Get.width * 0.32,
                              width: Get.width * 0.32,
                              margin: EdgeInsets.only(top: Get.height * 0.035),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ThemeManager()
                                    .getThemeGreenColor
                                    .withOpacity(0.2),
                              ),
                              child: _pickedImage != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(75),
                                      child: Image.file(
                                        _pickedImage!,
                                        fit: BoxFit.fill,
                                      ))
                                  : Icon(
                                      Icons.person,
                                      size: Get.width * 0.13,
                                      color: ThemeManager().getThemeGreenColor,
                                    ),
                            ),
                            Positioned(
                                right: 1,
                                bottom: 1,
                                child: GestureDetector(
                                    onTap: () {
                                      Get.dialog(
                                        Dialog(
                                          alignment: Alignment.center,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          insetPadding: EdgeInsets.symmetric(
                                            vertical: Get.height * 0.4,
                                          ),
                                          backgroundColor:
                                              ThemeManager().getWhiteColor,
                                          child: Container(
                                            width: Get.width * 0.5,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Get.width * 0.15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.back();
                                                    openImagePicker("Camera");
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Icon(
                                                        Icons.camera_alt,
                                                        size: Get.width * 0.065,
                                                        color: ThemeManager()
                                                            .getBlackColor,
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            left: Get.width *
                                                                0.035),
                                                        child: Text(
                                                          "Camera",
                                                          style: poppinsRegular
                                                              .copyWith(
                                                            fontSize:
                                                                Get.width * 0.045,
                                                            color: ThemeManager()
                                                                .getBlackColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.back();
                                                    openImagePicker("Gallery");
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: Get.height * 0.02),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Icon(
                                                          Icons.image,
                                                          size: Get.width * 0.065,
                                                          color: ThemeManager()
                                                              .getBlackColor,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left:
                                                                      Get.width *
                                                                          0.035),
                                                          child: Text(
                                                            "Gallery",
                                                            style: poppinsRegular
                                                                .copyWith(
                                                              fontSize:
                                                                  Get.width *
                                                                      0.045,
                                                              color: ThemeManager()
                                                                  .getBlackColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Image.asset(
                                        "assets/icon/image_picker.png"))),
                          ],
                        ),
                      ),

                      ///-------------------First Name Text field------------------------

                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.035),
                        child: CustomTextFormField(
                          controller: firstNameController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "*Invalid Name.";
                            }
                            return null;
                          },
                          labelText: "First Name",
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

                      ///-------------------Father/Husband Name Text field------------------------

                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.035),
                        child: CustomTextFormField(
                          controller: fatherNameController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "*Invalid Name.";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                          labelText: "Father Name / Husband Name",
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

                      ///-------------------SurName Text field------------------------

                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.035),
                        child: Obx(() => surNameController.isLoading.value == true
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: ThemeManager().getThemeGreenColor,
                                ),
                              )
                            : CustomDropDownField2(
                                controller: surNameDropDownValue,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "*Please select surname.";
                                  }
                                  return null;
                                },
                                labelText: "Select your Surname",
                                dropDownOnTap: () {
                                  searchList.clear();
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                        builder: (context, setState1) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Material(
                                              child: Column(
                                                children: [
                                                  TextField(
                                                    controller:
                                                        searchSurNameController,
                                                    decoration:
                                                        const InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 8),
                                                      hintText: "Search",
                                                    ),
                                                    onChanged: (value) {
                                                      searchList.clear();
                                                      if (value.isEmpty) {
                                                        setState1(() {});
                                                        return;
                                                      }
                                                      surNameController
                                                          .surnameList
                                                          .forEach((userDetail) {
                                                        if (userDetail.name
                                                                .toString()
                                                                .toLowerCase()
                                                                .startsWith(value
                                                                    .toLowerCase()) ||
                                                            userDetail.name
                                                                .toString()
                                                                .toUpperCase()
                                                                .startsWith(value
                                                                    .toUpperCase())) {
                                                          print("object");
                                                          searchList
                                                              .add(userDetail);
                                                        }
                                                      });
                                                      setState1(() {});
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * .82,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: ListViewCommon(
                                                        listShow: searchList
                                                                .isNotEmpty
                                                            ? searchList
                                                            : surNameController
                                                                .surnameList,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ).then((value) {
                                    if (value != null) {
                                      surNameDropDownValue.text =
                                          searchList.isNotEmpty
                                              ? searchList[value].name
                                              : surNameController
                                                  .surnameList[value].name;
                                      surNameId = searchList.isNotEmpty
                                          ? searchList[value].id.toString()
                                          : surNameController
                                              .surnameList[value].id
                                              .toString();
                                    }
                                    print("object ==> $value");
                                  });
                                },
                              )),
                      ),

                      ///-------------------Panth Text field------------------------

                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.035),
                        child: Obx(
                          () => panthController.isLoading.value == true
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: ThemeManager().getThemeGreenColor,
                                  ),
                                )
                              : CustomDropDownField2(
                                  controller: panthDropDownValue,
                                  validator: (value) {
                                    if (value == null) {
                                      return "*Please select panth";
                                    }
                                    return null;
                                  },
                                  labelText: "Select your Panth",
                                  dropDownOnTap: () {
                                    searchList.clear();
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (context, setState1) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 20),
                                              child: Material(
                                                child: Column(
                                                  children: [
                                                    TextField(
                                                      controller:
                                                          searchPanthController,
                                                      decoration:
                                                          const InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 8),
                                                        hintText: "Search",
                                                      ),
                                                      onChanged: (value) {
                                                        searchList.clear();
                                                        if (value.isEmpty) {
                                                          setState1(() {});
                                                          return;
                                                        }
                                                        panthController.panthList
                                                            .forEach(
                                                                (userDetail) {
                                                          if (userDetail.name
                                                                  .toString()
                                                                  .toLowerCase()
                                                                  .startsWith(value
                                                                      .toLowerCase()) ||
                                                              userDetail.name
                                                                  .toString()
                                                                  .toUpperCase()
                                                                  .startsWith(value
                                                                      .toUpperCase())) {
                                                            print("object");
                                                            searchList
                                                                .add(userDetail);
                                                          }
                                                        });
                                                        setState1(() {});
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * .82,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                left: 8.0),
                                                        child: ListViewCommon(
                                                          listShow: searchList
                                                                  .isNotEmpty
                                                              ? searchList
                                                              : panthController
                                                                  .panthList,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ).then((value) {
                                      if (value != null) {
                                        panthDropDownValue.text =
                                            searchList.isNotEmpty
                                                ? searchList[value].name
                                                : panthController
                                                    .panthList[value].name;
                                        panthId = searchList.isNotEmpty
                                            ? searchList[value].id.toString()
                                            : panthController.panthList[value].id
                                                .toString();
                                      }
                                      print("object ==> $value");
                                    });
                                  },
                                ),
                        ),
                      ),

                      ///-------------------Gender Select------------------------

                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.035),
                        child: Text(
                          "Select Gender",
                          style: poppinsSemiBold.copyWith(
                            fontSize: Get.width * 0.035,
                            color: ThemeManager().getBlackColor,
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                          top: Get.height * 0.035,
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                selectedGender = "Male";
                                setState(() {});
                              },
                              child: Container(
                                height: Get.height * 0.15,
                                width: Get.width * 0.27,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ThemeManager().getWhiteColor,
                                  border: Border.all(
                                    color: selectedGender == "Male"
                                        ? ThemeManager().getThemeGreenColor
                                        : Colors.transparent,
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ThemeManager()
                                          .getBlackColor
                                          .withOpacity(0.075),
                                      blurRadius: 1.2,
                                      spreadRadius: 1.5,
                                      offset: const Offset(2, 4),
                                    )
                                  ],
                                  // color: Colors.red,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/icon/gender_male.png"),
                                    Text(
                                      "Male",
                                      style: poppinsRegular.copyWith(
                                        fontSize: Get.width * 0.035,
                                        color: ThemeManager().getBlackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                selectedGender = "Female";
                                setState(() {});
                              },
                              child: Container(
                                height: Get.height * 0.15,
                                width: Get.width * 0.27,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: Get.width * 0.05),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ThemeManager().getWhiteColor,
                                  border: Border.all(
                                    color: selectedGender == "Female"
                                        ? ThemeManager().getThemeGreenColor
                                        : Colors.transparent,
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ThemeManager()
                                          .getBlackColor
                                          .withOpacity(0.075),
                                      blurRadius: 1.2,
                                      spreadRadius: 1.5,
                                      offset: const Offset(2, 4),
                                    )
                                  ],
                                  // color: Colors.red,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/icon/gender_female.png"),
                                    Text(
                                      "Female",
                                      style: poppinsRegular.copyWith(
                                        fontSize: Get.width * 0.035,
                                        color: ThemeManager().getBlackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      ///-----------------Mobile Number TextField-----------------

                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.035),
                        child: CustomTextFormField(
                          textInputAction: TextInputAction.next,
                          controller: mobileNumberController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                            LengthLimitingTextInputFormatter(10),
                          ],
                          validator: (value) {
                            if (value.isEmpty) {
                              return "*Invalid Number";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {});
                          },
                          readOnly: true,
                          prefix: Text(
                            "+91",
                            style: poppinsRegular.copyWith(
                              fontSize: Get.width * 0.04,
                              color: ThemeManager().getBlackColor,
                            ),
                          ),
                          labelText: "Mobile Number",
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

                      ///____________________ dob ________________________________
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.035),
                        child: CustomTextFormField(
                          controller: dobController,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          onChanged: (value) {
                            setState(() {});
                          },
                          onTap: () async {
                            birthDate = (await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1800, 04),
                              lastDate: DateTime.now(),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: ThemeManager().getThemeGreenColor,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            ));
                            if (birthDate != null) {
                              dobController.text = DateFormat('yyyy-MM-dd')
                                  .format(birthDate!)
                                  .toString();
                              print(dobController.text);
                            }
                          },
                          suffixIcon: Image.asset("assets/icon/date_range.png"),
                          labelText: "DOB",
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

                      ///___________________Status __________________________

                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.035),
                        child: CustomDropDownField(
                          value: statusDropDownValue,
                          validator: (value) {
                            if (value == null) {
                              return "*Please select status";
                            }
                            return null;
                          },
                          items: statusList.map((items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: poppinsRegular.copyWith(
                                  fontSize: Get.width * 0.04,
                                  color: ThemeManager().getBlackColor,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            statusDropDownValue = value;
                            print(statusDropDownValue);
                            setState(() {});
                          },
                          labelText: "Status",
                        ),
                      ),

                      ///---------------------State-----------------------------
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.035),
                        child: Obx(
                          () => stateController.isLoading.value == true
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: ThemeManager().getThemeGreenColor,
                                  ),
                                )
                              : CustomDropDownField2(
                                  controller: stateDropDownValue,
                                  validator: (value) {
                                    if (value == null) {
                                      return "*Please select state";
                                    }
                                    return null;
                                  },
                                  labelText: "Select your State",
                                  dropDownOnTap: () {
                                    searchList.clear();
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (context, setState1) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 20),
                                              child: Material(
                                                child: Column(
                                                  children: [
                                                    TextField(
                                                      controller:
                                                          searchYouStateController,
                                                      decoration:
                                                          const InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 8),
                                                        hintText: "Search",
                                                      ),
                                                      onChanged: (value) {
                                                        searchList.clear();
                                                        if (value.isEmpty) {
                                                          setState1(() {});
                                                          return;
                                                        }
                                                        stateController.stateList
                                                            .forEach(
                                                                (userDetail) {
                                                          if (userDetail.name
                                                                  .toString()
                                                                  .toLowerCase()
                                                                  .startsWith(value
                                                                      .toLowerCase()) ||
                                                              userDetail.name
                                                                  .toString()
                                                                  .toUpperCase()
                                                                  .startsWith(value
                                                                      .toUpperCase())) {
                                                            print("object");
                                                            searchList
                                                                .add(userDetail);
                                                          }
                                                        });
                                                        setState1(() {});
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * .82,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                left: 8.0),
                                                        child: ListViewCommon(
                                                          listShow: searchList
                                                                  .isNotEmpty
                                                              ? searchList
                                                              : stateController
                                                                  .stateList,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ).then((value) {
                                      if (value != null) {
                                        stateDropDownValue.text =
                                            searchList.isNotEmpty
                                                ? searchList[value].name
                                                : stateController
                                                    .stateList[value].name;
                                        stateId = searchList.isNotEmpty
                                            ? searchList[value].id.toString()
                                            : stateController.stateList[value].id
                                                .toString();
                                        cityStateWiseController
                                            .cityStateWise(stateId!);
                                      }
                                      print("object ==> $value");
                                    });
                                  },
                                ),
                        ),
                      ),

                      ///---------------------City-----------------------------

                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.035),
                        child: Obx(
                          () => cityStateWiseController.isLoading == true.obs
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: ThemeManager().getThemeGreenColor,
                                  ),
                                )
                              : CustomDropDownField2(
                                  controller: cityDropDownValue,
                                  validator: (value) {
                                    if (value == null) {
                                      return "*Please select city";
                                    }
                                    return null;
                                  },
                                  labelText: "Current City",
                                  dropDownOnTap: () {
                                    searchList.clear();
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (context, setState1) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 20),
                                              child: Material(
                                                child: Column(
                                                  children: [
                                                    TextField(
                                                      controller:
                                                          searchCurrentCityController,
                                                      decoration:
                                                          const InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 8),
                                                        hintText: "Search",
                                                      ),
                                                      onChanged: (value) {
                                                        searchList.clear();
                                                        if (value.isEmpty) {
                                                          setState1(() {});
                                                          return;
                                                        }
                                                        cityStateWiseController
                                                            .cityStateWiseList
                                                            .forEach(
                                                                (userDetail) {
                                                          if (userDetail.name
                                                                  .toString()
                                                                  .toLowerCase()
                                                                  .startsWith(value
                                                                      .toLowerCase()) ||
                                                              userDetail.name
                                                                  .toString()
                                                                  .toUpperCase()
                                                                  .startsWith(value
                                                                      .toUpperCase())) {
                                                            print("object");
                                                            searchList
                                                                .add(userDetail);
                                                          }
                                                        });
                                                        setState1(() {});
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * .82,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                left: 8.0),
                                                        child: ListViewCommon(
                                                          listShow: searchList
                                                                  .isNotEmpty
                                                              ? searchList
                                                              : cityStateWiseController
                                                                  .cityStateWiseList,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ).then((value) async {
                                      if (value != null) {
                                        cityDropDownValue.text =
                                            searchList.isNotEmpty
                                                ? searchList[value].name
                                                : cityStateWiseController
                                                    .cityStateWiseList[value]
                                                    .name;
                                        final SharedPreferences prefs =
                                            await SharedPreferences.getInstance();
                                        await prefs.setString(
                                            "cityName", cityDropDownValue.text);
                                        cityId = searchList.isNotEmpty
                                            ? searchList[value].id.toString()
                                            : cityStateWiseController
                                                .cityStateWiseList[value].id
                                                .toString();
                                      }
                                      print("object ==> $value");
                                    });
                                  },
                                ),
                        ),
                      ),

                      ///---------------------Native Place-----------------------------

                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.035),
                        child: Obx(() => cityController.isLoading == true.obs
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: ThemeManager().getThemeGreenColor,
                                    ),
                                  )
                                : CustomDropDownField2(
                                    controller: nativePlaceDropDownValue,
                                    validator: (value) {
                                      if (value == null) {
                                        return "*Please select place";
                                      }
                                      return null;
                                    },
                                    labelText: "Native Place",
                                    dropDownOnTap: () {
                                      searchList.clear();
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(
                                            builder: (context, setState1) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20),
                                                child: Material(
                                                  child: Column(
                                                    children: [
                                                      TextField(
                                                        controller:
                                                            searchBusinessCategory,
                                                        decoration:
                                                            const InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 8),
                                                          hintText: "Search",
                                                        ),
                                                        onChanged: (value) {
                                                          searchList.clear();
                                                          if (value.isEmpty) {
                                                            setState1(() {});
                                                            return;
                                                          }
                                                          cityController.cityList
                                                              .forEach(
                                                                  (userDetail) {
                                                            if (userDetail.name
                                                                    .toString()
                                                                    .toLowerCase()
                                                                    .startsWith(value
                                                                        .toLowerCase()) ||
                                                                userDetail.name
                                                                    .toString()
                                                                    .toUpperCase()
                                                                    .startsWith(value
                                                                        .toUpperCase())) {
                                                              print("object");
                                                              searchList.add(
                                                                  userDetail);
                                                            }
                                                          });
                                                          setState1(() {});
                                                        },
                                                      ),
                                                      SizedBox(
                                                        height: Get.height * .82,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0),
                                                          child: ListViewCommon(
                                                            listShow: searchList
                                                                    .isNotEmpty
                                                                ? searchList
                                                                : cityController
                                                                    .cityList,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ).then((value) {
                                        if (value != null) {
                                          nativePlaceDropDownValue.text =
                                              searchList.isNotEmpty
                                                  ? searchList[value].name
                                                  : cityController
                                                      .cityList[value].name;
                                          nativeId = searchList.isNotEmpty
                                              ? searchList[value].id.toString()
                                              : cityController.cityList[value].id
                                                  .toString();
                                        }
                                        print("object ==> $value");
                                      });
                                    },
                                  )
                            /*CustomDropDownField(
                                  value: nativePlaceDropDownValue,
                                  validator: (value) {
                                    if (value == null) {
                                      return "*Please select place";
                                    }
                                    return null;
                                  },
                                  items: cityController.cityList.map((items) {
                                    return DropdownMenuItem(
                                      value: items.city,
                                      child: Text(
                                        items.city,
                                        style: poppinsRegular.copyWith(
                                          fontSize: Get.width * 0.04,
                                          color: ThemeManager().getBlackColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    nativePlaceDropDownValue = value;
                                    for (int i = 0;
                                        i < cityController.cityList.length;
                                        i++) {
                                      if (cityController.cityList[i].city ==
                                          value) {
                                        nativeId = cityController.cityList[i].id
                                            .toString();
                                      }
                                    }
                                    setState(() {});
                                  },
                                  labelText: "Native Place",
                                ),*/
                            ),
                      ),

                      ///---------------------Send for approval button-----------------------------

                      Container(
                        width: Get.width,
                        height: Get.height * 0.06,
                        margin: EdgeInsets.only(top: Get.height * 0.035),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate() && _pickedImage != null &&
                            selectedGender != "") {
                              await uploadAvtarApi(_pickedImage!.path.toString());

                              FocusScope.of(context).unfocus();
                                var dataBody = {
                                  "avtar_url": urlVtar,
                                  "first_name": firstNameController.text.trim(),
                                  "father_husband_name":
                                      fatherNameController.text.trim(),
                                  "surname_id": surNameId,
                                  "panth_id": panthId,
                                  "patti_id": "0",
                                  "phone_no": mobileNumberController.text.trim(),
                                  "alt_phone_no": "",
                                  "email_address": "",
                                  "gender": selectedGender == "Male" ? "1" : "2",
                                  "date_of_birth": dobController.text,
                                  "blood_group_id": "",
                                  "address": "",
                                  "pincode": "",
                                  "state_id": stateId,
                                  "city_id": cityId,
                                  "status_id": "",
                                  "date_of_anniversary": anniController.text,
                                  "date_of_expiry": expiryController.text,
                                  "sasural_gautra_id": "",
                                  "education": "",
                                  "native_address": "",
                                  "native_pincode": "",
                                  "native_state_id": "",
                                  "native_city_id": nativeId,
                                  "business_category_id": "",
                                  "company_firm_name": "",
                                  "designation": "",
                                  "business_address": "",
                                  "business_pincode": "",
                                  "business_state_id": "",
                                  "business_city_id": ""
                                };
                                print(dataBody);

                                sendUserData(dataBody);
                            } else {
                              Get.showSnackbar(
                                GetSnackBar(
                                  messageText: Text(
                                    "Please fill all the details.",
                                    style: poppinsRegular.copyWith(
                                      fontSize: Get.width * 0.035,
                                      color: ThemeManager().getWhiteColor,
                                    ),
                                  ),
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: ThemeManager().getRedColor,
                                  borderRadius: 20,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.05,
                                      vertical: Get.height * 0.02),
                                  duration: const Duration(seconds: 3),
                                  isDismissible: true,
                                  forwardAnimationCurve: Curves.easeOutBack,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeManager().getThemeGreenColor,
                            disabledBackgroundColor: ThemeManager()
                                .getThemeGreenColor
                                .withOpacity(0.57),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            "Send for approval",
                            style: poppinsSemiBold.copyWith(
                              fontSize: Get.width * 0.04,
                              color: ThemeManager().getWhiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
