import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../../controller/home_screen_controller/anniversary_controller.dart';
import '../../controller/home_screen_controller/birthDayController.dart';
import '../../controller/home_screen_controller/video_list_controller.dart';
import '../../controller/news_screen_controller/news_controller.dart';
import '../../services/api_services.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_textstyle.dart';
import '../../utils/images.dart';
import '../../utils/theme_manager.dart';
class WishesScreen extends StatefulWidget {
  const WishesScreen({Key? key}) : super(key: key);

  @override
  State<WishesScreen> createState() => _WishesScreenState();
}

class _WishesScreenState extends State<WishesScreen> with TickerProviderStateMixin{
  late TabController _wishesTabController;
  DateTime nowDate = DateTime.now();
  final anniversaryController = Get.put(AnniversaryController());
  DateTime selectedAnniversaryDay = DateTime.now();
  DateTime selectedBirthDay = DateTime.now();
  DateTime selectedPunyaTithiDay = DateTime.now();
  final birthDayController = Get.put(BirthDayController());
  final videoListController = Get.put(VideoListController());
  final newsController = Get.put(NewsController());
  final birthdayKey = GlobalKey();
  final annivarsaryKey =  GlobalKey();

  WidgetsToImageController anniversaryImageController =
  WidgetsToImageController();
  WidgetsToImageController birthdayImageController = WidgetsToImageController();

  int countYear(String dateOfBirth) {
    DateTime date1 = DateTime.now();
    DateTime date2 = DateTime.parse(dateOfBirth);

    Duration difference = date1.difference(date2);

    int years = (difference.inDays / 365.25).floor();
    return years;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _wishesTabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: ThemeManager().getWhiteColor,
      child: Column(
        children: [
          Container(
            height: Get.height * 0.065,
            width: Get.width,
            margin: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05,
                vertical: Get.height * 0.025),
            decoration: BoxDecoration(
              color: ThemeManager().getWhiteColor,
              borderRadius: BorderRadius.circular(35),
              boxShadow: [
                BoxShadow(
                  color: ThemeManager()
                      .getBlackColor
                      .withOpacity(0.075),
                  blurRadius: 4,
                  spreadRadius: 4,
                  offset: const Offset(3, 4),
                ),
              ],
            ),
            padding: EdgeInsets.all(Get.width * 0.02),
            child: TabBar(
              controller: _wishesTabController,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  // Creates border
                  color: ThemeManager().getThemeGreenColor),
              labelPadding: EdgeInsets.zero,
              labelColor: ThemeManager().getWhiteColor,
              unselectedLabelColor: ThemeManager().getBlackColor,
              labelStyle: poppinsSemiBold.copyWith(
                fontSize: Get.width * 0.035,
              ),
              unselectedLabelStyle: poppinsRegular.copyWith(
                fontSize: Get.width * 0.035,
              ),
              indicatorColor: ThemeManager().getThemeGreenColor,
              tabs: const [
                Tab(
                  child: Text("Anniversary"),
                ),
                Tab(
                  child: Text("Birthday"),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
                controller: _wishesTabController,
                children: [
                  //anniversary
                  Obx(
                        () => Column(
                      children: [
                        TableCalendar(
                          firstDay: DateTime.utc(
                              nowDate.year, nowDate.month, 1),
                          lastDay: DateTime.utc(
                              nowDate.year, nowDate.month + 1, 1),
                          focusedDay: selectedAnniversaryDay,
                          dayHitTestBehavior:
                          HitTestBehavior.translucent,
                          weekNumbersVisible: false,
                          calendarFormat: CalendarFormat.week,
                          calendarStyle: CalendarStyle(
                            markerDecoration: BoxDecoration(
                              color: ThemeManager()
                                  .getThemeGreenColor,
                              shape: BoxShape.rectangle,
                            ),
                            selectedDecoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: ThemeManager()
                                  .getThemeGreenColor,
                              borderRadius:
                              BorderRadius.circular(7),
                              boxShadow: [
                                BoxShadow(
                                  color: ThemeManager()
                                      .getBlackColor
                                      .withOpacity(0.085),
                                  offset: const Offset(2, 3),
                                  spreadRadius: 2.5,
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            isTodayHighlighted: false,
                            defaultDecoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: ThemeManager().getWhiteColor,
                              borderRadius:
                              BorderRadius.circular(7),
                              boxShadow: [
                                BoxShadow(
                                  color: ThemeManager()
                                      .getBlackColor
                                      .withOpacity(0.085),
                                  offset: const Offset(2, 3),
                                  spreadRadius: 2.5,
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            withinRangeDecoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                              BorderRadius.circular(7),
                              color: ThemeManager().getWhiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: ThemeManager()
                                      .getBlackColor
                                      .withOpacity(0.085),
                                  offset: const Offset(2, 3),
                                  spreadRadius: 2.5,
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                          ),
                          selectedDayPredicate: (day) =>
                              isSameDay(
                                  day, selectedAnniversaryDay),
                          onDaySelected:
                              (selectedDay, focusedDay) {
                            setState(() {
                              selectedAnniversaryDay =
                                  selectedDay;
                              focusedDay = selectedAnniversaryDay;
                            });
                            anniversaryController
                                .anniversaryData({
                              "from_day": selectedAnniversaryDay
                                  .day
                                  .toString(),
                              "from_month":
                              nowDate.month.toString(),
                              "to_day": selectedAnniversaryDay.day
                                  .toString(),
                              "to_month": nowDate.month.toString()
                            });
                          },
                          availableGestures:
                          AvailableGestures.horizontalSwipe,
                          headerStyle: HeaderStyle(
                              titleCentered: true,
                              formatButtonVisible: false,
                              leftChevronMargin: EdgeInsets.only(
                                  left: Get.width * 0.22),
                              rightChevronMargin: EdgeInsets.only(
                                  right: Get.width * 0.22),
                              headerPadding: EdgeInsets.zero,
                              titleTextStyle:
                              poppinsMedium.copyWith(
                                color:
                                ThemeManager().getBlackColor,
                                fontSize: Get.width * 0.05,
                              ),
                              leftChevronIcon: Icon(
                                Icons.arrow_left_outlined,
                                color: ThemeManager()
                                    .getThemeGreenColor,
                                size: Get.width * 0.075,
                              ),
                              rightChevronIcon: Icon(
                                Icons.arrow_right_outlined,
                                color: ThemeManager()
                                    .getThemeGreenColor,
                                size: Get.width * 0.075,
                              ),
                              titleTextFormatter:
                                  (dateTime, value) {
                                return DateFormat('MMMM')
                                    .format(dateTime);
                              }),
                          daysOfWeekVisible: false,
                          sixWeekMonthsEnforced: true,
                        ),
                        if (anniversaryController.isLoading ==
                            true)
                          Container(
                            height: Get.height * 0.18,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              color: ThemeManager()
                                  .getThemeGreenColor,
                            ),
                          )
                        else
                          Expanded(
                            child: ListView.separated(
                              itemCount: anniversaryController
                                  .anniversaryList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.05,
                                  vertical: Get.height * 0.015),
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: Get.height * 0.02,
                                );
                              },
                              itemBuilder: (context, index) {
                                return Container(key: annivarsaryKey,
                                  decoration: BoxDecoration(
                                    color: ThemeManager()
                                        .getWhiteColor,
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ThemeManager()
                                            .getBlackColor
                                            .withOpacity(0.075),
                                        spreadRadius: 4,
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.025,
                                    vertical: Get.width * 0.025,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        color: Colors.white,
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  7),
                                              child:
                                              Image.asset(
                                                ImageConstant
                                                    .anniversary,
                                                fit: BoxFit
                                                    .contain,
                                              ),
                                            ),
                                            Positioned(
                                              left: Get.width *
                                                  .082,
                                              bottom:
                                              Get.width *
                                                  .065,
                                              child: Stack(
                                                alignment:
                                                AlignmentDirectional
                                                    .center,
                                                children: [
                                                  ClipOval(
                                                    child: Image
                                                        .network(
                                                      mainUrl +
                                                          anniversaryController
                                                              .anniversaryList[index]
                                                              .avtar,
                                                      height:
                                                      116,
                                                      width:
                                                      116,
                                                      fit: BoxFit
                                                          .cover,
                                                    ),
                                                  ),
                                                  Image.asset(
                                                    ImageConstant
                                                        .circle,
                                                    height: 107,
                                                    width: 107,
                                                    fit: BoxFit
                                                        .fill,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              left: Get.width *
                                                  .484,
                                              bottom:
                                              Get.height *
                                                  .094,
                                              child: Container(
                                                height: 15,
                                                width: 16,
                                                decoration: BoxDecoration(
                                                    color: Color(
                                                        0xedfab9c8),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        4.5)),
                                                child: Center(
                                                  child: Text(
                                                    // "24",
                                                    "${countYear(anniversaryController.anniversaryList[index].dateOfAnniversary)}",
                                                    style: poppinsRegular.copyWith(
                                                        fontSize:
                                                        Get.width *
                                                            0.03,
                                                        color:
                                                        brown,
                                                        fontWeight:
                                                        FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom:
                                              Get.width *
                                                  .07,
                                              right: 0,
                                              child: SizedBox(
                                                width:
                                                Get.width *
                                                    0.48,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      left:
                                                      16.0),
                                                  child: Text(
                                                    anniversaryController
                                                        .anniversaryList[
                                                    index]
                                                        .name,
                                                    style: GoogleFonts.akayaTelivigala(
                                                        fontSize:
                                                        18,
                                                        color: ThemeManager()
                                                            .getRedColor),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: Get.height *
                                                0.015),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          children: [
                                            ///---------------Call------------------

                                            GestureDetector(
                                              onTap: () async {
                                                String
                                                telephoneNumber =
                                                    anniversaryController
                                                        .anniversaryList[
                                                    index]
                                                        .phoneNo;
                                                String
                                                telephoneUrl =
                                                    "tel:$telephoneNumber";
                                                if (await launchUrl(
                                                    Uri.parse(
                                                        telephoneUrl))) {
                                                  await launchUrl(
                                                      Uri.parse(
                                                          telephoneUrl));
                                                } else {
                                                  throw "Error occured trying to call that number.";
                                                }
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .start,
                                                children: [
                                                  Image.asset(
                                                      "assets/icon/call.png"),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: Get
                                                            .width *
                                                            0.03),
                                                    child: Text(
                                                      "Call",
                                                      style: poppinsRegular
                                                          .copyWith(
                                                        fontSize:
                                                        Get.width *
                                                            0.04,
                                                        color: ThemeManager()
                                                            .getThemeGreenColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Container(
                                              color: ThemeManager()
                                                  .getLightGreyColor,
                                              height: 20,
                                              width: 1,
                                              margin: EdgeInsets
                                                  .symmetric(
                                                  horizontal:
                                                  Get.width *
                                                      0.15),
                                            ),

                                            ///---------------Share------------------

                                            GestureDetector(
                                              onTap: () async {
                                                Uint8List? bytes =
                                                await anniversaryImageController
                                                    .capture();
                                                final tempDir =
                                                await getTemporaryDirectory();
                                                File file =
                                                await File(
                                                    '${tempDir.path}/image.png')
                                                    .create();
                                                file.writeAsBytesSync(
                                                    bytes!);
                                                List<String>
                                                shareImage =
                                                [];
                                                shareImage.add(
                                                    file.path);
                                                Share.shareFiles(
                                                    shareImage);
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .start,
                                                children: [
                                                  Image.asset(
                                                      "assets/icon/share_green.png"),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: Get
                                                            .width *
                                                            0.03),
                                                    child: Text(
                                                      "Share",
                                                      style: poppinsRegular
                                                          .copyWith(
                                                        fontSize:
                                                        Get.width *
                                                            0.04,
                                                        color: ThemeManager()
                                                            .getThemeGreenColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  //birthday
                  Obx(
                        () => Column(
                      children: [
                        TableCalendar(
                          firstDay: DateTime.utc(
                              nowDate.year, nowDate.month, 1),
                          lastDay: DateTime.utc(
                              nowDate.year, nowDate.month + 1, 1),
                          focusedDay: selectedBirthDay,
                          dayHitTestBehavior:
                          HitTestBehavior.translucent,
                          weekNumbersVisible: false,
                          calendarFormat: CalendarFormat.week,
                          calendarStyle: CalendarStyle(
                            markerDecoration: BoxDecoration(
                              color: ThemeManager()
                                  .getThemeGreenColor,
                              shape: BoxShape.rectangle,
                            ),
                            selectedDecoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: ThemeManager()
                                  .getThemeGreenColor,
                              borderRadius:
                              BorderRadius.circular(7),
                              boxShadow: [
                                BoxShadow(
                                  color: ThemeManager()
                                      .getBlackColor
                                      .withOpacity(0.085),
                                  offset: const Offset(2, 3),
                                  spreadRadius: 2.5,
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            isTodayHighlighted: false,
                            defaultDecoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: ThemeManager().getWhiteColor,
                              borderRadius:
                              BorderRadius.circular(7),
                              boxShadow: [
                                BoxShadow(
                                  color: ThemeManager()
                                      .getBlackColor
                                      .withOpacity(0.085),
                                  offset: const Offset(2, 3),
                                  spreadRadius: 2.5,
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            withinRangeDecoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: ThemeManager().getWhiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: ThemeManager()
                                      .getBlackColor
                                      .withOpacity(0.085),
                                  offset: const Offset(2, 3),
                                  spreadRadius: 2.5,
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                          ),
                          selectedDayPredicate: (day) =>
                              isSameDay(day, selectedBirthDay),
                          onDaySelected:
                              (selectedDay, focusedDay) {
                            setState(() {
                              selectedBirthDay = selectedDay;
                              focusedDay = selectedBirthDay;
                            });
                            birthDayController.getBirthDay({
                              "from_day":
                              selectedBirthDay.day.toString(),
                              "from_month":
                              nowDate.month.toString(),
                              "to_day":
                              selectedBirthDay.day.toString(),
                              "to_month": nowDate.month.toString()
                            });
                          },
                          availableGestures:
                          AvailableGestures.horizontalSwipe,
                          headerStyle: HeaderStyle(
                              titleCentered: true,
                              formatButtonVisible: false,
                              leftChevronMargin: EdgeInsets.only(
                                  left: Get.width * 0.22),
                              rightChevronMargin: EdgeInsets.only(
                                  right: Get.width * 0.22),
                              headerPadding: EdgeInsets.zero,
                              titleTextStyle:
                              poppinsMedium.copyWith(
                                color:
                                ThemeManager().getBlackColor,
                                fontSize: Get.width * 0.05,
                              ),
                              leftChevronIcon: Icon(
                                Icons.arrow_left_outlined,
                                color: ThemeManager()
                                    .getThemeGreenColor,
                                size: Get.width * 0.075,
                              ),
                              rightChevronIcon: Icon(
                                Icons.arrow_right_outlined,
                                color: ThemeManager()
                                    .getThemeGreenColor,
                                size: Get.width * 0.075,
                              ),
                              titleTextFormatter:
                                  (dateTime, value) {
                                return DateFormat('MMMM')
                                    .format(dateTime);
                              }),
                          daysOfWeekVisible: false,
                          sixWeekMonthsEnforced: true,
                        ),
                        (birthDayController.isLoading == true)
                            ? Container(
                          height: Get.height * 0.18,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            color: ThemeManager()
                                .getThemeGreenColor,
                          ),
                        )
                            : Expanded(
                          child: ListView.separated(
                            itemCount: birthDayController
                                .birthDayList.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                Get.width * 0.05,
                                vertical:
                                Get.height * 0.015),
                            separatorBuilder:
                                (context, index) {
                              return SizedBox(
                                height: Get.height * 0.02,
                              );
                            },
                            itemBuilder: (context, index) {
                              print(
                                  "birthDayController.birthDayList.length ==> ${birthDayController.birthDayList.length}");
                              return Container(key: birthdayKey,
                                decoration: BoxDecoration(
                                  color: ThemeManager()
                                      .getWhiteColor,
                                  borderRadius:
                                  BorderRadius.circular(
                                      10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ThemeManager()
                                          .getBlackColor
                                          .withOpacity(
                                          0.075),
                                      spreadRadius: 4,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                padding:
                                EdgeInsets.symmetric(
                                  horizontal:
                                  Get.width * 0.025,
                                  vertical:
                                  Get.width * 0.025,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                      BorderRadius
                                          .circular(0),
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                            ImageConstant
                                                .birthday,
                                          ),
                                          Positioned(
                                            right:
                                            Get.width *
                                                0.135,
                                            bottom:
                                            Get.width *
                                                0.088,
                                            child:
                                            SizedBox(
                                              height:
                                              Get.height *
                                                  0.11,
                                              width:
                                              Get.width *
                                                  0.23,
                                              child: Image
                                                  .network(
                                                mainUrl +
                                                    birthDayController
                                                        .birthDayList[index]
                                                        .avtar,
                                                fit: BoxFit
                                                    .cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 103.5,
                                            bottom: 86.5,
                                            child:
                                            Container(
                                              height: 9,
                                              width: 9,
                                              decoration: BoxDecoration(
                                                  color:
                                                  lightYellowColor1,
                                                  borderRadius:
                                                  BorderRadius.circular(4.5)),
                                              child:
                                              Center(
                                                child:
                                                Text(
                                                  // "24",
                                                  "${countYear(birthDayController.birthDayList[index].dateOfBirth)}",
                                                  style: poppinsRegular.copyWith(
                                                      fontSize: Get.width *
                                                          0.02,
                                                      color:
                                                      brown,
                                                      fontWeight:
                                                      FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom:
                                            Get.width *
                                                0.02,
                                            // top: Get.width *
                                            //   0.02,
                                            child:
                                            SizedBox(
                                              height: Get
                                                  .height *
                                                  0.063,
                                              width:
                                              Get.width *
                                                  0.48,
                                              child: Text(
                                                birthDayController
                                                    .birthDayList[
                                                index]
                                                    .name,
                                                style: GoogleFonts.akayaTelivigala(
                                                    fontSize:
                                                    20,
                                                    color:
                                                    const Color(0xff524343)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: Get.height *
                                              0.015),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        children: [
                                          ///---------------Call------------------

                                          GestureDetector(
                                            onTap:
                                                () async {
                                              String
                                              telephoneNumber =
                                                  birthDayController
                                                      .birthDayList[
                                                  index]
                                                      .phoneNo;
                                              String
                                              telephoneUrl =
                                                  "tel:$telephoneNumber";
                                              if (await launchUrl(
                                                  Uri.parse(
                                                      telephoneUrl))) {
                                                await launchUrl(
                                                    Uri.parse(
                                                        telephoneUrl));
                                              } else {
                                                throw "Error occured trying to call that number.";
                                              }
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .start,
                                              children: [
                                                Image.asset(
                                                    "assets/icon/call.png"),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: Get.width *
                                                          0.03),
                                                  child:
                                                  Text(
                                                    "Call",
                                                    style: poppinsRegular
                                                        .copyWith(
                                                      fontSize:
                                                      Get.width * 0.04,
                                                      color:
                                                      ThemeManager().getThemeGreenColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Container(
                                            color: ThemeManager()
                                                .getLightGreyColor,
                                            height: 20,
                                            width: 1,
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                Get.width *
                                                    0.15),
                                          ),

                                          ///---------------Share------------------

                                          GestureDetector(
                                            onTap:
                                                () async {
                                              Uint8List?
                                              bytes =
                                              await birthdayImageController
                                                  .capture();
                                              final tempDir =
                                              await getTemporaryDirectory();
                                              File file = await File(
                                                  '${tempDir.path}/image.png')
                                                  .create();
                                              file.writeAsBytesSync(
                                                  bytes!);
                                              List<String>
                                              shareImage =
                                              [];
                                              shareImage
                                                  .add(file
                                                  .path);
                                              Share.shareFiles(
                                                  shareImage);
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .start,
                                              children: [
                                                Image.asset(
                                                    "assets/icon/share_green.png"),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: Get.width *
                                                          0.03),
                                                  child:
                                                  Text(
                                                    "Share",
                                                    style: poppinsRegular
                                                        .copyWith(
                                                      fontSize:
                                                      Get.width * 0.04,
                                                      color:
                                                      ThemeManager().getThemeGreenColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );

  }
}
