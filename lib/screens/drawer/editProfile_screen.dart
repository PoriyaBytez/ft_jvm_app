import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jym_app/common_widgets/custom_dropDownField.dart';
import 'package:jym_app/common_widgets/custom_dropdown2.dart';
import 'package:jym_app/common_widgets/list_view_common.dart';
import 'package:jym_app/controller/blood_group_controller.dart';
import 'package:jym_app/controller/business_category_controller.dart';
import 'package:jym_app/controller/patti_controller.dart';
import 'package:jym_app/controller/verification_controller/city_controller.dart';
import 'package:jym_app/controller/verification_controller/city_state_wise_controller.dart';
import 'package:jym_app/controller/verification_controller/panth_controller.dart';
import 'package:jym_app/controller/verification_controller/state_controller.dart';
import 'package:jym_app/controller/verification_controller/surname_controller.dart';
import 'package:jym_app/models/get_user_model.dart';
import 'package:jym_app/screens/main_screen.dart';
import 'package:jym_app/screens/splash_screen.dart';
import 'package:jym_app/services/api_services.dart';

import '../../common_widgets/custom_textformfield.dart';
import '../../models/family_members_model/family_members_model.dart';
import '../../utils/app_textstyle.dart';
import '../../utils/theme_manager.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController fatherHusbandController = TextEditingController();
  TextEditingController altNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController anniversaryController = TextEditingController();
  TextEditingController expiredController = TextEditingController();
  TextEditingController nativeAdressController = TextEditingController();
  TextEditingController nativePincodeController = TextEditingController();
  TextEditingController businessCategoryController = TextEditingController();
  TextEditingController businessDesignationController = TextEditingController();
  TextEditingController businessPinCodeController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController educationController = TextEditingController();

  /// ----------------- for search ---------------
  TextEditingController searchBusinessController = TextEditingController();
  TextEditingController searchPattiController = TextEditingController();
  TextEditingController searchBloodGroupController = TextEditingController();
  TextEditingController searchStatusController = TextEditingController();
  TextEditingController searchSasuralGautraController = TextEditingController();
  TextEditingController searchStateController = TextEditingController();
  TextEditingController searchCityController = TextEditingController();
  TextEditingController searchSurNameController = TextEditingController();
  TextEditingController searchPanthController = TextEditingController();
  TextEditingController searchNativeStateController = TextEditingController();
  TextEditingController searchNativeCityController = TextEditingController();
  TextEditingController searchYouStateController = TextEditingController();
  TextEditingController searchCurrentCityController = TextEditingController();

  DateTime? annivarsaryDate;
  DateTime? expiredDate;
  File? _pickedImage;
  final _picker = ImagePicker();

  ///------------------Image Picker--------------------

  Future<void> openImagePicker(String imageSource) async {
    final XFile? pickedImage = await _picker.pickImage(
        source: imageSource == "Gallery"
            ? ImageSource.gallery
            : ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    }
    await uploadAvtarApi(pickedImage!.path.toString());
  }

  String? urlImage;

  ///____________________upload avtar____________
  Future<void> uploadAvtarApi(String image) async {
    var data = await apiServices.uploadImageAvtar(image);
    urlImage = data["file_url"];
    print(data["file_url"]);
    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();

  //===============================>
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fullNameController.text = editProfileModel.firstName.toString();
      fatherHusbandController.text =
          editProfileModel.fatherHusbandName.toString();
      mobileNumberController.text = editProfileModel.phoneNo.toString();
      altNumberController.text = editProfileModel.altPhoneNo.toString();
      emailController.text = editProfileModel.emailId.toString();
      educationController.text = editProfileModel.education.toString();
      addressController.text = editProfileModel.address.toString();
      pinCodeController.text = editProfileModel.pincode.toString();
      stateController.stateList.forEach((element) {
        if (editProfileModel.stateId == element.id.toString()) {
          stateDropDownValue.text = element.name;
        }
      });
      cityStateWiseController.cityStateWiseList.forEach((element) {
        if (editProfileModel.cityId == element.id.toString()) {
          cityDropDownValue.text = element.name;
        }
      });
      dobController.text = editProfileModel.dateOfBirth.toString();
      anniversaryController.text =
          editProfileModel.dateOfAnniversary.toString();
      expiredController.text = editProfileModel.dateOfExpired.toString();
      if (editProfileModel.gender == "1") {
        genderDropDownValue = "Male";
        print(genderDropDownValue);
      } else {
        genderDropDownValue = "Female";
      }
      panthController.panthList.forEach((element) {
        if (editProfileModel.panthId == element.id.toString()) {
          panthDropDownValue.text = element.name;
        }
      });
      surNameController.surnameList.forEach((element) {
        if (editProfileModel.surnameId == element.id.toString()) {
          surNameDropDownValue.text = element.name;
          print(surNameDropDownValue);
        }
      });
      setState(() {});
    });

    super.initState();
  }

  final surNameController = Get.put(SurnameController());
  final panthController = Get.put(PanthController());
  final busineCategoryController = Get.put(BusineCategoryController());
  final pattiController = Get.put(PattiController());

  String? surNameId = "";
  String? panthId = "";
  String? cityId = "";
  String? stateId = "";
  String? nativeStateId = "";
  String? nativeCityId = "";
  String? businessCityId = "";
  String? businessStateId = "";
  String? businessCategoryId = "";
  String? sasuralGautraId = "";
  String? pattiId = "";

  TextEditingController pattiDropDownValue = TextEditingController();
  TextEditingController sasuralGautraDropDownValue = TextEditingController();
  TextEditingController surNameDropDownValue = TextEditingController();
  TextEditingController panthDropDownValue = TextEditingController();
  var genderDropDownValue;
  var businessCategoryDropDownValue;
  List<dynamic> searchList = [];
  List genderList = ["Female", "Male"];
  TextEditingController dobController = TextEditingController();
  DateTime? birthDate;
  final bloodGroupController = Get.put(BloodGroupController());
  String? bloodGroupId = "";
  var bloodGroupDropDownValue;
  var statusDropDownValue;

  TextEditingController stateDropDownValue = TextEditingController();
  TextEditingController nativeStateDropDownValue = TextEditingController();
  TextEditingController nativeCityDownValue = TextEditingController();
  TextEditingController cityDropDownValue = TextEditingController();
  TextEditingController businessCityDropDownValue = TextEditingController();
  TextEditingController businessStateDropDownValue = TextEditingController();
  final cityController = Get.put(CityController());
  final stateController = Get.put(StateController());
  final cityStateWiseController = Get.put(CityStateWiseController());
  List statusList = ["Married", "Unmarried", "Divorce"];
  APIServices apiServices = APIServices();

  @override
  Widget build(BuildContext context) {
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
          "Edit Profile",
          style: poppinsSemiBold.copyWith(
            fontSize: Get.width * 0.05,
            color: ThemeManager().getBlackColor,
          ),
        ),
        elevation: 2,
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        color: ThemeManager().getWhiteColor,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                avtarUploadEdit(),
                Text(
                  "Personal Details",
                  style: poppinsSemiBold.copyWith(
                    fontSize: Get.width * 0.05,
                    color: ThemeManager().getBlackColor,
                  ),
                ),
                personalWidget(context),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "Native Details",
                    style: poppinsSemiBold.copyWith(
                      fontSize: Get.width * 0.05,
                      color: ThemeManager().getBlackColor,
                    ),
                  ),
                ),
                nativeDetailWidget(),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "Business Details",
                    style: poppinsSemiBold.copyWith(
                      fontSize: Get.width * 0.05,
                      color: ThemeManager().getBlackColor,
                    ),
                  ),
                ),
                businessDetailWidget(),
                Container(
                  width: Get.width,
                  height: Get.height * 0.06,
                  margin: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.05,
                      vertical: Get.height * 0.035),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var dataBody = {
                          "avtar_url": urlImage ?? "https://jymnew.spitel.com${editProfileModel.avtarUrl}",
                          "first_name": fullNameController.text ?? "",
                          "father_husband_name":
                              fatherHusbandController.text ?? "",
                          "surname_id": surNameId ?? "",
                          "panth_id": panthId ?? "",
                          "patti_id": pattiId ?? "",
                          "phone_no": mobileNumberController.text ?? "",
                          "alt_phone_no": altNumberController.text ?? "",
                          "email_address": emailController.text ?? "",
                          "gender": genderDropDownValue == "Male" ? "1" : "2",
                          "date_of_birth": dobController.text ?? "",
                          "blood_group_id": bloodGroupId ?? "",
                          "address": addressController.text ?? "",
                          "pincode": pinCodeController.text ?? "",
                          "state_id": stateId ?? "",
                          "city_id": cityId ?? "",
                          "status_id": statusDropDownValue == "Married"
                              ? "1"
                              : statusDropDownValue == "Unmarried"
                                  ? "2"
                                  : statusDropDownValue == "Divorce",
                          "date_of_anniversary":
                              anniversaryController.text ?? "",
                          // "date_of_expiry": expiredController.text ?? "",
                          "sasural_gautra_id": sasuralGautraId ?? "",
                          "education": educationController.text ?? "",
                          "native_address": nativeAdressController.text ?? "",
                          "native_pincode": nativePincodeController.text ?? "",
                          "native_state_id": nativeStateId ?? "",
                          "native_city_id": nativeCityId ?? "",
                          "business_category_id": businessCategoryId ?? "",
                          "company_firm_name": companyNameController.text ?? "",
                          "designation":
                              businessDesignationController.text ?? "",
                          "business_address":
                              businessAddressController.text ?? "",
                          "business_pincode":
                              businessPinCodeController.text ?? "",
                          "business_state_id": businessStateId ?? "",
                          "business_city_id": businessCityId ?? "",
                        };
                        var data = await apiServices
                            .postUserData(dataBody, context)
                            .then((value) {
                          if (value != null) {
                            Get.off(() => MainScreen());
                          }
                        });
                        var dataEdit = await apiServices.getUserData();
                        var result = json.decode(dataEdit.body);
                        editProfileModel = EditProfileModel();
                        editProfileModel = EditProfileModel.fromJson(result);
                        setState(() {});
                        print(editProfileModel.avtarUrl);
                        print(result);
                        print(data);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeManager().getThemeGreenColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      "Save",
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
    );
  }

  Column businessDetailWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Obx(() => busineCategoryController.isLoading.value == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: ThemeManager().getThemeGreenColor,
                  ),
                )
              : CustomDropDownField2(
                  controller: businessCategoryController,
                  validator: (value) {
                    if (value == "") {
                      return "*Please select business category";
                    }
                    return null;
                  },
                  labelText: "Select your business category",
                  dropDownOnTap: () {
                    searchList.clear();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState1) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Material(
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: searchBusinessController,
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 8),
                                        hintText: "Search",
                                      ),
                                      onChanged: (value) {
                                        searchList.clear();
                                        if (value.isEmpty) {
                                          setState1(() {});
                                          return;
                                        }
                                        busineCategoryController
                                            .businessCategotyList
                                            .forEach((userDetail) {
                                          if (userDetail.name
                                                  .toString()
                                                  .toLowerCase()
                                                  .startsWith(
                                                      value.toLowerCase()) ||
                                              userDetail.name
                                                  .toString()
                                                  .toUpperCase()
                                                  .startsWith(
                                                      value.toUpperCase())) {
                                            print("object");
                                            searchList.add(userDetail);
                                          }
                                        });
                                        setState1(() {});
                                      },
                                    ),
                                    SizedBox(
                                      height: Get.height * .82,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: ListViewCommon(
                                          listShow: searchList.isNotEmpty
                                              ? searchList
                                              : busineCategoryController
                                                  .businessCategotyList,
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
                        businessCategoryController.text = searchList.isNotEmpty
                            ? searchList[value].name
                            : busineCategoryController
                                .businessCategotyList[value].name;
                        businessCategoryId = searchList.isNotEmpty
                            ? searchList[value].id.toString()
                            : busineCategoryController
                                .businessCategotyList[value].id
                                .toString();
                      }
                      print("object ==> $value");
                    });
                  },
                )),
        ),
        EditTextField(
          controller: companyNameController,
          hintText: "Company/firm name",
        ),
        EditTextField(
          controller: businessDesignationController,
          hintText: "Designation",
        ),
        EditTextField(
          controller: businessAddressController,
          hintText: "Address",
        ),
        EditTextField(
          controller: businessPinCodeController,
          hintText: "Pincode",
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Obx(() => stateController.isLoading.value == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: ThemeManager().getThemeGreenColor,
                  ),
                )
              : CustomDropDownField2(
                  controller: businessStateDropDownValue,
                  validator: (value) {
                    if (value == "") {
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
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Material(
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: searchYouStateController,
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 8),
                                        hintText: "Search",
                                      ),
                                      onChanged: (value) {
                                        searchList.clear();
                                        if (value.isEmpty) {
                                          setState1(() {});
                                          return;
                                        }
                                        stateController.stateList
                                            .forEach((userDetail) {
                                          if (userDetail.name
                                                  .toString()
                                                  .toLowerCase()
                                                  .startsWith(
                                                      value.toLowerCase()) ||
                                              userDetail.name
                                                  .toString()
                                                  .toUpperCase()
                                                  .startsWith(
                                                      value.toUpperCase())) {
                                            print("object");
                                            searchList.add(userDetail);
                                          }
                                        });
                                        setState1(() {});
                                      },
                                    ),
                                    SizedBox(
                                      height: Get.height * .82,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: ListViewCommon(
                                          listShow: searchList.isNotEmpty
                                              ? searchList
                                              : stateController.stateList,
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
                        businessStateDropDownValue.text = searchList.isNotEmpty
                            ? searchList[value].name
                            : stateController.stateList[value].name;
                        businessStateId = searchList.isNotEmpty
                            ? searchList[value].id.toString()
                            : stateController.stateList[value].id.toString();
                        cityStateWiseController.cityStateWise(businessStateId!);
                      }
                      print("object ==> $value");
                    });
                  },
                )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Obx(() => cityStateWiseController.isLoading == true.obs
              ? Center(
                  child: CircularProgressIndicator(
                    color: ThemeManager().getThemeGreenColor,
                  ),
                )
              : CustomDropDownField2(
                  controller: businessCityDropDownValue,
                  validator: (value) {
                    if (value == "") {
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
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Material(
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: searchCityController,
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 8),
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
                                            .forEach((userDetail) {
                                          if (userDetail.name
                                                  .toString()
                                                  .toLowerCase()
                                                  .startsWith(
                                                      value.toLowerCase()) ||
                                              userDetail.name
                                                  .toString()
                                                  .toUpperCase()
                                                  .startsWith(
                                                      value.toUpperCase())) {
                                            print("object");
                                            searchList.add(userDetail);
                                          }
                                        });
                                        setState1(() {});
                                      },
                                    ),
                                    SizedBox(
                                      height: Get.height * .82,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: ListViewCommon(
                                          listShow: searchList.isNotEmpty
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
                    ).then((value) {
                      if (value != null) {
                        businessCityDropDownValue.text = searchList.isNotEmpty
                            ? searchList[value].name
                            : cityStateWiseController
                                .cityStateWiseList[value].name;
                        businessCityId = searchList.isNotEmpty
                            ? searchList[value].id.toString()
                            : cityStateWiseController
                                .cityStateWiseList[value].id
                                .toString();
                      }
                      print("object ==> $value");
                    });
                  },
                )),
        ),
      ],
    );
  }

  Column nativeDetailWidget() {
    return Column(
      children: [
        EditTextField(
          controller: nativeAdressController,
          hintText: "Native Address",
        ),
        EditTextField(
          controller: nativePincodeController,
          hintText: "Native Pincode",
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Obx(() => stateController.isLoading.value == true
                  ? Center(
                      child: CircularProgressIndicator(
                        color: ThemeManager().getThemeGreenColor,
                      ),
                    )
                  : CustomDropDownField2(
                      controller: nativeStateDropDownValue,
                      validator: (value) {
                        if (value == "") {
                          return "*Please select state";
                        }
                        return null;
                      },
                      labelText: "Please select state",
                      dropDownOnTap: () {
                        searchList.clear();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState1) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Material(
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: searchStateController,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 8),
                                            hintText: "Search",
                                          ),
                                          onChanged: (value) {
                                            searchList.clear();
                                            if (value.isEmpty) {
                                              setState1(() {});
                                              return;
                                            }
                                            stateController.stateList
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
                                                searchList.add(userDetail);
                                              }
                                            });
                                            setState1(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: Get.height * .82,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: ListViewCommon(
                                              listShow: searchList.isNotEmpty
                                                  ? searchList
                                                  : stateController.stateList,
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
                            nativeStateDropDownValue.text =
                                searchList.isNotEmpty
                                    ? searchList[value].name
                                    : stateController.stateList[value].name;
                            nativeStateId = searchList.isNotEmpty
                                ? searchList[value].id.toString()
                                : stateController.stateList[value].id
                                    .toString();
                            cityStateWiseController
                                .cityStateWise(nativeStateId!);
                          }
                          print("object ==> $value");
                        });
                      },
                    )
              ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Obx(() => cityStateWiseController.isLoading == true.obs
                  ? Center(
                      child: CircularProgressIndicator(
                        color: ThemeManager().getThemeGreenColor,
                      ),
                    )
                  : CustomDropDownField2(
                      controller: nativeCityDownValue,
                      validator: (value) {
                        if (value == "") {
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Material(
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller:
                                              searchCurrentCityController,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 8),
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
                                                searchList.add(userDetail);
                                              }
                                            });
                                            setState1(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: Get.height * .82,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: ListViewCommon(
                                              listShow: searchList.isNotEmpty
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
                        ).then((value) {
                          if (value != null) {
                            nativeCityDownValue.text = searchList.isNotEmpty
                                ? searchList[value].name
                                : cityStateWiseController
                                    .cityStateWiseList[value].name;
                            nativeCityId = searchList.isNotEmpty
                                ? searchList[value].id.toString()
                                : cityStateWiseController
                                    .cityStateWiseList[value].id
                                    .toString();
                          }
                          print("object ==> $value");
                        });
                      },
                    )
              ),
        ),
      ],
    );
  }

  Column personalWidget(BuildContext context) {
    return Column(
      children: [
        EditTextField(
          controller: fullNameController,
          hintText: "Enter "
              "Full Name",
        ),
        EditTextField(
          controller: fatherHusbandController,
          hintText: "Father/Husband Name",
        ),
        EditTextField(
          controller: mobileNumberController,
          hintText: "Mobile Number",
        ),
        EditTextField(
          controller: altNumberController,
          hintText: "Alt Phone no",
        ),
        EditTextField(
          controller: emailController,
          hintText: "Ema"
              "il Address"
              "",
        ),
        EditTextField(
          controller: educationController,
          hintText: "Education",
        ),
        EditTextField(
          controller: addressController,
          hintText: "Address",
        ),
        EditTextField(
          controller: pinCodeController,
          hintText: "Pincode",
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Obx(() => pattiController.isLoading.value == true
                  ? Center(
                      child: CircularProgressIndicator(
                        color: ThemeManager().getThemeGreenColor,
                      ),
                    )
                  : CustomDropDownField2(
                      controller: pattiDropDownValue,
                      validator: (value) {
                        if (value == "") {
                          return "*Please Select Patti.";
                        }
                        return null;
                      },
                      labelText: "Select your Patti",
                      dropDownOnTap: () {
                        searchList.clear();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState1) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Material(
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: searchPattiController,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 8),
                                            hintText: "Search",
                                          ),
                                          onChanged: (value) {
                                            searchList.clear();
                                            if (value.isEmpty) {
                                              setState1(() {});
                                              return;
                                            }
                                            pattiController.pattiList
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
                                                searchList.add(userDetail);
                                              }
                                            });
                                            setState1(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: Get.height * .82,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: ListViewCommon(
                                              listShow: searchList.isNotEmpty
                                                  ? searchList
                                                  : pattiController.pattiList,
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
                            pattiDropDownValue.text = searchList.isNotEmpty
                                ? searchList[value].name
                                : pattiController.pattiList[value].name;
                            pattiId = searchList.isNotEmpty
                                ? searchList[value].id.toString()
                                : pattiController.pattiList[value].id
                                    .toString();
                          }
                          print("object ==> $value");
                        });
                      },
                    )
              ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Obx(
            () => bloodGroupController.isLoading.value == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: ThemeManager().getThemeGreenColor,
                    ),
                  )
                : CustomDropDownField(
                    value: bloodGroupDropDownValue,
                    validator: (value) {
                      if (value == null) {
                        return "*Please Select Blood group.";
                      }
                      return null;
                    },
                    items: bloodGroupController.bloodGroupList.map((items) {
                      return DropdownMenuItem(
                        value: items.name,
                        child: Text(
                          items.name,
                          style: poppinsRegular.copyWith(
                            fontSize: Get.width * 0.04,
                            color: ThemeManager().getBlackColor,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      bloodGroupDropDownValue = value;
                      for (int i = 0;
                          i < bloodGroupController.bloodGroupList.length;
                          i++) {
                        if (value ==
                            bloodGroupController.bloodGroupList[i].name) {
                          bloodGroupId = bloodGroupController
                              .bloodGroupList[i].id
                              .toString();
                        }
                      }
                      setState(() {});
                    },
                    labelText: "Select your BloodGroup",
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
        statusDropDownValue != "Married" ? Container() : Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Obx(() => surNameController.isLoading.value == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: ThemeManager().getThemeGreenColor,
                  ),
                )
              : CustomDropDownField2(
                  controller: sasuralGautraDropDownValue,
                  validator: (value) {
                    if (value == "") {
                      return "*Please select Sasural Gautra.";
                    }
                    return null;
                  },
                  labelText: "Select your Sasural Gautra",
                  dropDownOnTap: () {
                    searchList.clear();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState1) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Material(
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: searchSasuralGautraController,
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 8),
                                        hintText: "Search",
                                      ),
                                      onChanged: (value) {
                                        searchList.clear();
                                        if (value.isEmpty) {
                                          setState1(() {});
                                          return;
                                        }
                                        surNameController.surnameList
                                            .forEach((userDetail) {
                                          if (userDetail.name
                                                  .toString()
                                                  .toLowerCase()
                                                  .startsWith(
                                                      value.toLowerCase()) ||
                                              userDetail.name
                                                  .toString()
                                                  .toUpperCase()
                                                  .startsWith(
                                                      value.toUpperCase())) {
                                            print("object");
                                            searchList.add(userDetail);
                                          }
                                        });
                                        setState1(() {});
                                      },
                                    ),
                                    SizedBox(
                                      height: Get.height * .82,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: ListViewCommon(
                                          listShow: searchList.isNotEmpty
                                              ? searchList
                                              : surNameController.surnameList,
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
                        sasuralGautraDropDownValue.text = searchList.isNotEmpty
                            ? searchList[value].name
                            : surNameController.surnameList[value].name;
                        sasuralGautraId = searchList.isNotEmpty
                            ? searchList[value].id.toString()
                            : surNameController.surnameList[value].id
                                .toString();
                      }
                      print("object ==> $value");
                    });
                  },
                )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Obx(() => stateController.isLoading.value == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: ThemeManager().getThemeGreenColor,
                  ),
                )
              : CustomDropDownField2(
                  controller: stateDropDownValue,
                  validator: (value) {
                    if (value == "") {
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
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Material(
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: searchYouStateController,
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 8),
                                        hintText: "Search",
                                      ),
                                      onChanged: (value) {
                                        searchList.clear();
                                        if (value.isEmpty) {
                                          setState1(() {});
                                          return;
                                        }
                                        stateController.stateList
                                            .forEach((userDetail) {
                                          if (userDetail.name
                                                  .toString()
                                                  .toLowerCase()
                                                  .startsWith(
                                                      value.toLowerCase()) ||
                                              userDetail.name
                                                  .toString()
                                                  .toUpperCase()
                                                  .startsWith(
                                                      value.toUpperCase())) {
                                            print("object");
                                            searchList.add(userDetail);
                                          }
                                        });
                                        setState1(() {});
                                      },
                                    ),
                                    SizedBox(
                                      height: Get.height * .82,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: ListViewCommon(
                                          listShow: searchList.isNotEmpty
                                              ? searchList
                                              : stateController.stateList,
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
                        stateDropDownValue.text = searchList.isNotEmpty
                            ? searchList[value].name
                            : stateController.stateList[value].name;
                        stateId = searchList.isNotEmpty
                            ? searchList[value].id.toString()
                            : stateController.stateList[value].id.toString();
                        cityStateWiseController.cityStateWise(stateId!);
                        cityDropDownValue.clear();
                      }
                      print("object ==> $value");
                    });
                  },
                )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Obx(() => cityStateWiseController.isLoading == true.obs
              ? Center(
                  child: CircularProgressIndicator(
                    color: ThemeManager().getThemeGreenColor,
                  ),
                )
              : CustomDropDownField2(
                  controller: cityDropDownValue,
                  validator: (value) {
                    if (value == "") {
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
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Material(
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: searchCurrentCityController,
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 8),
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
                                            .forEach((userDetail) {
                                          if (userDetail.name
                                                  .toString()
                                                  .toLowerCase()
                                                  .startsWith(
                                                      value.toLowerCase()) ||
                                              userDetail.name
                                                  .toString()
                                                  .toUpperCase()
                                                  .startsWith(
                                                      value.toUpperCase())) {
                                            print("object");
                                            searchList.add(userDetail);
                                          }
                                        });
                                        setState1(() {});
                                      },
                                    ),
                                    SizedBox(
                                      height: Get.height * .82,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: ListViewCommon(
                                          listShow: searchList.isNotEmpty
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
                    ).then((value) {
                      if (value != null) {
                        cityDropDownValue.text = searchList.isNotEmpty
                            ? searchList[value].name
                            : cityStateWiseController
                                .cityStateWiseList[value].name;
                        cityId = searchList.isNotEmpty
                            ? searchList[value].id.toString()
                            : cityStateWiseController
                                .cityStateWiseList[value].id
                                .toString();
                      }
                      print("object ==> $value");
                    });
                  },
                )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                firstDate: DateTime(1925, 04),
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
                dobController.text =
                    DateFormat('yyyy-MM-dd').format(birthDate!).toString();
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
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: CustomDropDownField(
            value: genderDropDownValue,
            validator: (value) {
              if (value == null) {
                return "*Please select gender";
              }
              return null;
            },
            items: genderList.map((items) {
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
              genderDropDownValue = value;
              print(genderDropDownValue);
              setState(() {});
            },
            labelText: "Gender",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Obx(() => surNameController.isLoading.value == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: ThemeManager().getThemeGreenColor,
                  ),
                )
              : CustomDropDownField2(
                  controller: surNameDropDownValue,
                  validator: (value) {
                    if (value == "") {
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
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Material(
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: searchSurNameController,
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 8),
                                        hintText: "Search",
                                      ),
                                      onChanged: (value) {
                                        searchList.clear();
                                        if (value.isEmpty) {
                                          setState1(() {});
                                          return;
                                        }
                                        surNameController.surnameList
                                            .forEach((userDetail) {
                                          if (userDetail.name
                                                  .toString()
                                                  .toLowerCase()
                                                  .startsWith(
                                                      value.toLowerCase()) ||
                                              userDetail.name
                                                  .toString()
                                                  .toUpperCase()
                                                  .startsWith(
                                                      value.toUpperCase())) {
                                            print("object");
                                            searchList.add(userDetail);
                                          }
                                        });
                                        setState1(() {});
                                      },
                                    ),
                                    SizedBox(
                                      height: Get.height * .82,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: ListViewCommon(
                                          listShow: searchList.isNotEmpty
                                              ? searchList
                                              : surNameController.surnameList,
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
                        surNameDropDownValue.text = searchList.isNotEmpty
                            ? searchList[value].name
                            : surNameController.surnameList[value].name;
                        surNameId = searchList.isNotEmpty
                            ? searchList[value].id.toString()
                            : surNameController.surnameList[value].id
                                .toString();
                      }
                      print("object ==> $value");
                    });
                  },
                )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Obx(() => panthController.isLoading.value == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: ThemeManager().getThemeGreenColor,
                  ),
                )
              : CustomDropDownField2(
                  controller: panthDropDownValue,
                  validator: (value) {
                    if (value == "") {
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
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Material(
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: searchPanthController,
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 8),
                                        hintText: "Search",
                                      ),
                                      onChanged: (value) {
                                        searchList.clear();
                                        if (value.isEmpty) {
                                          setState1(() {});
                                          return;
                                        }
                                        panthController.panthList
                                            .forEach((userDetail) {
                                          if (userDetail.name
                                                  .toString()
                                                  .toLowerCase()
                                                  .startsWith(
                                                      value.toLowerCase()) ||
                                              userDetail.name
                                                  .toString()
                                                  .toUpperCase()
                                                  .startsWith(
                                                      value.toUpperCase())) {
                                            print("object");
                                            searchList.add(userDetail);
                                          }
                                        });
                                        setState1(() {});
                                      },
                                    ),
                                    SizedBox(
                                      height: Get.height * .82,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: ListViewCommon(
                                          listShow: searchList.isNotEmpty
                                              ? searchList
                                              : panthController.panthList,
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
                        panthDropDownValue.text = searchList.isNotEmpty
                            ? searchList[value].name
                            : panthController.panthList[value].name;
                        panthId = searchList.isNotEmpty
                            ? searchList[value].id.toString()
                            : panthController.panthList[value].id.toString();
                      }
                      print("object ==> $value");
                    });
                  },
                )),
        ),
        statusDropDownValue != "Married" ? Container() : Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: CustomTextFormField(
            controller: anniversaryController,
            keyboardType: TextInputType.text,
            readOnly: true,
            onChanged: (value) {
              setState(() {});
            },
            onTap: () async {
              annivarsaryDate = (await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950, 04),
                lastDate: DateTime(2050),
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
              if (annivarsaryDate != null) {
                anniversaryController.text = DateFormat('yyyy-MM-dd')
                    .format(annivarsaryDate!)
                    .toString();
                print(anniversaryController.text);
              }
            },
            suffixIcon: Image.asset("assets/icon/date_range.png"),
            labelText: "Date of anniversary",
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
        // Padding(
        //   padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        //   child: CustomTextFormField(
        //     controller: expiredController,
        //     keyboardType: TextInputType.text,
        //     readOnly: true,
        //     onChanged: (value) {
        //       setState(() {});
        //     },
        //     onTap: () async {
        //       expiredDate = (await showDatePicker(
        //         context: context,
        //         initialDate: DateTime.now(),
        //         firstDate: DateTime(2023, 04),
        //         lastDate: DateTime(2100),
        //         builder: (context, child) {
        //           return Theme(
        //             data: Theme.of(context).copyWith(
        //               colorScheme: ColorScheme.light(
        //                 primary: ThemeManager().getThemeGreenColor,
        //               ),
        //             ),
        //             child: child!,
        //           );
        //         },
        //       ));
        //       if (expiredDate != null) {
        //         expiredController.text =
        //             DateFormat('yyyy-MM-dd').format(expiredDate!).toString();
        //         print(expiredController.text);
        //       }
        //     },
        //     suffixIcon: Image.asset("assets/icon/date_range.png"),
        //     labelText: "Date of Expire",
        //     labelStyle: poppinsRegular.copyWith(
        //       fontSize: Get.width * 0.04,
        //       color: ThemeManager().getLightGreyColor,
        //     ),
        //     mainTextStyle: poppinsRegular.copyWith(
        //       fontSize: Get.width * 0.04,
        //       color: ThemeManager().getBlackColor,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Container avtarUploadEdit() {
    return Container(
      width: Get.width,
      height: Get.height * 0.20,
      color: ThemeManager().getLightYellowColor,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            height: Get.width * 0.32,
            width: Get.width * 0.32,
            margin: EdgeInsets.only(top: Get.height * 0.005),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ThemeManager().getThemeGreenColor.withOpacity(0.2),
            ),
            child: _pickedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: Image.file(
                      _pickedImage!,
                      fit: BoxFit.fill,
                    ))
                : ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: Image.network(
                      "https://jymnew.spitel.com${editProfileModel.avtarUrl}",
                      fit: BoxFit.fill,
                    ),
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
                      borderRadius: BorderRadius.circular(15),
                    ),
                    insetPadding: EdgeInsets.symmetric(
                      vertical: Get.height * 0.4,
                    ),
                    backgroundColor: ThemeManager().getWhiteColor,
                    child: Container(
                      width: Get.width * 0.5,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                              openImagePicker("Camera");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  size: Get.width * 0.065,
                                  color: ThemeManager().getBlackColor,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: Get.width * 0.035),
                                  child: Text(
                                    "Camera",
                                    style: poppinsRegular.copyWith(
                                      fontSize: Get.width * 0.045,
                                      color: ThemeManager().getBlackColor,
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
                              padding: EdgeInsets.only(top: Get.height * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.image,
                                    size: Get.width * 0.065,
                                    color: ThemeManager().getBlackColor,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.035),
                                    child: Text(
                                      "Gallery",
                                      style: poppinsRegular.copyWith(
                                        fontSize: Get.width * 0.045,
                                        color: ThemeManager().getBlackColor,
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
              child: Image.asset("assets/icon/image_picker.png"),
            ),
          ),
        ],
      ),
    );
  }

  Widget dialogDropDawn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Material(
        child: Column(
          children: [
            TextField(),
            SizedBox(
              height: Get.height * .82,
              child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: 50,
                itemBuilder: (context, index) {
                  return Text("data $index");
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  businessCategorySearch(String text) async {
    List<dynamic> allValue = [];
    print("text ==> $text");
    searchList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    busineCategoryController.businessCategotyList.forEach((userDetail) {
      if (userDetail.name
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()) ||
          userDetail.name
              .toString()
              .toUpperCase()
              .contains(text.toUpperCase())) {
        print("object");
        searchList.add(userDetail);
      }
    });
    setState(() {});
  }
}

class EditTextField extends StatelessWidget {
  EditTextField({
    super.key,
    required this.controller,
    this.hintText,
  });

  final TextEditingController controller;
  String? hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: CustomTextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        labelText: hintText,
        labelStyle: poppinsRegular.copyWith(
          fontSize: Get.width * 0.04,
          color: ThemeManager().getLightGreyColor,
        ),
        mainTextStyle: poppinsRegular.copyWith(
          fontSize: Get.width * 0.04,
          color: ThemeManager().getBlackColor,
        ),
      ),
    );
  }
}
