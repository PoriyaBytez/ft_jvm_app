import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jym_app/screens/drawer/add_family_members_screen.dart';
import 'package:jym_app/services/api_services.dart';
import 'package:jym_app/utils/app_textstyle.dart';
import 'package:jym_app/utils/theme_manager.dart';

import 'editProfile_screen.dart';

class ListFamilyMemberScreen extends StatefulWidget {
  const ListFamilyMemberScreen({Key? key}) : super(key: key);

  @override
  State<ListFamilyMemberScreen> createState() => _ListFamilyMemberScreenState();
}

class _ListFamilyMemberScreenState extends State<ListFamilyMemberScreen> {
  TextEditingController searchController = TextEditingController();

  APIServices apiServices = APIServices();
  List familyMembersList = [];
  bool isLoading = false;
  List<dynamic> searchList = [];
  listFamilyMemberApiCall() async {
    isLoading = true;
    familyMembersList.clear();
    var data = await apiServices.getFamilyMember();
    familyMembersList.addAll(data);
    if (kDebugMode) {
      print(familyMembersList);
    }
    isLoading = false;
    setState(() {});
  }

  //this is app bar for family member list
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
        "Family Members",
        style: poppinsSemiBold.copyWith(
          fontSize: Get.width * 0.05,
          color: ThemeManager().getBlackColor,
        ),
      ),
    );
  }

  //this is textfield for search
  TextFormField buildTextFormField() {
    return TextFormField(
      controller: searchController,
      style: poppinsRegular.copyWith(
        fontSize: Get.width * 0.04,
        color: ThemeManager().getBlackColor,
      ),
      keyboardType: TextInputType.text,
      onChanged: (value) {
        searchList.clear();
        if (value.isEmpty) {
          setState(() {});
          return;
        }
        familyMembersList.forEach((userDetail) {
          if (userDetail.name.toString().toLowerCase().startsWith(value.toLowerCase()) ||
              userDetail.name.toString().toUpperCase().startsWith(value.toUpperCase())) {
            searchList.add(userDetail);
          }
        });
        setState(() {});
      },
      decoration: InputDecoration(
        hintText: "Search for members",
        hintStyle: poppinsRegular.copyWith(
            fontSize: Get.width * 0.04,
            color: ThemeManager().getLightGreyColor),
        contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.015),
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
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    listFamilyMemberApiCall();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.off(AddFamilyMemberScreen());
        },
        backgroundColor: ThemeManager().getThemeGreenColor,
        child: Icon(Icons.add),
      ),
      appBar: buildAppBar(),
      body: Container(
        width: Get.width,
        height: Get.height,
        color: ThemeManager().getWhiteColor,
        alignment: Alignment.center,
        child:Column(
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
                      child: buildTextFormField(),
                    ),
                  ),
                  Expanded(
                    child:  isLoading == true
                        ? Center(
                          child: CircularProgressIndicator(
                      color: ThemeManager().getThemeGreenColor,
                    ),
                        )
                        : familyMembersList.isEmpty
                        ? const Center(
                            child: Text("No family member yet"),
                          )
                        : ListView.separated(
                            itemCount: searchController.text.isNotEmpty ? searchList.length : familyMembersList.length,
                            padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.05,
                              vertical: Get.height * 0.025,
                            ),
                            separatorBuilder: (context, index) {
                              return SizedBox(height: Get.height * 0.02);
                            },
                            itemBuilder: (context, index) {
                              var memberList = searchController.text.isNotEmpty ? searchList[index] : familyMembersList[index];
                              print("image url ==> ${memberList.avtar}");
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => AddFamilyMemberScreen(memberList: memberList));
                                },
                                child: Container(
                                  color: ThemeManager().getWhiteColor,
                                  child: Row(
                                    children: [
                                      // (memberList.avtar==null)?
                                      // const Icon(
                                      //   Icons.account_circle,
                                      //   size: 65,color: Colors.black,
                                      // ) : Image.network("https://jymnew.spitel.com/${memberList.avtar}"),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.05),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              memberList.name,
                                              style: poppinsMedium.copyWith(
                                                fontSize: Get.width * 0.035,
                                                color: ThemeManager()
                                                    .getBlackColor,
                                              ),
                                            ),
                                            Text(
                                              memberList.phoneNo,
                                              style: poppinsMedium.copyWith(
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
