import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jym_app/controller/blood_group_controller.dart';
import 'package:jym_app/controller/relationship_controller.dart';
import 'package:jym_app/controller/verification_controller/panth_controller.dart';
import 'package:jym_app/controller/verification_controller/surname_controller.dart';
import 'package:jym_app/screens/drawer/list_family_member_screen.dart';
import 'package:jym_app/services/api_services.dart';

import '../../common_widgets/custom_dropDownField.dart';
import '../../common_widgets/custom_dropdown2.dart';
import '../../common_widgets/custom_textformfield.dart';
import '../../common_widgets/list_view_common.dart';
import '../../models/family_members_model/family_members_model.dart';
import '../../utils/app_textstyle.dart';
import '../../utils/theme_manager.dart';
import '../main_screen.dart';

class AddFamilyMemberScreen extends StatefulWidget {
  FamilyMembersModel? memberList;

  AddFamilyMemberScreen({Key? key,this.memberList}) : super(key: key);

  @override
  State<AddFamilyMemberScreen> createState() => _AddFamilyMemberScreenState();
}

class _AddFamilyMemberScreenState extends State<AddFamilyMemberScreen> {

  //controller
  final panthController = Get.put(PanthController());
  String panthId = "";

  //
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController birthTimeController = TextEditingController();
  TextEditingController birthPlaceController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController anniversaryController = TextEditingController();
  TextEditingController expiredController = TextEditingController();
  TextEditingController searchPanthController = TextEditingController();
  TextEditingController searchRelationController = TextEditingController();
  TextEditingController searchSurNameController = TextEditingController();
  DateTime? birthDate;
  DateTime? annivarsaryDate;
  DateTime? expiredDate;
  TimeOfDay? birthTime;
  File? _pickedImage;
  final _picker = ImagePicker();
  TextEditingController panthDropDownValue = TextEditingController();
  TextEditingController relationDropDownValue = TextEditingController();
  TextEditingController surNameDropDownValue = TextEditingController();

  var genderDropDownValue;
  var statusDropDownValue;
  var bloodGroupDropDownValue;
  List panthList = ["Panth 1", "Panth 2", "Panth 3", "Panth 4"];
  List genderList = ["Female", "Male"];
  List statusList = ["Married", "Unmarried", "Expired", "Divorce"];
  List<dynamic> searchList = [];
  bool allowMatrimony = false;

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
  }

  APIServices apiServices = APIServices();

  //api calling for add member
  final surNameController = Get.put(SurnameController());
  final bloodGroupController = Get.put(BloodGroupController());
  final relationShipController = Get.put(RelationShipController());

  String? surNameId;
  String? bloodGroupId;
  String? relationId;
  String? selectedGender;
  String? uploadedImage;
  final _formKey = GlobalKey<FormState>();

  initializeValue(){
    uploadedImage = "https://jymnew.spitel.com${widget.memberList!.avtar}";
    if(widget.memberList?.gender == "1"){
      genderDropDownValue= "Male";
    } else {
      genderDropDownValue= "Female";
    }
    // if(widget.memberList?.status == "0"){
    //   statusDropDownValue = "Married";
    // } else if(widget.memberList?.status == "1") {
    //   statusDropDownValue= "Unmarried";
    // } else if(widget.memberList?.status == "2") {
    //   statusDropDownValue = "Expired";
    // } else {
    //   statusDropDownValue = "Divorce";
    // }
    // genderDropDownValue = widget.memberList?.gender ?? "";
    statusDropDownValue = statusList[int.parse(widget.memberList!.status!)];

    for (var element in bloodGroupController.bloodGroupList) {
      if(element.id.toString() == widget.memberList!.bloodGroupId){
        bloodGroupDropDownValue = element.name;
        break;
      }
    }
    // DateFormat("dd-MM-yyyy")
        // .format(DateTime.parse(widget.userDataList!.dateOfBirth!);
    expiredController.text = widget.memberList?.dateOfExpire ?? "";
    // widget.memberList?.dateOfExpire != null ? expiredController.text =  DateFormat("dd-MM-yyyy")
    //     .format(DateTime.parse(widget.memberList!.dateOfBirth!)) : expiredController.text = "";
    fullNameController.text = widget.memberList?.name ?? "";
    phoneNumberController.text = widget.memberList?.phoneNo ?? "";
    birthTimeController.text = widget.memberList?.timeOfBirth ?? "";
    birthPlaceController.text = widget.memberList?.birthPlace ?? "";
    aboutController.text = widget.memberList?.about ?? "";
    dobController.text = widget.memberList?.dateOfBirth ?? "";
    educationController.text = widget.memberList?.education ?? "";
    anniversaryController.text = widget.memberList?.dateOfAnniversary ?? "";
    expiredController.text = widget.memberList?.dateOfExpire ?? "";
    expiredController.text = widget.memberList?.dateOfExpire ?? "";

    for (var element in panthController.panthList) {
      if(element.id.toString() == widget.memberList!.panthId){
        panthDropDownValue.text = element.name;
      }
    }

    for (var element in relationShipController.relationShipList) {
      if(element.id.toString() == widget.memberList!.relationshipId){
        relationDropDownValue.text = element.name;
        break;
      }
    }
    setState(() {});
  }
@override
  void initState() {
    // if(widget.memberList != null) {
    //   initializeValue();
    // }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(widget.memberList != null) {
      initializeValue();
    }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          Get.to(() => const MainScreen());
          return true;
        },
        child: Scaffold(
          appBar: buildAppBar(),
          body: Form(
            key: _formKey,
            child: Container(
              height: Get.height,
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              color: ThemeManager().getWhiteColor,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    //image
                    avtarUpload(),
                    //name
                    nameField(),

                    //number

                    phoneField(),

                    //panth
                    panthField(),
                    //gender

                    genderField(),

                    ///---------------------Status-----------------------------

                    statusField(),

                    //if status married
                    if (statusDropDownValue == "Married")
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.035),
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
                            if (annivarsaryDate != null) {
                              anniversaryController.text =
                                  DateFormat('yyyy-MM-dd')
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
                    //if status is expired
                    if (statusDropDownValue == "Expired")
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.035),
                        child: CustomTextFormField(
                          controller: expiredController,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          onChanged: (value) {
                            setState(() {});
                          },
                          onTap: () async {
                            expiredDate = (await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
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
                            if (expiredDate != null) {
                              expiredController.text = DateFormat('yyyy-MM-dd')
                                  .format(expiredDate!)
                                  .toString();
                              print(expiredController.text);
                            }
                          },
                          suffixIcon: Image.asset("assets/icon/date_range.png"),
                          labelText: "Date of Expire",
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

                    ///---------------------BirthTime----------------

                    statusDropDownValue != "Expired" || statusDropDownValue !="Married" ? birthTimeField(context) : Container(),

                    ///-------------------Birth Place Text field------------------------

                    birthPlaceField(),

                    ///-------------------RelationShip Text field------------------------

                    relationShipField(),

                    ///-------------------About Text field------------------------

                    aboutField(),

                    ///---------------------DOB----------------------

                    dateOfBirthField(context),

                    ///-------------------education Text field------------------------

                    educationField(),

                    ///---------------------Blood Group-----------------------------

                    bloodGroupField(),

                    if (statusDropDownValue != 'Married' &&
                        statusDropDownValue != "Expired")
                      Column(
                        children: [
                          (statusDropDownValue == "Unmarried" ||
                                  statusDropDownValue == "Divorce")
                              ? allowMatrimonyCheckBox()
                              : Container(),

                          ///---------------------Naniyal Gautra-----------------------------
                          if (allowMatrimony == true) gautraField(),
                        ],
                      ),
                    addMemberButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding birthPlaceField() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.035),
      child: CustomTextFormField(
        controller: birthPlaceController,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value.isEmpty) {
            return "*Invalid birth place.";
          }
          return null;
        },
        labelText: "Birth Place",
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

  Padding birthTimeField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.035),
      child: CustomTextFormField(
        controller: birthTimeController,
        keyboardType: TextInputType.text,
        readOnly: true,
        onChanged: (value) {
          setState(() {});
        },
        onTap: () async {
          birthTime = await showTimePicker(
              initialTime: TimeOfDay.now(),
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
    );
  }

  Padding statusField() {
    return Padding(
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
    );
  }

  Padding genderField() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.035),
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
    );
  }

  Padding panthField() {
    return Padding(
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
                                      contentPadding: EdgeInsets.only(left: 8),
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
                                      padding: const EdgeInsets.only(left: 8.0),
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
              ),
        /*CustomDropDownField(
                value: panthDropDownValue,
                validator: (value) {
                  if (value == null) {
                    return "Please select panth";
                  }
                  return null;
                },
                items: panthController.panthList.map((items) {
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
                  panthDropDownValue = value;
                  for (int i = 0; i < panthController.panthList.length; i++) {
                    if (value == panthController.panthList[i].name) {
                      panthId = panthController.panthList[i].id.toString();
                      print("this is panthId =======> ${panthId}");
                    }
                  }
                  setState(() {});
                },
                labelText: "Select your Panth",
              ),*/
      ),
    );
  }

  Padding phoneField() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.035),
      child: CustomTextFormField(
        controller: phoneNumberController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value.isEmpty) {
            return "*Invalid Phone Number.";
          }
          return null;
        },
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        ],
        prefix: Text(
          "+91",
          style: poppinsRegular.copyWith(
            fontSize: Get.width * 0.04,
            color: ThemeManager().getBlackColor,
          ),
        ),
        labelText: "Phone Number",
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

  Padding nameField() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.035),
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
    );
  }

  Stack avtarUpload() {
    return Stack(
      children: [
        Container(
          height: Get.width * 0.32,
          width: Get.width * 0.32,
          margin: EdgeInsets.only(top: Get.height * 0.05),
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
                  )) : uploadedImage != null ?  Image.network(uploadedImage!)
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: Get.width * 0.065,
                                    color: ThemeManager().getBlackColor,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.035),
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
                                padding:
                                    EdgeInsets.only(top: Get.height * 0.02),
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
                child: Image.asset("assets/icon/image_picker.png"))),
      ],
    );
  }

  Padding relationShipField() {
    return Padding(
      padding: EdgeInsets.only(
        top: Get.height * 0.03,
      ),
      child: Obx(() => relationShipController.isLoading.value == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: ThemeManager().getThemeGreenColor,
                  ),
                )
              : CustomDropDownField2(
                  controller: relationDropDownValue,
                  validator: (value) {
                    if (value == null) {
                      return "*Please Select RelationShip.";
                    }
                    return null;
                  },
                  labelText: "Select your Relationship",
                  dropDownOnTap: () {
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
                                      controller: searchRelationController,
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
                                        relationShipController.relationShipList
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
                                              : relationShipController
                                                  .relationShipList,
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
                        relationDropDownValue.text = searchList.isNotEmpty
                            ? searchList[value].name
                            : relationShipController
                                .relationShipList[value].name;
                        relationId = searchList.isNotEmpty
                            ? searchList[value].id.toString()
                            : relationShipController.relationShipList[value].id
                                .toString();
                      }
                      print("object ==> $value");
                    });
                  },
                )
          ),
    );
  }

  Padding aboutField() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.035),
      child: CustomTextFormField(
        controller: aboutController,
        keyboardType: TextInputType.text,
        labelText: "About",
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

  Padding dateOfBirthField(BuildContext context) {
    return Padding(
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
    );
  }

  Padding educationField() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.035),
      child: CustomTextFormField(
        controller: educationController,
        keyboardType: TextInputType.text,
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
    );
  }

  Padding allowMatrimonyCheckBox() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.035),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.8,
            child: Checkbox(
                activeColor: ThemeManager().getThemeGreenColor,
                value: allowMatrimony,
                onChanged: (value) {
                  allowMatrimony = value!;
                  setState(() {});
                }),
          ),
          Padding(
            padding: EdgeInsets.only(left: Get.width * 0.025),
            child: Text(
              "Allow Matrimony",
              style: poppinsRegular.copyWith(
                fontSize: Get.width * 0.04,
                color: ThemeManager().getBlackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container addMemberButton() {
    return Container(
      width: Get.width,
      height: Get.height * 0.06,
      margin: EdgeInsets.symmetric(vertical: Get.height * 0.035),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var dataBody = {
              "avtar_url": _pickedImage?.path,
              "name": fullNameController.text,
              "phone_no": phoneNumberController.text,
              "panth_id": panthId,
              "gender": genderDropDownValue == "Male" ? "1" : "2",
              //  List statusList = ["Married", "Unmarried","Expired","Divorce"];
              "status_id": statusDropDownValue == "Married"
                  ? "1"
                  : statusDropDownValue == "Unmarried"
                      ? "2"
                      : statusDropDownValue == "Expired"
                          ? "3"
                          : "4",
              "date_of_anniversary": anniversaryController.text,
              "date_of_expire": expiredController.text,
              "time_of_birth": "${birthTime?.hour}:${birthTime?.minute}",
              "birth_place": birthPlaceController.text,
              "relationship_id": relationId,
              "about": aboutController.text,
              "date_of_birth": dobController.text,
              "education": educationController.text,
              "blood_group_id": bloodGroupId,
              "allow_matrimony": allowMatrimony == true ? "1" : "0",

              "naniyal_gautra_id": surNameId
            };
            print("dataBody ==> $dataBody");
            apiServices.addFamilyOrMatrimonyData(dataBody).then((value) {
              if (value != null) {
                Get.off(const ListFamilyMemberScreen());
              }
            });
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeManager().getThemeGreenColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          "Add member",
          style: poppinsSemiBold.copyWith(
            fontSize: Get.width * 0.04,
            color: ThemeManager().getWhiteColor,
          ),
        ),
      ),
    );
  }

  Padding gautraField() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.035),
      child: Obx(
        () => surNameController.isLoading.value == true
            ? Center(
                child: CircularProgressIndicator(
                  color: ThemeManager().getThemeGreenColor,
                ),
              )
            : CustomDropDownField2(
                controller: surNameDropDownValue,
                validator: (value) {
                  if (value == null) {
                    return "*Please Naniyal Gautra.";
                  }
                  return null;
                },
                labelText: "Select your Naniyal Gautra",
                dropDownOnTap: () {
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
                                      contentPadding: EdgeInsets.only(left: 8),
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
                                      padding: const EdgeInsets.only(left: 8.0),
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
                          : surNameController.surnameList[value].id.toString();
                    }
                    print("object ==> $value");
                  });
                },
              ), /*CustomDropDownField(
                value: surNameDropDownValue,
                validator: (value) {
                  if (value == null) {
                    return "*Please select surname.";
                  }
                  return null;
                },
                items: surNameController.surnameList.map((items) {
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
                  surNameDropDownValue = value;
                  for (int i = 0;
                      i < surNameController.surnameList.length;
                      i++) {
                    if (value == surNameController.surnameList[i].name) {
                      surNameId =
                          surNameController.surnameList[i].id.toString();

                      print(surNameId);
                    }
                  }
                  setState(() {});
                },
                labelText: "Select your Surname",
              ),*/
      ),
    );
  }

  Padding bloodGroupField() {
    return Padding(
      padding: EdgeInsets.only(
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
                  for (int i = 0;
                      i < bloodGroupController.bloodGroupList.length;
                      i++) {
                    if (value == bloodGroupController.bloodGroupList[i].name) {
                      bloodGroupId =
                          bloodGroupController.bloodGroupList[i].id.toString();
                    }
                  }
                  setState(() {});
                },
                labelText: "Select your BloodGroup",
              ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
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
        "Add Family Member",
        style: poppinsSemiBold.copyWith(
          fontSize: Get.width * 0.05,
          color: ThemeManager().getBlackColor,
        ),
      ),
    );
  }
}
