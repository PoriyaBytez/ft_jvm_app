import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jym_app/models/get_user_model.dart';
import 'package:jym_app/screens/drawer/about_us_screen.dart';
import 'package:jym_app/screens/drawer/add_family_members_screen.dart';
import 'package:jym_app/screens/drawer/list_family_member_screen.dart';
import 'package:jym_app/screens/splash_screen.dart';
import 'package:jym_app/services/api_services.dart';
import 'package:jym_app/utils/app_textstyle.dart';
import 'package:jym_app/utils/preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import '../common_widgets/custom_textformfield.dart';
import '../controller/home_screen_controller/advertisement_controller.dart';
import '../controller/home_screen_controller/calendar_controller.dart';
import '../controller/verification_controller/city_controller.dart';
import '../controller/verification_controller/surname_controller.dart';
import '../models/home_screen_model/calendar_model.dart';
import '../utils/theme_manager.dart';
import 'drawer/editProfile_screen.dart';
import 'home_screen/home_screen.dart';
import 'matrimony_screen/matrimony_screen.dart';
import 'members_screen/members_screen.dart';
import 'news_screen/news_screen.dart';
import 'notification_screen/notification_screen.dart';
import 'onboarding_screen.dart';
import 'utilities_screen/utilties_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController searchController = TextEditingController();
  // WidgetsToImageController to access widget
  WidgetsToImageController controller = WidgetsToImageController();
  int bottomNavigationIndex = 0;
  // RxBool crossButton = false.obs;
  final Preferences _preferences = Preferences();
  dynamic widthInfinity = Container(height: 1,width: double.infinity,color: Colors.white);
  dynamic heightInfinity = Container(height: 10,width: .5,color: Colors.white);
  final surnameController = Get.put(SurnameController());
      List bottomNavigationList = [
    {
      "name": "Home",
      "selectedIcon": "assets/icon/home_selected.png",
      "unSelectedIcon": "assets/icon/home_selected.png",
    },
    {
      "name": "News",
      "selectedIcon": "assets/icon/news.png",
      "unSelectedIcon": "assets/icon/news.png",
    },
    {
      "name": "Members",
      "selectedIcon": "assets/icon/members.png",
      "unSelectedIcon": "assets/icon/members.png",
    },
    {
      "name": "Utilities",
      "selectedIcon": "assets/icon/utilities.png",
      "unSelectedIcon": "assets/icon/utilities.png",
    },
    {
      "name": "Matrimony",
      "selectedIcon": "assets/icon/matrimony.png",
      "unSelectedIcon": "assets/icon/matrimony.png",
    },
  ];
  List locationList = [
    {"locationName": "Ahmedabad", "isSelected": true},
    {"locationName": "Ahmedabad", "isSelected": false},
    {"locationName": "Ahmedabad", "isSelected": false},
    {"locationName": "Ahmedabad", "isSelected": false},
    {"locationName": "Ahmedabad", "isSelected": false},
    {"locationName": "Ahmedabad", "isSelected": false},
    {"locationName": "Ahmedabad", "isSelected": false},
    {"locationName": "Ahmedabad", "isSelected": false},
    {"locationName": "Ahmedabad", "isSelected": false},
  ];
  List drawerList = [
    {
      "drawerIcon": "assets/icon/members.png",
      "menuName": "Manage Members",
      "menuScreen": const ListFamilyMemberScreen(),
    },
    {
      "drawerIcon": "assets/icon/website.png",
      "menuName": "Website",
      "menuScreen": "",
    },
    {
      "drawerIcon": "assets/icon/about_us.png",
      "menuName": "About us",
      "menuScreen": const AboutUsScreen(),
    },
    {
      "drawerIcon": "assets/icon/rate_app.png",
      "menuName": "Rate App",
      "menuScreen": "",
    },
    {
      "drawerIcon": "assets/icon/share_app.png",
      "menuName": "Share App",
      "menuScreen": "",
    },
  ];
  List bottomNavigationPages = const [
    HomeScreen(),
    NewsScreen(),
    MembersScreen(),
    UtilitiesScreen(),
    MatrimonyScreen(),
  ];
  final _advancedDrawerController = AdvancedDrawerController();
  final advertisementController = AdvertisementController();
  final cityController = Get.put(CityController());
  final calendarController = Get.put(CalendarController());
  DateTime? pickedDate;
  String dateString =
      "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
  String surName = "";
  @override
  void initState() {
    dataForCalender();
    setState(() {

    });
    _preferences.getCityId() == ""
        ? _preferences.setCityId("603")
        : _preferences.getCityId();
    advertisementController
        .getAdvertisement({"slide": "", "city_id": _preferences.getCityId()});

    super.initState();
  }
Future<void> dataForCalender() async {
  await calendarController.getCalendar(dateString).then((value) {
    todayMuharatCalenderDialog();
  });
}
  todayMuharatCalenderDialog() {
    // add share button to dialog
    // show no calendar event dialog

    if (calendarController.calendarData != null &&
        calendarController.calendarData.res != null &&
        calendarController.calendarData.res.eventDateHindi != null) {
      Get.dialog(
          barrierDismissible: false,
          barrierColor: ThemeManager().getBlackColor.withOpacity(0.2), Obx(() {
        List dateSplit =
            calendarController.calendarData.res.eventDateHindi.split(" ");
        return calendarController.isLoading == true.obs
            ? Dialog(
                backgroundColor: ThemeManager().getWhiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                insetPadding: EdgeInsets.symmetric(
                    vertical: Get.height * 0.015, horizontal: Get.width * 0.05),
                child: Center(
                  child: CircularProgressIndicator(
                    color: ThemeManager().getThemeGreenColor,
                  ),
                ),
              )
            : Dialog(
                backgroundColor: ThemeManager().getWhiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                insetPadding: EdgeInsets.symmetric(
                    vertical: Get.height * 0.025, horizontal: Get.width * 0.05),
                child: Container(
                  decoration: BoxDecoration(color: ThemeManager().getWhiteColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05,
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        WidgetsToImage(
                          controller: controller,
                          child: Container(color: Colors.white,
                            child: Column(children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    dateSplit[0],
                                    style: poppinsRegular.copyWith(
                                      color: ThemeManager().getThemeGreenColor,
                                      fontSize: Get.width * 0.17,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${dateSplit[1]} ${dateSplit[2]}, ${calendarController.calendarData.res.eventDayHindi}",
                                          style: adobeDevnagariBold.copyWith(
                                            color: ThemeManager().getBlackColor,
                                            fontSize: Get.width * 0.05,
                                          ),
                                        ),
                                        Text(
                                          "${calendarController.calendarData.res.jainMonth} ${calendarController.calendarData.res.jainMonthNo}",
                                          style: adobeDevnagariBold.copyWith(
                                            color: ThemeManager().getThemeGreenColor,
                                            fontSize: Get.width * 0.05,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/image/splash_logo.png",
                                    width: Get.width * 0.12,
                                    height: Get.width * 0.12,
                                    fit: BoxFit.fill,
                                  ),
                                   Padding(
                                    padding: EdgeInsets.only(
                                      left: Get.width * 0.025,
                                      bottom: Get.height * 0.035,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Icon(
                                        Icons.close,
                                        size: Get.width * 0.06,
                                        color: ThemeManager().getThemeGreenColor,
                                    ),
                                  ))
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.05,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: Get.width * 0.15,
                                      child: Text(
                                        "वीर संवत\n${calendarController.calendarData.res.veerSanwat}",
                                        style: adobeDevnagariBold.copyWith(
                                          fontSize: Get.width * 0.04,
                                          color: ThemeManager().getBlackColor,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      height: double.maxFinite,
                                      width: 1.5,
                                      color: ThemeManager()
                                          .getLightGreyColor
                                          .withOpacity(0.2),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.15,
                                      child: Text(
                                        "विक्रम संवत\n${calendarController.calendarData.res.vikramSanwat}",
                                        style: adobeDevnagariBold.copyWith(
                                          fontSize: Get.width * 0.04,
                                          color: ThemeManager().getBlackColor,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      height: double.maxFinite,
                                      width: 1.5,
                                      color: ThemeManager()
                                          .getLightGreyColor
                                          .withOpacity(0.2),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.15,
                                      child: Text(
                                        "खरतर संवत\n${calendarController.calendarData.res.khartarSanwat}",
                                        style: adobeDevnagariBold.copyWith(
                                          fontSize: Get.width * 0.04,
                                          color: ThemeManager().getBlackColor,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      height: double.maxFinite,
                                      width: 1.5,
                                      color: ThemeManager()
                                          .getLightGreyColor
                                          .withOpacity(0.2),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.15,
                                      child: Text(
                                        "ईस्वी सन\n${calendarController.calendarData.res.isaviSanwat}",
                                        style: adobeDevnagariBold.copyWith(
                                          fontSize: Get.width * 0.04,
                                          color: ThemeManager().getBlackColor,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: Get.width * 0.9,
                                margin: EdgeInsets.only(top: Get.height * 0.02),
                                child: Text(
                                  calendarController.calendarData.res.thought,
                                  style: anekDevnagariMedium.copyWith(
                                    fontSize: Get.width * 0.045,
                                    color: ThemeManager().getThemeGreenColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${calendarController.calendarData.res.eventDayHindi} के शुभ समय",
                                      style: anekDevnagariSemiBold.copyWith(
                                        fontSize: Get.width * 0.05,
                                        color: ThemeManager().getBlackColor,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        pickedDate = (await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2023, 04),
                                          lastDate: DateTime(2100),
                                          builder: (context, child) {
                                            return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme: ColorScheme.light(
                                                  primary: ThemeManager()
                                                      .getThemeGreenColor,
                                                ),
                                              ),
                                              child: child!,
                                            );
                                          },
                                        ));
                                        if (pickedDate != null) {
                                          dateString = DateFormat('yyyy-MM-dd')
                                              .format(pickedDate!)
                                              .toString();
                                        }
                                        calendarController.getCalendar(dateString);
                                      },
                                      child: Container(
                                        width: Get.width * 0.09,
                                        height: Get.width * 0.09,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: ThemeManager()
                                              .getThemeGreenColor
                                              .withOpacity(0.05),
                                          borderRadius: BorderRadius.circular(7),
                                          border: Border.all(
                                            color: ThemeManager()
                                                .getThemeGreenColor
                                                .withOpacity(0.1),
                                          ),
                                        ),
                                        child: Image.asset(
                                          "assets/icon/dialog_calender.png",
                                          height: Get.width * 0.05,
                                          width: Get.width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              ///--------------Muharat Data Table-------------------

                              Container(
                                decoration: BoxDecoration(
                                  color: ThemeManager()
                                      .getGreyTableColor
                                      .withOpacity(0.2),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: Get.height * 0.045,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color:
                                                ThemeManager().getThemeGreenColor,
                                                borderRadius: const BorderRadius.only(
                                                    topLeft: Radius.circular(10))),
                                            child: Text(
                                              '',
                                              style: anekDevnagariBold.copyWith(
                                                fontSize: Get.width * 0.035,
                                                color: ThemeManager().getWhiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        heightInfinity,
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: Get.height * 0.045,
                                            alignment: Alignment.centerLeft,
                                            color: ThemeManager().getThemeGreenColor,
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Text(
                                              'दिन',
                                              style: anekDevnagariBold.copyWith(
                                                fontSize: Get.width * 0.035,
                                                color: ThemeManager().getWhiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        heightInfinity,
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: Get.height * 0.045,
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color:
                                                ThemeManager().getThemeGreenColor,
                                                borderRadius: const BorderRadius.only(
                                                    topRight: Radius.circular(10))),
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Text(
                                              'रात्रि',
                                              style: anekDevnagariBold.copyWith(
                                                fontSize: Get.width * 0.035,
                                                color: ThemeManager().getWhiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    widthInfinity,
                                    Column(
                                      children: [
                                        ///-------------Labh---------------

                                        Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  color: ThemeManager()
                                                      .getGreyTableColor
                                                      .withOpacity(0.2),
                                                  child: Text(
                                                    "लाभ",
                                                    style: anekDevnagariBold.copyWith(
                                                      fontSize: Get.width * 0.035,
                                                      color: ThemeManager()
                                                          .getBlackColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              heightInfinity,
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding:
                                                  const EdgeInsets.only(left: 10),
                                                  decoration: BoxDecoration(
                                                    color: ThemeManager()
                                                        .getGreyTableColor
                                                        .withOpacity(0.2),
                                                  ),
                                                  child: Text(
                                                    calendarController.calendarData
                                                        .res.laabhDayTime,
                                                    style:
                                                    anekDevnagariMedium.copyWith(
                                                      fontSize: Get.width * 0.035,
                                                      color: ThemeManager()
                                                          .getBlackColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              heightInfinity,
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding:
                                                  const EdgeInsets.only(left: 10),
                                                  decoration: BoxDecoration(
                                                    color: ThemeManager()
                                                        .getGreyTableColor
                                                        .withOpacity(0.2),
                                                  ),
                                                  child: Text(
                                                    calendarController.calendarData
                                                        .res.laabhNightTime,
                                                    style:
                                                    anekDevnagariMedium.copyWith(
                                                      fontSize: Get.width * 0.035,
                                                      color: ThemeManager()
                                                          .getBlackColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]),

                                        ///-------------Amrut---------------
                                        widthInfinity,
                                        Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  color: ThemeManager()
                                                      .getGreyTableColor
                                                      .withOpacity(0.2),
                                                  child: Text(
                                                    "अमृत",
                                                    style: anekDevnagariBold.copyWith(
                                                      fontSize: Get.width * 0.035,
                                                      color: ThemeManager()
                                                          .getBlackColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              heightInfinity,
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding:
                                                  const EdgeInsets.only(left: 10),
                                                  decoration: BoxDecoration(
                                                    color: ThemeManager()
                                                        .getGreyTableColor
                                                        .withOpacity(0.2),
                                                  ),
                                                  child: Text(
                                                    calendarController.calendarData
                                                        .res.amritDayTime,
                                                    style:
                                                    anekDevnagariMedium.copyWith(
                                                      fontSize: Get.width * 0.035,
                                                      color: ThemeManager()
                                                          .getBlackColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              heightInfinity,
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding:
                                                  const EdgeInsets.only(left: 10),
                                                  decoration: BoxDecoration(
                                                    color: ThemeManager()
                                                        .getGreyTableColor
                                                        .withOpacity(0.2),
                                                  ),
                                                  child: Text(
                                                    calendarController.calendarData
                                                        .res.amritNightTime,
                                                    style:
                                                    anekDevnagariMedium.copyWith(
                                                      fontSize: Get.width * 0.035,
                                                      color: ThemeManager()
                                                          .getBlackColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]),

                                        ///-------------Shubh---------------
                                        widthInfinity,
                                        Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  color: ThemeManager()
                                                      .getGreyTableColor
                                                      .withOpacity(0.2),
                                                  child: Text(
                                                    "शुभ",
                                                    style: anekDevnagariBold.copyWith(
                                                      fontSize: Get.width * 0.035,
                                                      color: ThemeManager()
                                                          .getBlackColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              heightInfinity,
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding:
                                                  const EdgeInsets.only(left: 10),
                                                  decoration: BoxDecoration(
                                                    color: ThemeManager()
                                                        .getGreyTableColor
                                                        .withOpacity(0.2),
                                                  ),
                                                  child: Text(
                                                    calendarController.calendarData
                                                        .res.shubhDayTime,
                                                    style:
                                                    anekDevnagariMedium.copyWith(
                                                      fontSize: Get.width * 0.035,
                                                      color: ThemeManager()
                                                          .getBlackColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              heightInfinity,
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding:
                                                  const EdgeInsets.only(left: 10),
                                                  decoration: BoxDecoration(
                                                    color: ThemeManager()
                                                        .getGreyTableColor
                                                        .withOpacity(0.2),
                                                  ),
                                                  child: Text(
                                                    calendarController.calendarData
                                                        .res.shubhNightTime,
                                                    style:
                                                    anekDevnagariMedium.copyWith(
                                                      fontSize: Get.width * 0.035,
                                                      color: ThemeManager()
                                                          .getBlackColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]),

                                        ///-------------Chanchal---------------
                                        widthInfinity,
                                        Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: ThemeManager()
                                                          .getGreyTableColor
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                      const BorderRadius.only(
                                                          bottomLeft:
                                                          Radius.circular(
                                                              10))),
                                                  child: Text(
                                                    "चंचल",
                                                    style: anekDevnagariBold.copyWith(
                                                      fontSize: Get.width * 0.035,
                                                      color: ThemeManager()
                                                          .getBlackColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              heightInfinity,
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding:
                                                  const EdgeInsets.only(left: 10),
                                                  decoration: BoxDecoration(
                                                    color: ThemeManager()
                                                        .getGreyTableColor
                                                        .withOpacity(0.2),
                                                  ),
                                                  child: Text(
                                                    calendarController.calendarData
                                                        .res.chanchalDayTime,
                                                    style:
                                                    anekDevnagariMedium.copyWith(
                                                      fontSize: Get.width * 0.035,
                                                      color: ThemeManager()
                                                          .getBlackColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              heightInfinity,
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding:
                                                  const EdgeInsets.only(left: 10),
                                                  decoration: BoxDecoration(
                                                    color: ThemeManager()
                                                        .getGreyTableColor
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                        bottomRight:
                                                        Radius.circular(10)),
                                                  ),
                                                  child: Text(
                                                    calendarController.calendarData
                                                        .res.chanchalNightTime,
                                                    style:
                                                    anekDevnagariMedium.copyWith(
                                                      fontSize: Get.width * 0.035,
                                                      color: ThemeManager()
                                                          .getBlackColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              ///--------------City Time weather Data Table-------------------

                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: Get.height * 0.045,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: ThemeManager().getThemeGreenColor,
                                            borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(10))),
                                        child: Text(
                                          calendarController.calendarData.res.city1,
                                          style: anekDevnagariBold.copyWith(
                                            fontSize: Get.width * 0.035,
                                            color: ThemeManager().getWhiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    heightInfinity,
                                    Expanded(
                                      child: Container(
                                        height: Get.height * 0.045,
                                        alignment: Alignment.center,
                                        color: ThemeManager().getThemeGreenColor,
                                        child: Text(
                                          calendarController.calendarData.res.city2,
                                          style: anekDevnagariBold.copyWith(
                                            fontSize: Get.width * 0.035,
                                            color: ThemeManager().getWhiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    heightInfinity,
                                    Expanded(
                                      child: Container(
                                        height: Get.height * 0.045,
                                        alignment: Alignment.center,
                                        color: ThemeManager().getThemeGreenColor,
                                        child: Text(
                                          calendarController.calendarData.res.city3,
                                          style: anekDevnagariBold.copyWith(
                                            fontSize: Get.width * 0.035,
                                            color: ThemeManager().getWhiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    heightInfinity,
                                    Expanded(
                                      child: Container(
                                        height: Get.height * 0.045,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: ThemeManager().getThemeGreenColor,
                                            borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(10))),
                                        child: Text(
                                          calendarController.calendarData.res.city4,
                                          style: anekDevnagariBold.copyWith(
                                            fontSize: Get.width * 0.035,
                                            color: ThemeManager().getWhiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ///-------------SunRise---------------
                              widthInfinity,

                              Row(children: [
                                Expanded(
                                  child: Container(
                                    height: Get.height * 0.045,
                                    alignment: Alignment.centerLeft,
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      color: ThemeManager()
                                          .getGreyTableColor
                                          .withOpacity(0.2),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Image.asset(
                                            "assets/icon/sun_rise.png",
                                            scale: 2.7,
                                          ),
                                        ),
                                        Expanded(flex: 3,
                                          child: Text(
                                            calendarController
                                                .calendarData.res.sunrise1,
                                            style: anekDevnagariMedium.copyWith(
                                              fontSize: Get.width * 0.035,
                                              color: ThemeManager().getBlackColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                heightInfinity,
                                Expanded(
                                  child: Container(
                                    height: Get.height * 0.045,
                                    alignment: Alignment.centerLeft,
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      color: ThemeManager()
                                          .getGreyTableColor
                                          .withOpacity(0.2),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Image.asset(
                                            "assets/icon/sun_rise.png",
                                            scale: 2.7,
                                          ),
                                        ),
                                        Expanded(flex: 3,
                                          child: Text(
                                            calendarController
                                                .calendarData.res.sunrise2,
                                            style: anekDevnagariMedium.copyWith(
                                              fontSize: Get.width * 0.035,
                                              color: ThemeManager().getBlackColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                heightInfinity,
                                Expanded(
                                  child: Container(
                                    height: Get.height * 0.045,
                                    alignment: Alignment.centerLeft,
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      color: ThemeManager()
                                          .getGreyTableColor
                                          .withOpacity(0.2),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Image.asset(
                                            "assets/icon/sun_rise.png",
                                            scale: 2.7,
                                          ),
                                        ),
                                        Expanded(flex: 3,
                                          child: Text(
                                            calendarController
                                                .calendarData.res.sunrise3,
                                            style: anekDevnagariMedium.copyWith(
                                              fontSize: Get.width * 0.035,
                                              color: ThemeManager().getBlackColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                heightInfinity,
                                Expanded(
                                  child: Container(
                                    height: Get.height * 0.045,
                                    alignment: Alignment.centerLeft,
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      color: ThemeManager()
                                          .getGreyTableColor
                                          .withOpacity(0.2),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Image.asset(
                                            "assets/icon/sun_rise.png",
                                            scale: 2.7,
                                          ),
                                        ),
                                        Expanded(flex: 3,
                                          child: Text(
                                            calendarController
                                                .calendarData.res.sunrise4,
                                            style: anekDevnagariMedium.copyWith(
                                              fontSize: Get.width * 0.035,
                                              color: ThemeManager().getBlackColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),

                              ///-------------SunSet---------------
                              widthInfinity,
                              Row(children: [
                                Expanded(
                                  child: Container(
                                    height: Get.height * 0.045,
                                    alignment: Alignment.centerLeft,
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10)),
                                      color: ThemeManager()
                                          .getGreyTableColor
                                          .withOpacity(0.2),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Image.asset(
                                            "assets/icon/sun_set.png",
                                            scale: 2.7,
                                          ),
                                        ),
                                        Expanded(flex: 3,
                                          child: Text(
                                            calendarController.calendarData.res.sunset1,
                                            style: anekDevnagariMedium.copyWith(
                                              fontSize: Get.width * 0.035,
                                              color: ThemeManager().getBlackColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                heightInfinity,
                                Expanded(
                                  child: Container(
                                    height: Get.height * 0.045,
                                    alignment: Alignment.centerLeft,
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      color: ThemeManager()
                                          .getGreyTableColor
                                          .withOpacity(0.2),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Image.asset(
                                            "assets/icon/sun_set.png",
                                            scale: 2.7,
                                          ),
                                        ),
                                        Expanded(flex: 3,
                                          child: Text(
                                            calendarController.calendarData.res.sunset2,
                                            style: anekDevnagariMedium.copyWith(
                                              fontSize: Get.width * 0.035,
                                              color: ThemeManager().getBlackColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                heightInfinity,
                                Expanded(
                                  child: Container(
                                    height: Get.height * 0.045,
                                    alignment: Alignment.centerLeft,
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      color: ThemeManager()
                                          .getGreyTableColor
                                          .withOpacity(0.2),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Image.asset(
                                            "assets/icon/sun_set.png",
                                            scale: 2.7,
                                          ),
                                        ),
                                        Expanded(flex: 3,
                                          child: Text(
                                            calendarController.calendarData.res.sunset3,
                                            style: anekDevnagariMedium.copyWith(
                                              fontSize: Get.width * 0.035,
                                              color: ThemeManager().getBlackColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                heightInfinity,
                                Expanded(
                                  child: Container(
                                    height: Get.height * 0.045,
                                    alignment: Alignment.centerLeft,
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
                                      color: ThemeManager()
                                          .getGreyTableColor
                                          .withOpacity(0.2),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Image.asset(
                                            "assets/icon/sun_set.png",
                                            scale: 2.7,
                                          ),
                                        ),
                                        Expanded(flex: 3,
                                          child: Text(
                                            calendarController.calendarData.res.sunset4,
                                            style: anekDevnagariMedium.copyWith(
                                              fontSize: Get.width * 0.035,
                                              color: ThemeManager().getBlackColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),

                              ///-------------City---------------
                              /*widthInfinity,
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: Get.height * 0.045,
                                      alignment: Alignment.center,
                                      color: ThemeManager().getThemeGreenColor,
                                      child: Text(
                                        calendarController.calendarData.res.city5,
                                        style: anekDevnagariBold.copyWith(
                                          fontSize: Get.width * 0.035,
                                          color: ThemeManager().getWhiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  heightInfinity,
                                  Expanded(
                                    child: Container(
                                      height: Get.height * 0.045,
                                      alignment: Alignment.center,
                                      color: ThemeManager().getThemeGreenColor,
                                      child: Text(
                                        calendarController.calendarData.res.city6,
                                        style: anekDevnagariBold.copyWith(
                                          fontSize: Get.width * 0.035,
                                          color: ThemeManager().getWhiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  heightInfinity,
                                  const Expanded(child: SizedBox()),
                                  const Expanded(child: SizedBox()),
                                ],
                              ),

                              ///-------------SunRise---------------

                              Row(children: [
                                Expanded(
                                  child: Container(
                                    height: Get.height * 0.045,
                                    alignment: Alignment.centerLeft,
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      color: ThemeManager()
                                          .getGreyTableColor
                                          .withOpacity(0.2),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Image.asset(
                                            "assets/icon/sun_rise.png",
                                            scale: 2.7,
                                          ),
                                        ),
                                        Expanded(flex: 3,
                                          child: Text(
                                            calendarController
                                                .calendarData.res.sunrise5,
                                            style: anekDevnagariMedium.copyWith(
                                              fontSize: Get.width * 0.035,
                                              color: ThemeManager().getBlackColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                heightInfinity,
                                Expanded(
                                  child: Container(
                                    height: Get.height * 0.045,
                                    alignment: Alignment.centerLeft,
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      color: ThemeManager()
                                          .getGreyTableColor
                                          .withOpacity(0.2),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Image.asset(
                                            "assets/icon/sun_rise.png",
                                            scale: 2.7,
                                          ),
                                        ),
                                        Expanded(flex: 3,
                                          child: Text(
                                            calendarController
                                                .calendarData.res.sunrise6,
                                            style: anekDevnagariMedium.copyWith(
                                              fontSize: Get.width * 0.035,
                                              color: ThemeManager().getBlackColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                heightInfinity,
                                const Expanded(child: SizedBox()),
                                const Expanded(child: SizedBox()),
                              ]),

                              ///-------------SunSet---------------
                              widthInfinity,
                              Row(children: [
                                Expanded(
                                  child: Container(
                                    height: Get.height * 0.045,
                                    alignment: Alignment.centerLeft,
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                        color: ThemeManager()
                                            .getGreyTableColor
                                            .withOpacity(0.2),
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(10))),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Image.asset(
                                            "assets/icon/sun_set.png",
                                            scale: 2.7,
                                          ),
                                        ),
                                        Expanded(flex: 3,
                                          child: Text(
                                            calendarController.calendarData.res.sunset5,
                                            style: anekDevnagariMedium.copyWith(
                                              fontSize: Get.width * 0.035,
                                              color: ThemeManager().getBlackColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                heightInfinity,
                                Expanded(
                                  child: Container(
                                    height: Get.height * 0.045,
                                    alignment: Alignment.centerLeft,
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                        color: ThemeManager()
                                            .getGreyTableColor
                                            .withOpacity(0.2),
                                        borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(10))),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Image.asset(
                                            "assets/icon/sun_set.png",
                                            scale: 2.7,
                                          ),
                                        ),
                                        Expanded(flex: 3,
                                          child: Text(
                                            calendarController.calendarData.res.sunset6,
                                            style: anekDevnagariMedium.copyWith(
                                              fontSize: Get.width * 0.035,
                                              color: ThemeManager().getBlackColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                heightInfinity,
                                const Expanded(child: SizedBox()),
                                const Expanded(child: SizedBox()),
                              ]),*/

                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text("JYM Jain Sangh",
                                    style: anekDevnagariSemiBold.copyWith(
                                        fontSize: Get.width * 0.03,
                                        color: ThemeManager().getBlackColor)),
                              ),
                            ]),
                          ),
                        ),

                        InkWell(onTap: () async {
                            // crossButton.value = true;
                          Uint8List? bytes = await controller.capture();
                          final tempDir = await getTemporaryDirectory();
                          File file = await File('${tempDir.path}/image.png').create();
                          file.writeAsBytesSync(bytes!);
                          List<String> shareImage = [];
                          shareImage.add(file.path);
                          Share.shareFiles(shareImage);
                            // crossButton.value = false;
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Get.height * 0.008,
                                horizontal: Get.width * 0.07),
                            decoration: BoxDecoration(
                              color: ThemeManager().getThemeGreenColor,
                              borderRadius:
                                  BorderRadius.circular(Get.width * 0.015),
                            ),
                            child: Text(
                              "Share",
                              style: poppinsRegular.copyWith(
                                color: ThemeManager().getWhiteColor,
                                fontSize: Get.width * 0.035,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.025,
                        )
                      ],
                    ),
                  ),
                ),
              );
      }));
    } else {
      Get.dialog(
          barrierDismissible: false,
          barrierColor: ThemeManager().getBlackColor.withOpacity(0.2),
          Dialog(
            backgroundColor: ThemeManager().getWhiteColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            insetPadding: EdgeInsets.symmetric(
                vertical: Get.height * 0.025, horizontal: Get.width * 0.05),
            child: Container(
              height: Get.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.05, vertical: Get.height * 0.02),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Expanded(child: SizedBox.shrink()),
                      Padding(
                        padding: EdgeInsets.only(
                          left: Get.width * 0.025,
                          bottom: Get.height * 0.035,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.close,
                            size: Get.width * 0.06,
                            color: ThemeManager().getThemeGreenColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No calendar event found for today!",
                          style: adobeDevnagariBold.copyWith(
                            fontSize: Get.width * 0.04,
                            color: ThemeManager().getBlackColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    for (var element in surnameController.surnameList) {
      if(element.id.toString() == editProfileModel.surnameId){
        surName = element.name;
        break;
      }
    }
    return AdvancedDrawer(
      controller: _advancedDrawerController,
      drawer: SafeArea(
        child: Container(
          color: ThemeManager().getWhiteColor,
          child: Column(
            children: [
              ///-----------------Profile photo-----------------

              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.025),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: (editProfileModel.avtarUrl == null)
                      ? const Icon(
                          Icons.account_circle,
                          size: 130,
                        )
                      : Image.network(
                          "https://jymnew.spitel.com${editProfileModel.avtarUrl}",
                          height: Get.width * 0.25,
                          width: Get.width * 0.25,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.015),
                child: Text(
                  "${editProfileModel.firstName} $surName",
                  style: poppinsSemiBold.copyWith(
                    fontSize: Get.width * 0.045,
                    color: ThemeManager().getBlackColor,
                  ),
                ),
              ),

              ///-----------------Edit Profile-----------------

              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreen()));
                },
                child: Container(
                  width: Get.width * 0.27,
                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.0075),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:
                          ThemeManager().getThemeGreenColor.withOpacity(0.1)),
                  margin: EdgeInsets.only(top: Get.height * 0.015),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icon/Pen.png",
                        height: Get.height * 0.025,
                        fit: BoxFit.fill,
                      ),
                      Text("Edit Profile",
                          style: poppinsMedium.copyWith(
                            fontSize: Get.width * 0.035,
                            color: ThemeManager().getThemeGreenColor,
                          ))
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.015),
                child: Divider(
                  thickness: 2,
                  color: ThemeManager().getThemeGreenColor.withOpacity(0.3),
                  indent: Get.width * 0.075,
                  endIndent: Get.width * 0.075,
                ),
              ),

              ///-----------------Option List-----------------

              ListView.separated(
                  shrinkWrap: true,
                  itemCount: drawerList.length,
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05,
                    vertical: Get.height * 0.025,
                  ),
                  separatorBuilder: (context, index) {
                    return SizedBox(height: Get.height * 0.02);
                  },
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (drawerList[index]["menuScreen"] != "") {
                          // Get.to(()=>drawerList[index]["menuScreen"]);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      drawerList[index]["menuScreen"]));
                        }
                      },
                      child: Container(
                        color: ThemeManager().getWhiteColor,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                drawerList[index]["drawerIcon"],
                                height: Get.width * 0.075,
                                width: Get.width * 0.075,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: Get.width * 0.05),
                              child: Text(
                                drawerList[index]["menuName"],
                                style: poppinsMedium.copyWith(
                                  fontSize: Get.width * 0.04,
                                  color: ThemeManager().getLightGreyColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

              const Spacer(),

              ///-----------------LogOut-----------------

              GestureDetector(
                onTap: () {
                  Preferences().clear();
                  Get.offAll(() => const OnBoardingScreen());
                },
                child: Container(
                  width: Get.width * 0.4,
                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
                  margin: EdgeInsets.only(bottom: Get.height * 0.05),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ThemeManager().getRedColor.withOpacity(0.1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icon/logout.png",
                        height: Get.height * 0.03,
                        fit: BoxFit.fill,
                      ),
                      Text(
                        "Logout",
                        style: poppinsMedium.copyWith(
                          fontSize: Get.width * 0.035,
                          color: ThemeManager().getRedColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leadingWidth: Get.width * 0.4,
          leading: Padding(
            padding: EdgeInsets.only(left: Get.width * 0.025),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      _advancedDrawerController.showDrawer();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: Get.width * 0.011),
                      child: Icon(
                        Icons.menu,
                        size: Get.width * 0.07,
                        color: ThemeManager().getBlackColor,
                      ),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "City",
                      style: poppinsRegular.copyWith(
                        fontSize: Get.width * 0.04,
                        color: ThemeManager().getLightGreyColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        cityController.searchCityResultList =
                            cityController.cityList;
                        Get.dialog(
                          Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            insetPadding: EdgeInsets.symmetric(
                              vertical: Get.height * 0.05,
                            ),
                            backgroundColor: ThemeManager().getWhiteColor,
                            child: Container(
                              width: Get.width * 0.9,
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.05),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: Get.height * 0.025,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Select a location",
                                          style: poppinsSemiBold.copyWith(
                                              color: ThemeManager()
                                                  .getThemeGreenColor,
                                              fontSize: Get.width * 0.065),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Icon(
                                            Icons.close,
                                            size: Get.width * 0.075,
                                            color: ThemeManager()
                                                .getThemeGreenColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: Get.height * 0.02),
                                    child: CustomTextFormField(
                                      controller: searchController,
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {
                                        if (cityController
                                            .searchCityResultList.isNotEmpty) {
                                          cityController.searchCityResultList =
                                              [].obs;
                                          cityController.searchCityResultList
                                              .addAll(cityController.cityList
                                                  .where((e) => e.name
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains(value
                                                          .trim()
                                                          .toString()
                                                          .toLowerCase()) /* && e.city.startsWith(value.trim())*/)
                                                  .toList());
                                        } else {
                                          cityController.searchCityResultList =
                                              cityController.cityList;
                                        }
                                        cityController.update();
                                        Get.forceAppUpdate();
                                        setState(() {});
                                      },
                                      prefixIcon:
                                          Image.asset("assets/icon/search.png"),
                                      labelText: "Select Location",
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
                                GetBuilder<AdvertisementController>(id: "update",builder: (controller) {
                                  return   Expanded(
                                    child: Obx(() =>
                                    cityController.isLoading == true.obs
                                        ? Center(
                                        child:
                                        CircularProgressIndicator(
                                          color: ThemeManager()
                                              .getThemeGreenColor,
                                        ))
                                        : searchController.text.isNotEmpty
                                        ? RawScrollbar(
                                      thumbColor: ThemeManager()
                                          .getThemeGreenColor,
                                      child: ListView.builder(
                                        itemCount: cityController
                                            .searchCityResultList
                                            .length,
                                        // itemCount: locationList.length,
                                        padding:
                                        EdgeInsets.symmetric(
                                            horizontal: Get
                                                .width *
                                                0.05,
                                            vertical:
                                            Get.height *
                                                0.035),
                                        itemBuilder:
                                            (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              for (int i = 0; i < cityController.searchCityResultList.length;i++) {
                                                cityController.searchCityResultList[i].isCitySelected = false;
                                                if (i == index) {
                                                  cityController.searchCityResultList[index].isCitySelected = true;
                                                  _preferences.setCityName(cityController.searchCityResultList[index].name);
                                                  _preferences.setCityId(cityController.searchCityResultList[index].id.toString());
                                                  controller.getAdvertisement({
                                                    "slide": "",
                                                    "city_id": cityController.searchCityResultList[index].id.toString()
                                                  });
                                                  setState(() {});
                                                  controller.update(["update"]);
                                                  controller.getPostByCityIdApi();

                                                  cityController
                                                      .update();
                                                }
                                              }
                                              setState(() {

                                              });
                                              Get.back();
                                            },
                                            child: Container(
                                              height: Get.height *
                                                  0.065,
                                              decoration:
                                              BoxDecoration(
                                                color: ThemeManager()
                                                    .getWhiteColor,
                                                border: Border(
                                                  bottom:
                                                  BorderSide(
                                                    width: 2,
                                                    color: ThemeManager()
                                                        .getLightGreyColor,
                                                  ),
                                                ),
                                              ),
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  bottom: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(
                                                    cityController
                                                        .searchCityResultList[
                                                    index]
                                                        .name,
                                                    style: poppinsRegular
                                                        .copyWith(
                                                      fontSize:
                                                      Get.width *
                                                          0.04,
                                                      color: cityController
                                                          .searchCityResultList[
                                                      index]
                                                          .isCitySelected
                                                          ? ThemeManager()
                                                          .getThemeGreenColor
                                                          : ThemeManager()
                                                          .getLightGreyColor,
                                                    ),
                                                  ),
                                                  Stack(
                                                    alignment:
                                                    Alignment
                                                        .center,
                                                    children: [
                                                      Container(
                                                        height:
                                                        20,
                                                        width: 20,
                                                        margin: EdgeInsets.only(
                                                            right:
                                                            Get.width * 0.05),
                                                        decoration:
                                                        BoxDecoration(
                                                          shape: BoxShape
                                                              .circle,
                                                          color: cityController.searchCityResultList[index].isCitySelected
                                                              ? ThemeManager().getThemeGreenColor
                                                              : Colors.transparent,
                                                          border:
                                                          Border.all(
                                                            color:
                                                            ThemeManager().getBlackColor,
                                                            width:
                                                            0.5,
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment
                                                            .center,
                                                        child: cityController
                                                            .searchCityResultList[index]
                                                            .isCitySelected
                                                            ? Container(
                                                          height: 7,
                                                          width: 7,
                                                          decoration: BoxDecoration(shape: BoxShape.circle, color: ThemeManager().getWhiteColor),
                                                        )
                                                            : const SizedBox(),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                        : RawScrollbar(
                                      thumbColor: ThemeManager()
                                          .getThemeGreenColor,
                                      child: ListView.builder(
                                        itemCount: cityController
                                            .cityList.length,
                                        // itemCount: locationList.length,
                                        padding:
                                        EdgeInsets.symmetric(
                                            horizontal: Get
                                                .width *
                                                0.05,
                                            vertical:
                                            Get.height *
                                                0.035),
                                        itemBuilder:
                                            (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              for (int i = 0;
                                              i <
                                                  cityController
                                                      .cityList
                                                      .length;
                                              i++) {
                                                cityController
                                                    .cityList[i]
                                                    .isCitySelected =
                                                false;
                                                if (i == index) {
                                                  cityController
                                                      .cityList[
                                                  index]
                                                      .isCitySelected = true;
                                                  _preferences.setCityName(
                                                      cityController
                                                          .cityList[
                                                      index]
                                                          .name);
                                                  _preferences.setCityId(
                                                      cityController
                                                          .cityList[
                                                      index]
                                                          .id
                                                          .toString());
                                                  controller
                                                      .getAdvertisement({
                                                    "slide": "",
                                                    "city_id": cityController
                                                        .cityList[
                                                    index]
                                                        .id
                                                        .toString()
                                                  });
                                                  setState(() {

                                                  });
                                                  controller.update(["update"]);
                                                  cityController
                                                      .update();
                                                }
                                              }
                                              controller.getPostByCityIdApi();

                                              setState(() {

                                              });
                                              Get.back();
                                            },
                                            child: Container(
                                              height: Get.height *
                                                  0.065,
                                              decoration:
                                              BoxDecoration(
                                                color: ThemeManager()
                                                    .getWhiteColor,
                                                border: Border(
                                                  bottom:
                                                  BorderSide(
                                                    width: 2,
                                                    color: ThemeManager()
                                                        .getLightGreyColor,
                                                  ),
                                                ),
                                              ),
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  bottom: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(
                                                    cityController
                                                        .cityList[
                                                    index]
                                                        .name,
                                                    style: poppinsRegular
                                                        .copyWith(
                                                      fontSize:
                                                      Get.width *
                                                          0.04,
                                                      color: cityController
                                                          .cityList[
                                                      index]
                                                          .isCitySelected
                                                          ? ThemeManager()
                                                          .getThemeGreenColor
                                                          : ThemeManager()
                                                          .getLightGreyColor,
                                                    ),
                                                  ),
                                                  Stack(
                                                    alignment:
                                                    Alignment
                                                        .center,
                                                    children: [
                                                      Container(
                                                        height:
                                                        20,
                                                        width: 20,
                                                        margin: EdgeInsets.only(
                                                            right:
                                                            Get.width * 0.05),
                                                        decoration:
                                                        BoxDecoration(
                                                          shape: BoxShape
                                                              .circle,
                                                          color: cityController.cityList[index].isCitySelected
                                                              ? ThemeManager().getThemeGreenColor
                                                              : Colors.transparent,
                                                          border:
                                                          Border.all(
                                                            color:
                                                            ThemeManager().getBlackColor,
                                                            width:
                                                            0.5,
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment
                                                            .center,
                                                        child: cityController
                                                            .cityList[index]
                                                            .isCitySelected
                                                            ? Container(
                                                          height: 7,
                                                          width: 7,
                                                          decoration: BoxDecoration(shape: BoxShape.circle, color: ThemeManager().getWhiteColor),
                                                        )
                                                            : const SizedBox(),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )),
                                  );
                                },)
                                ],
                              ),
                            ),
                          ),
                        ).whenComplete(() {
                          setState(() {});
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: _preferences.getCityName().length <= 7
                                ? Get.width * 0.16
                                : _preferences.getCityName().length > 9 &&
                                        _preferences.getCityName().length <= 12
                                    ? Get.width * 0.22
                                    : Get.width * 0.2,
                            child: Text(
                              _preferences.getCityName(),
                              style: poppinsRegular.copyWith(
                                  fontSize: Get.width * 0.035,
                                  color: ThemeManager().getBlackColor,
                                  overflow: TextOverflow.ellipsis),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Image.asset(
                            "assets/icon/down_arrow.png",
                            color: ThemeManager().getThemeGreenColor,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          backgroundColor: ThemeManager().getWhiteColor,
          title: Image.asset(
            "assets/image/splash_logo.png",
            width: Get.width * 0.12,
            height: Get.width * 0.12,
            fit: BoxFit.fill,
          ),
          centerTitle: true,
          actions: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: Get.width * 0.035),
                  child: GestureDetector(
                      onTap: () {
                        todayMuharatCalenderDialog();
                      },
                      child: Image.asset("assets/icon/date_home.png")),
                ),
                Padding(
                  padding: EdgeInsets.only(right: Get.width * 0.03),
                  child: GestureDetector(
                      onTap: () {
                        Get.to(() => const NotificationScreen());
                      },
                      child: Image.asset("assets/icon/notifications_none.png")),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: Container(
          width: Get.width,
          height: Get.height * 0.1,
          color: ThemeManager().getWhiteColor,
          padding: EdgeInsets.only(top: Get.height * 0.017),
          child: ListView.separated(
              shrinkWrap: true,
              itemCount: bottomNavigationList.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: Get.width * 0.055),
              separatorBuilder: (context, index) {
                return SizedBox(width: Get.width * 0.05);
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    bottomNavigationIndex = index;
                    setState(() {});
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        bottomNavigationIndex == index
                            ? bottomNavigationList[index]["selectedIcon"]
                            : bottomNavigationList[index]["unSelectedIcon"],
                        color: bottomNavigationIndex == index
                            ? ThemeManager().getThemeGreenColor
                            : index == 0
                                ? ThemeManager().getLightGreyColor
                                : null,
                      ),
                      Text(
                        bottomNavigationList[index]["name"],
                        style: bottomNavigationIndex == index
                            ? poppinsBold.copyWith(
                                fontSize: Get.width * 0.035,
                                color: ThemeManager().getBlackColor)
                            : poppinsRegular.copyWith(
                                fontSize: Get.width * 0.035,
                                color: ThemeManager().getLightGreyColor),
                      ),
                      Container(
                        width: Get.width * 0.075,
                        height: 4,
                        margin: EdgeInsets.only(top: Get.height * 0.005),
                        color: bottomNavigationIndex == index
                            ? ThemeManager().getThemeGreenColor
                            : Colors.transparent,
                      ),
                    ],
                  ),
                );
              }),
        ),
        body: bottomNavigationPages[bottomNavigationIndex],
      ),
    );
  }
}
