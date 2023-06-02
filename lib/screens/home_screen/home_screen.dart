import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:jym_app/screens/home_screen/creat_post_screen.dart';
import 'package:jym_app/screens/home_screen/video_playing.dart';
import 'package:jym_app/utils/app_colors.dart';
import 'package:jym_app/utils/images.dart';
import 'package:jym_app/utils/preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../controller/punya_tithi_controller.dart';
import '../../controller/home_screen_controller/advertisement_controller.dart';
import '../../controller/home_screen_controller/anniversary_controller.dart';
import '../../controller/home_screen_controller/birthDayController.dart';
import '../../controller/home_screen_controller/video_list_controller.dart';
import '../../controller/news_category_controller.dart';
import '../../controller/news_screen_controller/news_controller.dart';
import '../../services/api_services.dart';
import '../../utils/app_textstyle.dart';
import '../../utils/theme_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _mainTabController;
  late TabController _wishesTabController;
  late TabController _sadNewsTabController;
  CarouselController buttonCarouselController = CarouselController();
  ScreenshotController screenshotController = ScreenshotController();
  // WidgetsToImageController anniversaryImageController = WidgetsToImageController();
  // WidgetsToImageController birthdayImageController = WidgetsToImageController();
  // WidgetsToImageController dukhadImageController = WidgetsToImageController();
  // WidgetsToImageController punyaTithiImageController = WidgetsToImageController();
  final newsCategoryController = Get.put(NewsCategoryController());
  final newsSubCategoryController = Get.put(NewsSubCategoryController());


  Uint8List? imageBytes;
  static final wisheskey = GlobalKey();

  int countYear(String dateOfBirth) {
    DateTime date1 = DateTime.now();
    DateTime date2 = DateTime.parse(dateOfBirth);

    Duration difference = date1.difference(date2);

    int years = (difference.inDays / 365.25).floor();
    return years;
  }

  int carouselIndex = 0;

  int selectedFirstIndex = 0;

  DateTime selectedAnniversaryDay = DateTime.now();
  DateTime selectedBirthDay = DateTime.now();
  DateTime selectedPunyaTithiDay = DateTime.now();
  final advertisementController = Get.put(AdvertisementController());
  final anniversaryController = Get.put(AnniversaryController());
  final birthDayController = Get.put(BirthDayController());
  final videoListController = Get.put(VideoListController());
  final newsController = Get.put(NewsController());
  final punyaTithiController = Get.put(PunyaTithiController());
  final Preferences _preferences = Preferences();


  //
  DateTime nowDate = DateTime.now();
  DateTime selectedDukhadSamacharDay = DateTime.now();

  String? selectedMenu;

  //here apicall for get post by city id
  APIServices apiServices = APIServices();

  @override
  void initState() {
    advertisementController.getPostByCityIdApi();
    advertisementController
        .getAdvertisement({"slide": "", "city_id": _preferences.getCityId()});
    print("_preferences.getCityId() ==> ${_preferences.getCityId()}");
    setState(() {});
    _mainTabController = TabController(length: 4, vsync: this);
    _wishesTabController = TabController(length: 2, vsync: this);
    _sadNewsTabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  // GlobalKey globalKeyA = GlobalKey(debugLabel: 'A');

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: ThemeManager().getWhiteColor,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Column(
            children: [
              ///-------------------TabBar---------------------

              Container(
                height: Get.height * 0.075,
                width: Get.width,
                color: ThemeManager().getThemeGreenColor.withOpacity(0.1),
                child: TabBar(
                    onTap: (value) {
                      selectedFirstIndex = value;
                      var dukhadSamacharBody = {
                        "filter_from":
                            "${selectedDukhadSamacharDay.year}-${selectedDukhadSamacharDay.month}-${selectedDukhadSamacharDay.day}",
                        "filter_to":
                            "${selectedDukhadSamacharDay.year}-${selectedDukhadSamacharDay.month}-${selectedDukhadSamacharDay.day}",
                        "category_id": "",
                        "sub_category_id": "6",
                        "city_id": _preferences.getCityId()
                      };
                      var punayTithiBody = {
                        "date":
                            "${selectedPunyaTithiDay.month}-${selectedPunyaTithiDay.day}",
                        "city_id": _preferences.getCityId()
                      };
                      if (value == 2) {
                        newsController.getNews(dukhadSamacharBody);
                        // newsController.getNews(punayTithiBody);
                        punyaTithiController.getPunyatithi(punayTithiBody);
                      }
                      setState(() {});
                    },
                    controller: _mainTabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                          width: 5.0, color: ThemeManager().getThemeGreenColor),
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
                        child: Text("Post"),
                      ),
                      Tab(
                        child: Text("Wishes"),
                      ),
                      Tab(
                        child: Text("Sad News"),
                      ),
                      Tab(
                        child: Text("Videos"),
                      ),
                    ]),
              ),

              Expanded(
                child: TabBarView(controller: _mainTabController, children: [
                  ///-------------------Post---------------------

                  GetBuilder<AdvertisementController>(
                    id: "update",
                    builder: (controller) {
                      return SizedBox(
                        height: Get.height,
                        width: Get.width,
                        child: Column(
                          children: [
                            ///------------Carousel Slider--------------

                            GetBuilder<AdvertisementController>(
                              id: "update",
                              builder: (controller) {
                                return Padding(
                                  padding:
                                      EdgeInsets.only(top: Get.height * 0.025),
                                  child: Obx(
                                    () => controller.isLoading.value == true
                                        ? Container(
                                            height: Get.height * 0.18,
                                            alignment: Alignment.center,
                                            child: CircularProgressIndicator(
                                              color: ThemeManager()
                                                  .getThemeGreenColor,
                                            ),
                                          )
                                        : advertisementController
                                                .advertisementList.isNotEmpty
                                            ? CarouselSlider.builder(
                                                carouselController:
                                                    buttonCarouselController,
                                                itemCount:
                                                    advertisementController
                                                        .advertisementList
                                                        .length,
                                                itemBuilder: (BuildContext
                                                            context,
                                                        int itemIndex,
                                                        int pageViewIndex) =>
                                                    Container(
                                                  width: Get.width * 0.8,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(mainUrl +
                                                            controller
                                                                .advertisementList[
                                                                    itemIndex]
                                                                .bannerUrl),
                                                        fit: BoxFit.fill),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                options: CarouselOptions(
                                                    viewportFraction: 1,
                                                    height: Get.height * 0.2,
                                                    autoPlay: true,
                                                    onPageChanged: (i, value) {
                                                      carouselIndex = i;
                                                      setState(() {});
                                                    }),
                                              )
                                            : Container(),
                                  ),
                                );
                              },
                            ),

                            ///------------Slider Indicator--------------

                            GetBuilder<AdvertisementController>(
                              id: "update",
                              builder: (controller) {
                                return controller.advertisementList.isNotEmpty
                                    ? Obx(
                                        () => controller.isLoading.value == true
                                            ? SizedBox(
                                                height: Get.height * 0.18,
                                              )
                                            : Padding(
                                                padding: EdgeInsets.only(
                                                  top: Get.height * 0.025,
                                                  bottom: Get.height * 0.03,
                                                ),
                                                child: AnimatedSmoothIndicator(
                                                  activeIndex: carouselIndex,
                                                  count: controller
                                                      .advertisementList.length,
                                                  effect: ExpandingDotsEffect(
                                                      activeDotColor:
                                                          ThemeManager()
                                                              .getThemeGreenColor,
                                                      dotColor: ThemeManager()
                                                          .getLightGreyColor
                                                          .withOpacity(0.5),
                                                      dotWidth: 8,
                                                      dotHeight: 8),
                                                ),
                                              ),
                                      )
                                    : const SizedBox.shrink();
                              },
                            ),

                            //post list for home page========================>
                            (controller.postByIdModel.posts?.length == 0)
                                ? const Expanded(
                                    child: Text("No data"),
                                  )
                                : Expanded(
                                    child: ListView.separated(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: controller
                                              .postByIdModel.posts?.length ??
                                          0,
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
                                        var postItem = controller
                                            .postByIdModel.posts![index];
                                        RxString likeCount = "0".obs;
                                        apiServices
                                            .likeCountPost(
                                                postItem.id.toString())
                                            .then((value) {
                                          if (value != null) {
                                            likeCount.value = value;
                                          }
                                        });
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: ThemeManager().getWhiteColor,
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
                                              horizontal: Get.width * 0.05,
                                              vertical: Get.height * 0.025),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child: postItem
                                                                  .avtarUrl !=
                                                              null
                                                          ? Image.network(
                                                              "https://jymnew.spitel.com/${postItem.avtarUrl}",
                                                              height:
                                                                  Get.width *
                                                                      0.15,
                                                              width: Get.width *
                                                                  0.15,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : const Icon(
                                                              Icons
                                                                  .account_circle,
                                                              size: 50,
                                                            )),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: Get.width *
                                                              0.025),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            postItem.firstName ??
                                                                "",
                                                            style: poppinsMedium
                                                                .copyWith(
                                                              fontSize:
                                                                  Get.width *
                                                                      0.05,
                                                              color: ThemeManager()
                                                                  .getBlackColor,
                                                            ),
                                                          ),
                                                          Text(
                                                            postItem.createdAt
                                                                    ?.replaceRange(
                                                                        10,
                                                                        postItem
                                                                            .createdAt
                                                                            ?.length,
                                                                        "") ??
                                                                "",
                                                            style:
                                                                poppinsRegular
                                                                    .copyWith(
                                                              fontSize:
                                                                  Get.width *
                                                                      0.035,
                                                              color: ThemeManager()
                                                                  .getBlackColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  PopupMenuButton(
                                                    initialValue: selectedMenu,
                                                    // Callback that sets the selected popup menu item.
                                                    onSelected: (value) {
                                                      setState(() {
                                                        selectedMenu = value;
                                                      });
                                                      // APIServices()
                                                      //     .deletePost(postItem.id.toString()).then((value) => setState((){}));
                                                    },
                                                    itemBuilder: (BuildContext
                                                            context) =>
                                                        [
                                                      PopupMenuItem(
                                                        onTap: () {
                                                          APIServices()
                                                              .deletePost(postItem
                                                                  .id
                                                                  .toString())
                                                              .then((value) =>
                                                                  setState(
                                                                      () {}));
                                                        },
                                                        value: "Delete",
                                                        child: const Text(
                                                            'Delete'),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: Get.height * 0.015),
                                                child: Text(
                                                  postItem.description ?? "",
                                                  style:
                                                      poppinsRegular.copyWith(
                                                    fontSize: Get.width * 0.037,
                                                    color: ThemeManager()
                                                        .getBlackColor,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: Get.height * 0.015),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    "https://jymnew.spitel"
                                                    ".com/${postItem.postUrl}",
                                                    height: Get.height * 0.2,
                                                    width: double.maxFinite,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: Get.height * 0.015),
                                                child: Row(
                                                  children: [
                                                    ///---------------Like------------------

                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (postItem
                                                                    .likeButtonClick ==
                                                                false) {
                                                              postItem.likeButtonClick =
                                                                  true;
                                                              apiServices.likeCountDetailsPost(
                                                                  postId: postItem
                                                                      .id
                                                                      .toString(),
                                                                  customerId: postItem
                                                                      .customerId
                                                                      .toString(),
                                                                  isLiked: postItem
                                                                      .likeButtonClick);
                                                            }
                                                            setState(() {});
                                                          },
                                                          child: postItem
                                                                      .likeButtonClick ==
                                                                  true
                                                              ? Icon(
                                                                  Icons
                                                                      .favorite,
                                                                  size:
                                                                      Get.width *
                                                                          0.06,
                                                                  color: ThemeManager()
                                                                      .getRedColor,
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .favorite_border,
                                                                  color: ThemeManager()
                                                                      .getRedColor,
                                                                ),
                                                        ),
                                                        Obx(
                                                          () => Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: Get
                                                                            .width *
                                                                        0.03),
                                                            child: Text(
                                                              likeCount.value,
                                                              style:
                                                                  poppinsRegular
                                                                      .copyWith(
                                                                fontSize:
                                                                    Get.width *
                                                                        0.04,
                                                                color: ThemeManager()
                                                                    .getBlackColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    ///---------------Share------------------

                                                    InkWell(
                                                      onTap: () {
                                                        Share.share(
                                                            "https://jymnew.spitel"
                                                            ".com/${controller.postByIdModel.posts?[index].postUrl}");
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left:
                                                                    Get.width *
                                                                        0.075),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ImageIcon(
                                                                const AssetImage(
                                                                    "assets/icon/share_black.png"),
                                                                size:
                                                                    Get.width *
                                                                        0.065,
                                                                color: ThemeManager()
                                                                    .getBlackColor),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: Get
                                                                              .width *
                                                                          0.03),
                                                              child: Text(
                                                                "Share",
                                                                style:
                                                                    poppinsRegular
                                                                        .copyWith(
                                                                  fontSize:
                                                                      Get.width *
                                                                          0.04,
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
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                          ],
                        ),
                      );
                    },
                  ),

                  ///------------------Wishes---------------------
                  Container(
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
                          key: wisheskey,
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
                                      anniversaryController.isLoading == true
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
                                                itemCount: anniversaryController
                                                    .anniversaryList.length,
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
                                                  print("anniversaryController.anniversaryList[index].name =>${anniversaryController.anniversaryList[index].name}");
                                                  GlobalKey _globalAnniversaryKey =  GlobalKey();
                                                  int yearTithi = countYear(anniversaryController.anniversaryList[index].dateOfAnniversary);
                                                  // int yearTithi = 12;
                                                  String extention = "";
                                                  String temp = yearTithi.toString().substring(yearTithi.toString().length-1);
                                                  if(temp == "1"){
                                                    extention = "st";
                                                  }
                                                  if(temp == "2") {
                                                    extention = "rd";
                                                    print("extention ==> $temp");
                                                  }
                                                  if(temp != "1" && temp != "2"){
                                                    extention = "th";
                                                  }
                                                  return Container(
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
                                                        RepaintBoundary(
                                                          key: _globalAnniversaryKey,
                                                          child: Container(color: Colors.white,
                                                            child: Stack(key: Key(index.toString()),
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              7),
                                                                  child: Image
                                                                      .asset(
                                                                    ImageConstant
                                                                        .anniversary,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  left:
                                                                      Get.width *
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
                                                                              anniversaryController.anniversaryList[index].avtar,
                                                                          height:
                                                                              116,
                                                                          width:
                                                                              116,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                      Image
                                                                          .asset(
                                                                        ImageConstant
                                                                            .circle,
                                                                        height:
                                                                            107,
                                                                        width:
                                                                            107,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                yearTithi != 0 ? Positioned(bottom: Get.height * .104,left: Get.width * .54,child: Text(extention,style: GoogleFonts.poppins(
                                                                  fontSize: 8,
                                                                  color: ThemeManager().brownColors,
                                                                  fontWeight:
                                                                  FontWeight.w400,
                                                                ),)) : Container(),
                                                                Positioned(
                                                                  left:
                                                                      Get.width *
                                                                          .50,
                                                                  bottom:
                                                                      Get.height *
                                                                          .095,
                                                                  child:
                                                                      Container(
                                                                    height: 15,
                                                                    width: 16,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text( yearTithi != 0 ?
                                                                        "$yearTithi" : '',
                                                                        style: poppinsRegular.copyWith(
                                                                            fontSize: Get.width *
                                                                                0.03,
                                                                            color:
                                                                            ThemeManager().brownColors,
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
                                                                  child:
                                                                      SizedBox(
                                                                    width:
                                                                        Get.width *
                                                                            0.48,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              16.0),
                                                                      child:
                                                                          Text(
                                                                        anniversaryController
                                                                            .anniversaryList[index]
                                                                            .name,
                                                                        style: GoogleFonts.akayaTelivigala(
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                ThemeManager().getRedColor),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
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
                                                                 RenderRepaintBoundary boundary = _globalAnniversaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
                                                                 ui.Image image = await boundary.toImage();
                                                                 ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
                                                                 Uint8List pngBytes = byteData!.buffer.asUint8List();
                                                                 final tempDir = await getTemporaryDirectory();
                                                                 File file = await File('${tempDir.path}/image.png').create();
                                                                 file.writeAsBytesSync(pngBytes);
                                                                 List<String>shareImage = [];
                                                                 shareImage.add(file.path);
                                                                 Share.shareFiles(shareImage);
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
                                                  GlobalKey _globalBirthDayKey =  GlobalKey();

                                                  int yearBirthDay = countYear(birthDayController.birthDayList[index].dateOfBirth);
                                                  // int yearTithi = 12;
                                                  String extention = "";
                                                  String temp = yearBirthDay.toString().substring(yearBirthDay.toString().length-1);
                                                  if(temp == "1"){
                                                    extention = "st";
                                                  }
                                                  if(temp == "2") {
                                                    extention = "rd";
                                                    print("extention ==> $temp");
                                                  }
                                                  if(temp != "1" && temp != "2"){
                                                    extention = "th";
                                                  }
                                                  print(
                                                      "birthDayController.birthDayList.length ==> ${birthDayController.birthDayList.length}");
                                                  return Container(
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
                                                          child: RepaintBoundary(
                                                            key: _globalBirthDayKey,
                                                            child: Container(color: Colors.white,
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
                                                                    child: SizedBox(
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
                                                                  yearBirthDay != 0 ? Positioned(bottom: Get.height * .113,left: Get.width * .32,child: Text(extention,style: GoogleFonts.poppins(
                                                                    fontSize: 8,
                                                                    color: ThemeManager().brownColors,
                                                                    fontWeight:
                                                                    FontWeight.w400,
                                                                  ),)) : Container(),
                                                                  Positioned(
                                                                    left: Get.width * .285,
                                                                    bottom: Get.height * .11,
                                                                    child:
                                                                        Container(
                                                                      height: 9,
                                                                      width: 15,
                                                                      // decoration: BoxDecoration(
                                                                      //     color:
                                                                      //         lightYellowColor1,
                                                                      //     borderRadius:
                                                                      //         BorderRadius.circular(
                                                                      //             4.5)),
                                                                      child: Center(
                                                                        child: Text( yearBirthDay != 0 ?
                                                                          "$yearBirthDay" : "",
                                                                          style: poppinsRegular.copyWith(
                                                                              fontSize: 8,
                                                                              color:
                                                                              redColor,
                                                                              fontWeight:
                                                                                  FontWeight.w700),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    bottom:
                                                                        Get.width *
                                                                            0.015,
                                                                    left: 5,
                                                                    child: SizedBox(
                                                                      height:
                                                                          Get.height *
                                                                              0.063,
                                                                      width:
                                                                          Get.width *
                                                                              0.44,
                                                                      child: Text(
                                                                        birthDayController
                                                                            .birthDayList[
                                                                                index]
                                                                            .name,
                                                                        style: GoogleFonts.akayaTelivigala(
                                                                            fontSize: 14,
                                                                            color: ThemeManager().brownColors),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
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
                                                                onTap: () async {
                                                                  // Uint8List?bytes = await birthdayImageController.capture();
                                                                  // final tempDir = await getTemporaryDirectory();
                                                                  // File file = await File('${tempDir.path}/image.png').create();
                                                                  // file.writeAsBytesSync(bytes!);
                                                                  // List<String>shareImage = [];
                                                                  // shareImage.add(file.path);
                                                                  RenderRepaintBoundary boundary = _globalBirthDayKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
                                                                  ui.Image image = await boundary.toImage();
                                                                  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
                                                                  Uint8List pngBytes = byteData!.buffer.asUint8List();
                                                                  final tempDir = await getTemporaryDirectory();
                                                                  File file = await File('${tempDir.path}/image.png').create();
                                                                  file.writeAsBytesSync(pngBytes);
                                                                  List<String>shareImage = [];
                                                                  shareImage.add(file.path);
                                                                  Share.shareFiles(shareImage);
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
                  ),

                  ///------------------Sad news---------------------
                  Container(
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
                            onTap: (value) {
                              if (value == 0) {
                                var dukhadSamacharBody = {
                                  "filter_from":
                                      "${selectedDukhadSamacharDay.year}-${selectedDukhadSamacharDay.month}-${selectedDukhadSamacharDay.day}",
                                  "filter_to":
                                      "${selectedDukhadSamacharDay.year}-${selectedDukhadSamacharDay.month}-${selectedDukhadSamacharDay.day}",
                                  "category_id": "",
                                  "sub_category_id": "6",
                                  "city_id": _preferences.getCityId()
                                };
                                newsController.getNews(dukhadSamacharBody);
                              } else {
                                var punayTithiBody = {
                                   "date" :"${selectedDukhadSamacharDay.month}-${selectedDukhadSamacharDay.day}",
                                  "city_id": _preferences.getCityId()
                                };
                                punyaTithiController.getPunyatithi(punayTithiBody);
                                // newsController.getNews(punayTithiBody);
                              }

                            },
                            controller: _sadNewsTabController,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
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
                                child: Text("Dukhad Samachar"),
                              ),
                              Tab(
                                child: Text("Punya tithi"),
                              ),
                            ],
                          ),
                        ),
                        Expanded(key: UniqueKey(),
                          child: TabBarView(
                              controller: _sadNewsTabController,
                              children: [
                                //dukhad samachar
                                Column(
                                  children: [
                                    TableCalendar(
                                      firstDay: DateTime.utc(
                                          nowDate.year, nowDate.month, 1),
                                      lastDay: DateTime.utc(
                                          nowDate.year, nowDate.month + 1, 1),
                                      focusedDay: selectedDukhadSamacharDay,
                                      dayHitTestBehavior:
                                          HitTestBehavior.translucent,
                                      weekNumbersVisible: false,
                                      calendarFormat: CalendarFormat.week,
                                      calendarStyle: CalendarStyle(
                                        markerDecoration: BoxDecoration(
                                          color:
                                              ThemeManager().getThemeGreenColor,
                                          shape: BoxShape.rectangle,
                                        ),
                                        selectedDecoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color:
                                              ThemeManager().getThemeGreenColor,
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
                                      selectedDayPredicate: (day) => isSameDay(
                                          day, selectedDukhadSamacharDay),
                                      onDaySelected: (selectedDay, focusedDay) {
                                        selectedDukhadSamacharDay = selectedDay;
                                        focusedDay = selectedDukhadSamacharDay;
                                        setState(() {});
                                        var dukhadSamacharBody = {
                                          "filter_from":
                                              "${selectedDay.year}-${selectedDay.month}-${selectedDay.day}",
                                          "filter_to":
                                              "${selectedDay.year}-${selectedDay.month}-${selectedDay.day}",
                                          "category_id": "9",
                                          "sub_category_id": "",
                                          "city_id": _preferences.getCityId()
                                        };
                                        newsController
                                            .getNews(dukhadSamacharBody);
                                        print("dukhadSamacharBody ==> ${dukhadSamacharBody}");
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
                                            color: ThemeManager().getBlackColor,
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
                                    Expanded(
                                      child:
                                          Obx(
                                              () =>
                                                  newsController.isLoading
                                                              .value ==
                                                          true
                                                      ? Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: ThemeManager()
                                                                .getThemeGreenColor,
                                                          ),
                                                        )
                                                      : ListView.separated(
                                                          physics:
                                                              const BouncingScrollPhysics(),
                                                          itemCount:
                                                              newsController
                                                                  .newsList
                                                                  .length,
                                                          shrinkWrap: true,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      Get.width *
                                                                          0.05,
                                                                  vertical:
                                                                      Get.height *
                                                                          0.015),
                                                          separatorBuilder:
                                                              (context, index) {
                                                            return SizedBox(
                                                              height:
                                                                  Get.height *
                                                                      0.02,
                                                            );
                                                          },
                                                          itemBuilder:
                                                              (context, index) {
                                                                GlobalKey _globalDukhadKey =  GlobalKey();

                                                                String category =
                                                                "";
                                                            for (int i = 0;
                                                                i <
                                                                    newsSubCategoryController
                                                                        .newsSubCategoryList
                                                                        .length;
                                                                i++) {
                                                              if (newsController
                                                                      .newsList[
                                                                          index]
                                                                      .subCategoryId
                                                                      .toString() ==
                                                                  newsSubCategoryController
                                                                      .newsSubCategoryList[
                                                                          i]
                                                                      .id
                                                                      .toString()) {
                                                                category =
                                                                    newsSubCategoryController
                                                                        .newsSubCategoryList[i]
                                                                        .name;
                                                                break;
                                                              }
                                                            }
                                                            return Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: ThemeManager()
                                                                    .getWhiteColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: ThemeManager()
                                                                        .getBlackColor
                                                                        .withOpacity(
                                                                            0.075),
                                                                    spreadRadius:
                                                                        4,
                                                                    blurRadius:
                                                                        5,
                                                                  ),
                                                                ],
                                                              ),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                horizontal:
                                                                    Get.width *
                                                                        0.025,
                                                                vertical:
                                                                    Get.width *
                                                                        0.025,
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  RepaintBoundary(key: _globalDukhadKey,
                                                                    child: Container(color: Colors.white,
                                                                      child: ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius
                                                                                .circular(7),
                                                                        child:
                                                                            Stack(
                                                                          alignment:
                                                                              Alignment
                                                                                  .center,
                                                                          children: [
                                                                            Image.asset(
                                                                              ImageConstant.dukhadImage,
                                                                              width: double.infinity,
                                                                              height:
                                                                                  350,
                                                                              fit: BoxFit
                                                                                  .fill,
                                                                            ),
                                                                            Positioned(
                                                                                top:
                                                                                    10,
                                                                                child: Container(
                                                                                    alignment: Alignment.center,
                                                                                    decoration: BoxDecoration( borderRadius: BorderRadius.circular(8)),
                                                                                    height: 27,
                                                                                    width: Get.width * .334,
                                                                                    child: Text(
                                                                                      category,
                                                                                      style: GoogleFonts.poppins(
                                                                                        fontSize: 15,
                                                                                        color: ThemeManager().brownColors,
                                                                                        fontWeight: FontWeight.w700,
                                                                                      ),
                                                                                    ))),
                                                                            Positioned(
                                                                              top: Get.width * .125,
                                                                                  // 40,
                                                                              left: Get.width *
                                                                                  0.301,
                                                                              child:
                                                                                  Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                                                                                  image: DecorationImage(alignment: Alignment.center,fit: BoxFit.cover,image: NetworkImage(mainUrl + newsController.newsList[index].bannerUrl))),
                                                                                height:
                                                                                    98,
                                                                                width:
                                                                                    88,
                                                                              ),
                                                                            ),
                                                                            Column(
                                                                              children: [
                                                                                const SizedBox(
                                                                                  height: 58,
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Text(
                                                                                    newsController.newsList[index].name,
                                                                                    textAlign: TextAlign.center,
                                                                                    style: GoogleFonts.poppins(
                                                                                      fontSize: 15,
                                                                                      color: ThemeManager().brownColors,
                                                                                      fontWeight: FontWeight.w700,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                                  child: Text(
                                                                                    newsController.newsList[index].description,
                                                                                    textAlign: TextAlign.center,
                                                                                    style: GoogleFonts.poppins(fontSize: 7.1, color: ThemeManager().brownColors,fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  ///---------------Share------------------
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: Get.height * 0.015),
                                                                    child: GestureDetector(
                                                                        onTap: () async {
                                                                        // Uint8List?bytes = await dukhadImageController.capture();
                                                                        // final tempDir = await getTemporaryDirectory();
                                                                        // File file = await File('${tempDir.path}/image.png').create();
                                                                        // file.writeAsBytesSync(bytes!);
                                                                        // List<String>shareImage = [];
                                                                        // shareImage.add(file.path);
                                                                        // Share.shareFiles(shareImage);
                                                                          RenderRepaintBoundary boundary = _globalDukhadKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
                                                                          ui.Image image = await boundary.toImage();
                                                                          ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
                                                                          Uint8List pngBytes = byteData!.buffer.asUint8List();
                                                                          final tempDir = await getTemporaryDirectory();
                                                                          File file = await File('${tempDir.path}/image.png').create();
                                                                          file.writeAsBytesSync(pngBytes);
                                                                          List<String>shareImage = [];
                                                                          shareImage.add(file.path);
                                                                          Share.shareFiles(shareImage);
                                                                        },
                                                                        child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Image.asset(
                                                                          "assets/icon/share_green.png"),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: Get.width * 0.03),
                                                                        child:
                                                                            Text(
                                                                          "Share",
                                                                          style: poppinsRegular.copyWith(
                                                                            fontSize: Get.width * 0.04,
                                                                            color: ThemeManager().getThemeGreenColor,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                        ),
                                                                      ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        )),
                                    ),
                                  ],
                                ),
                                //puniya tithi
                                Column(
                                  children: [
                                    TableCalendar(
                                      firstDay: DateTime.utc(
                                          nowDate.year, nowDate.month, 1),
                                      lastDay: DateTime.utc(
                                          nowDate.year, nowDate.month + 1, 1),
                                      focusedDay: selectedPunyaTithiDay,
                                      dayHitTestBehavior:
                                          HitTestBehavior.translucent,
                                      weekNumbersVisible: false,
                                      calendarFormat: CalendarFormat.week,
                                      calendarStyle: CalendarStyle(
                                        selectedDecoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color:
                                              ThemeManager().getThemeGreenColor,
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
                                          isSameDay(day, selectedPunyaTithiDay),
                                      onDaySelected: (selectedDay, focusedDay) {
                                        print("selectedDay ==> ${selectedDay}");
                                        selectedPunyaTithiDay = selectedDay;
                                        focusedDay = selectedPunyaTithiDay;
                                        String temp = focusedDay.toString().substring(5,10);
                                        print("selectedDay ==> ${temp}");

                                        setState(() {});
                                        var punayTithiBody = {
                                          "date":temp,
                                          "city_id": _preferences.getCityId()
                                        };
                                        // newsController.getNews(punayTithiBody);
                                        punyaTithiController.getPunyatithi(punayTithiBody);
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
                                            color: ThemeManager().getBlackColor,
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
                                    Obx(() => Expanded(
                                      child: ListView.separated(
                                                    itemCount:
                                                        punyaTithiController
                                                            .punyaTithiList
                                                            .length,
                                                    shrinkWrap: true,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                Get.width *
                                                                    0.05,
                                                            vertical:
                                                                Get.height *
                                                                    0.015),
                                                    separatorBuilder:
                                                        (context, index) {
                                                      return SizedBox(
                                                        height:
                                                            Get.height * 0.02,
                                                      );
                                                    },
                                                    itemBuilder:
                                                        (context, index) {
                                                          GlobalKey _globalPunyaTithiKey =  GlobalKey();
                                                          int yearTithi = countYear(punyaTithiController.punyaTithiList[index].dateOfExpire.toString());
                                                          // int yearTithi = 12;
                                                          String extention = "";
                                                          String temp = yearTithi.toString().substring(yearTithi.toString().length-1);
                                                          if(temp == "1"){
                                                            extention = "st";
                                                            print("extention ==> $temp");
                                                          }
                                                          if(temp == "2") {
                                                            extention = "rd";
                                                            print("extention ==> $temp");
                                                          }
                                                          if(temp != "1" && temp != "2"){
                                                            extention = "th";
                                                          }
                                                          return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ThemeManager()
                                                              .getWhiteColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
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
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal:
                                                              Get.width * 0.025,
                                                          vertical:
                                                              Get.width * 0.025,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7),
                                                              child: RepaintBoundary(
                                                                key: _globalPunyaTithiKey,
                                                                child: Container(color: Colors.white,
                                                                  child: Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    children: [
                                                                      Image.asset(
                                                                        ImageConstant.punyaTithiImage,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                      Positioned(
                                                                        top: Get.width *
                                                                            0.125,
                                                                        left: Get
                                                                                .width *
                                                                            0.315,
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(
                                                                                  55),
                                                                              ),
                                                                          height:
                                                                              78,
                                                                          width:
                                                                              78,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(2.0),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius:
                                                                                  BorderRadius.circular(45),
                                                                              child:
                                                                                  Image.network(
                                                                                mainUrl + punyaTithiController.punyaTithiList[index].avtar,
                                                                                height: 90,
                                                                                width: 90,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      yearTithi != 0 ? Positioned(bottom: Get.height * .214,left: Get.width * .188,child: Text(extention,style: GoogleFonts.poppins(
                                                                        fontSize: 8,
                                                                        color:
                                                                        ThemeManager().brownColors,
                                                                        fontWeight:
                                                                        FontWeight.w400,
                                                                      ),)) : Container(),
                                                                      Positioned(bottom: Get.height * .19,left: Get.width * .15,child: Padding(
                                                                        padding: const EdgeInsets.only(bottom: 8.0),
                                                                        child: Text(yearTithi != 0 ?
                                                                        "($yearTithi    पुण्यतिथि पर भावपूर्ण श्रद्धांजलि)" : "",
                                                                          textAlign:
                                                                          TextAlign.center,
                                                                          style:
                                                                          GoogleFonts.poppins(
                                                                            fontSize: 12,
                                                                            color:
                                                                            ThemeManager().brownColors,
                                                                            fontWeight:
                                                                            FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                      ),),
                                                                      SizedBox(height: Get.height * .253,
                                                                        child: Column(
                                                                            children: [
                                                                        SizedBox(
                                                                          height: Get.height * .12,
                                                                        ),
                                                                        Text(
                                                                          punyaTithiController
                                                                              .punyaTithiList[index]
                                                                              .name,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                ThemeManager().brownColors,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(top: 5.0),
                                                                          child: Text(
                                                                            punyaTithiController
                                                                                .punyaTithiList[index]
                                                                                .about,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: GoogleFonts.poppins(
                                                                                fontSize: 9,
                                                                                color: ThemeManager().brownColors),
                                                                          ),
                                                                        ),
                                                                         SizedBox(
                                                                          height: Get.height * .02,
                                                                        ),
                                                                            ],
                                                                          ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),

                                                            ///---------------Share------------------

                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                      top: Get.height * 0.015),
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
                                                                          punyaTithiController
                                                                              .punyaTithiList[index]
                                                                              .phoneNo;
                                                                      String
                                                                          telephoneUrl =
                                                                          "tel:$telephoneNumber";
                                                                      if (await launchUrl(
                                                                          Uri.parse(
                                                                              telephoneUrl))) {
                                                                        await launchUrl(
                                                                            Uri.parse(telephoneUrl));
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
                                                                          padding:
                                                                              EdgeInsets.only(left: Get.width * 0.03),
                                                                          child:
                                                                              Text(
                                                                            "Call",
                                                                            style:
                                                                                poppinsRegular.copyWith(
                                                                              fontSize: Get.width * 0.04,
                                                                              color: ThemeManager().getThemeGreenColor,
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
                                                                    onTap: () async {
                                                                      // Uint8List?bytes = await punyaTithiImageController.capture();
                                                                      // final tempDir = await getTemporaryDirectory();
                                                                      // File file = await File('${tempDir.path}/image.png').create();
                                                                      // file.writeAsBytesSync(bytes!);
                                                                      // List<String>shareImage = [];
                                                                      // shareImage.add(file.path);
                                                                      // Share.shareFiles(shareImage);
                                                                      RenderRepaintBoundary boundary = _globalPunyaTithiKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
                                                                      ui.Image image = await boundary.toImage();
                                                                      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
                                                                      Uint8List pngBytes = byteData!.buffer.asUint8List();
                                                                      final tempDir = await getTemporaryDirectory();
                                                                      File file = await File('${tempDir.path}/image.png').create();
                                                                      file.writeAsBytesSync(pngBytes);
                                                                      List<String>shareImage = [];
                                                                      shareImage.add(file.path);
                                                                      Share.shareFiles(shareImage);
                                                                    },
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Image.asset(
                                                                            "assets/icon/share_green.png"),
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(left: Get.width * 0.03),
                                                                          child:
                                                                              Text(
                                                                            "Share",
                                                                            style:
                                                                                poppinsRegular.copyWith(
                                                                              fontSize: Get.width * 0.04,
                                                                              color: ThemeManager().getThemeGreenColor,
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
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),

                  ///------------------Videos---------------------

                  Obx(
                    () => videoListController.isLoading.value == true
                        ? Container(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                                color: ThemeManager().getThemeGreenColor))
                        : ListView.separated(
                            itemCount:
                                videoListController.videoData.data.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.05,
                                vertical: Get.height * 0.015),
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: Get.height * 0.005,
                              );
                            },
                            itemBuilder: (context, index) {
                              YoutubePlayerController youTubeController =
                                  YoutubePlayerController(
                                initialVideoId: YoutubePlayer.convertUrlToId(
                                    videoListController
                                        .videoData.data[index].videoUrl)!,
                                flags: const YoutubePlayerFlags(
                                    autoPlay: false,
                                    mute: false,
                                    showLiveFullscreenButton: false),
                              );

                              return Container(
                                decoration: BoxDecoration(
                                  color: ThemeManager().getWhiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.025,
                                  vertical: Get.width * 0.02,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(7),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          YoutubePlayer(
                                            controller: youTubeController,
                                            showVideoProgressIndicator: true,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return VideoPlaying(
                                                      youTubeController);
                                                },
                                              ));
                                              // youTubeController.play();
                                              // print("youTubeController ==> ${youTubeController}");
                                              // setState(() {});
                                            },
                                            child: youTubeController
                                                        .value.isReady ==
                                                    true
                                                ? const SizedBox()
                                                : Image.asset(
                                                    "assets/icon/play_button.png",
                                                    height: Get.width * 0.12,
                                                    width: Get.width * 0.12,
                                                    fit: BoxFit.fill,
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    ///---------------Video------------------

                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: Get.height * 0.015),
                                      child: SizedBox(
                                        width: Get.width * 0.8,
                                        child: Text(
                                          videoListController.videoData
                                              .data[index].description,
                                          style: poppinsRegular.copyWith(
                                            fontSize: Get.width * 0.035,
                                            color: ThemeManager()
                                                .getLightGreyColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ]),
              ),
            ],
          ),
          selectedFirstIndex == 0
              ? Positioned(
                  bottom: Get.height * 0.015,
                  right: Get.width * 0.035,
                  child: FloatingActionButton(
                    onPressed: () {
                      Get.to(() => const CreatePostScreen());
                    },
                    backgroundColor: ThemeManager().getThemeGreenColor,
                    child: Icon(
                      Icons.add,
                      size: Get.width * 0.065,
                      color: ThemeManager().getWhiteColor,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
