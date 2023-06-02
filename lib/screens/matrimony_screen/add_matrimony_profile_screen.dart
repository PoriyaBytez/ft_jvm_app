import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jym_app/utils/app_textstyle.dart';

import '../../common_widgets/custom_dropDownField.dart';
import '../../common_widgets/custom_textformfield.dart';
import '../../controller/blood_group_controller.dart';
import '../../utils/theme_manager.dart';

class AddMatrimonyProfileScreen extends StatefulWidget {
  const AddMatrimonyProfileScreen({Key? key}) : super(key: key);

  @override
  State<AddMatrimonyProfileScreen> createState() => _AddMatrimonyProfileScreenState();
}

class _AddMatrimonyProfileScreenState extends State<AddMatrimonyProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _mainTabController;
  var bloodGroupDropDownValue;
  String bloodGroupId = "";
  File? _pickedImage;
  final _picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController gautraController = TextEditingController();
  TextEditingController nanihalGautraController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController birthTimeController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController homeAddressController = TextEditingController();
  TextEditingController homeMobileController = TextEditingController();
  TextEditingController nativeAddressController = TextEditingController();
  TextEditingController nativePlaceController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController officeNumberController = TextEditingController();
  TextEditingController officeAddressController = TextEditingController();
  TextEditingController officeCityController = TextEditingController();
  TextEditingController officeStateController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController sisterNameController = TextEditingController();
  TextEditingController brotherNameController = TextEditingController();
  DateTime? birthDate;
  TimeOfDay? birthTime;
  final bloodGroupController = Get.put(BloodGroupController());

  @override
  void initState() {
    _mainTabController = TabController(length: 3, vsync: this);
    bloodGroupController.getBloodGroup();
    super.initState();
  }

  ///------------------Image Picker--------------------

  Future<void> openImagePicker(String imageSource) async {
    final XFile? pickedImage =
        await _picker.pickImage(source: imageSource == "Gallery" ? ImageSource.gallery : ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          "Add Matrimony Profile",
          style: poppinsSemiBold.copyWith(
            fontSize: Get.width * 0.05,
            color: ThemeManager().getBlackColor,
          ),
        ),
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
                    borderSide: BorderSide(width: 5.0, color: ThemeManager().getThemeGreenColor),
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
                      child: Text("Work"),
                    ),
                    Tab(
                      child: Text("Family"),
                    ),
                  ]),
            ),

            Expanded(
              child: TabBarView(
                controller: _mainTabController,
                children: [
                  ///---------------Profile---------------------

                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  height: Get.width * 0.32,
                                  width: Get.width * 0.32,
                                  margin: EdgeInsets.only(top: Get.height * 0.035),
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
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                              insetPadding: EdgeInsets.symmetric(
                                                vertical: Get.height * 0.4,
                                              ),
                                              backgroundColor: ThemeManager().getWhiteColor,
                                              child: Container(
                                                width: Get.width * 0.5,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
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
                                                            padding: EdgeInsets.only(left: Get.width * 0.035),
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
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Icon(
                                                              Icons.image,
                                                              size: Get.width * 0.065,
                                                              color: ThemeManager().getBlackColor,
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(left: Get.width * 0.035),
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
                                        child: Image.asset("assets/icon/image_picker.png"))),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: Get.width * 0.05,
                              top: Get.height * 0.03,
                              right: Get.width * 0.05,
                            ),
                            child: CustomTextFormField(
                              controller: fullNameController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "*Invalid Name.";
                                }
                                return null;
                              },
                              labelText: "Full Name",
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
                            padding: EdgeInsets.only(
                              left: Get.width * 0.05,
                              right: Get.width * 0.05,
                              top: Get.height * 0.03,
                            ),
                            child: CustomTextFormField(
                              controller: gautraController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "*Invalid Gautra.";
                                }
                                return null;
                              },
                              labelText: "Gautra",
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
                            padding: EdgeInsets.only(
                                left: Get.width * 0.05, right: Get.width * 0.05, top: Get.height * 0.03),
                            child: CustomTextFormField(
                              controller: nanihalGautraController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "*Invalid Nanihal Gautra.";
                                }
                                return null;
                              },
                              labelText: "Nanihal Gautra",
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
                            padding: EdgeInsets.only(
                                left: Get.width * 0.05, right: Get.width * 0.05, top: Get.height * 0.03),
                            child: CustomTextFormField(
                              controller: dobController,
                              keyboardType: TextInputType.text,
                              readOnly: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "*Invalid Date.";
                                }
                                return null;
                              },
                              onTap: () async {
                                birthDate = (await showDatePicker(
                                  context: context,
                                  initialDate: birthDate == null ? DateTime.now() : birthDate!,
                                  firstDate: DateTime(2023, 04),
                                  lastDate: DateTime(2100),
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
                                  dobController.text = DateFormat('dd-MM-yyyy').format(birthDate!).toString();
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
                            padding: EdgeInsets.only(
                                left: Get.width * 0.05, right: Get.width * 0.05, top: Get.height * 0.03),
                            child: CustomTextFormField(
                              controller: birthTimeController,
                              keyboardType: TextInputType.text,
                              readOnly: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "*Invalid Birth Time.";
                                }
                                return null;
                              },
                              onTap: () async {
                                birthTime = await showTimePicker(
                                    initialTime: birthTime == null ? TimeOfDay.now() : birthTime!,
                                    context: context,
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: ThemeManager()
                                                .getThemeGreenColor, // header background color// body text color
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    });
                                if (birthTime != null) {
                                  birthTimeController.text = birthTime!.format(context).toString();
                                }
                              },
                              suffixIcon: Image.asset("assets/icon/watch_time.png"),
                              labelText: "Birth Time",
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
                            padding: EdgeInsets.only(
                              left: Get.width * 0.05,
                              right: Get.width * 0.05,
                              top: Get.height * 0.03,
                            ),
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
                                        for (int i = 0; i < bloodGroupController.bloodGroupList.length; i++) {
                                          if (value == bloodGroupController.bloodGroupList[i].name) {
                                            bloodGroupId = bloodGroupController.bloodGroupList[i].id.toString();
                                          }
                                        }
                                        setState(() {});
                                      },
                                      labelText: "Select your BloodGroup",
                                    ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.05, right: Get.width * 0.05, top: Get.height * 0.03),
                            child: CustomTextFormField(
                              controller: educationController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "*Invalid Education.";
                                }
                                return null;
                              },
                              labelText: "Education",
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
                            padding: EdgeInsets.only(
                                left: Get.width * 0.05, right: Get.width * 0.05, top: Get.height * 0.03),
                            child: CustomTextFormField(
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
                          Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.05, right: Get.width * 0.05, top: Get.height * 0.03),
                            child: CustomTextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "*Invalid Email ID";
                                }
                                return null;
                              },
                              labelText: "Email ID",
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
                            padding: EdgeInsets.only(
                                left: Get.width * 0.05, right: Get.width * 0.05, top: Get.height * 0.03),
                            child: CustomTextFormField(
                              controller: homeAddressController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "*Invalid Home Address";
                                }
                                return null;
                              },
                              labelText: "Home Address",
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
                            padding: EdgeInsets.only(
                                left: Get.width * 0.05, right: Get.width * 0.05, top: Get.height * 0.03),
                            child: CustomTextFormField(
                              controller: homeMobileController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "*Invalid Home Mobile Number.";
                                }
                                return null;
                              },
                              labelText: "Home Mobile Number",
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
                            padding: EdgeInsets.only(
                                left: Get.width * 0.05, right: Get.width * 0.05, top: Get.height * 0.03),
                            child: CustomTextFormField(
                              controller: nativeAddressController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "*Invalid Native Address";
                                }
                                return null;
                              },
                              labelText: "Native Address",
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
                            padding: EdgeInsets.only(
                                left: Get.width * 0.05, right: Get.width * 0.05, top: Get.height * 0.03),
                            child: CustomTextFormField(
                              controller: nativePlaceController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "*Invalid Native Place";
                                }
                                return null;
                              },
                              labelText: "Native Place",
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

                          ///------------------Next Button------------------

                          Container(
                            width: Get.width,
                            height: Get.height * 0.06,
                            margin: EdgeInsets.symmetric(
                              vertical: Get.height * 0.03,
                              horizontal: Get.width * 0.05,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate() && _pickedImage != null) {
                                  _mainTabController.animateTo(1);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ThemeManager().getThemeGreenColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Text(
                                "Next",
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

                  ///---------------Work---------------------

                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.05,
                            top: Get.height * 0.03,
                            right: Get.width * 0.05,
                          ),
                          child: CustomTextFormField(
                            controller: designationController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              setState(() {});
                            },
                            labelText: "Designation",
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
                          padding: EdgeInsets.only(
                            left: Get.width * 0.05,
                            right: Get.width * 0.05,
                            top: Get.height * 0.03,
                          ),
                          child: CustomTextFormField(
                            controller: officeNumberController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              setState(() {});
                            },
                            labelText: "Office Number",
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
                          padding:
                              EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05, top: Get.height * 0.03),
                          child: CustomTextFormField(
                            controller: officeAddressController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              setState(() {});
                            },
                            labelText: "Office Number",
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
                          padding:
                              EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05, top: Get.height * 0.03),
                          child: CustomTextFormField(
                            controller: officeAddressController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              setState(() {});
                            },
                            labelText: "Address",
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
                          padding:
                              EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05, top: Get.height * 0.03),
                          child: CustomTextFormField(
                            controller: officeCityController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              setState(() {});
                            },
                            labelText: "City",
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
                          padding:
                              EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05, top: Get.height * 0.03),
                          child: CustomTextFormField(
                            controller: officeStateController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              setState(() {});
                            },
                            labelText: "State",
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

                        ///------------------Next Button------------------

                        Container(
                          height: Get.height * 0.06,
                          width: Get.width,
                          margin: EdgeInsets.symmetric(
                            vertical: Get.height * 0.065,
                            horizontal: Get.width * 0.05,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              _mainTabController.animateTo(2);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeManager().getThemeGreenColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Text(
                              "Next",
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

                  ///---------------Family---------------------

                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.05,
                            top: Get.height * 0.03,
                            right: Get.width * 0.05,
                          ),
                          child: CustomTextFormField(
                            controller: fatherNameController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              setState(() {});
                            },
                            labelText: "Father Name",
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
                          padding: EdgeInsets.only(
                            left: Get.width * 0.05,
                            right: Get.width * 0.05,
                            top: Get.height * 0.03,
                          ),
                          child: CustomTextFormField(
                            controller: motherNameController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              setState(() {});
                            },
                            labelText: "Mother Name",
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
                          padding:
                              EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05, top: Get.height * 0.03),
                          child: CustomTextFormField(
                            controller: sisterNameController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              setState(() {});
                            },
                            labelText: "Sister Name",
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
                          padding:
                              EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05, top: Get.height * 0.03),
                          child: CustomTextFormField(
                            controller: brotherNameController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              setState(() {});
                            },
                            labelText: "Brother Name",
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

                        ///------------------Send for approval Button------------------

                        Container(
                          width: Get.width,
                          height: Get.height * 0.06,
                          margin: EdgeInsets.symmetric(
                            vertical: Get.height * 0.3,
                            horizontal: Get.width * 0.05,
                          ),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeManager().getThemeGreenColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Text(
                              "Send for Approval",
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
