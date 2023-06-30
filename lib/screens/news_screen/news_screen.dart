import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controller/news_category_controller.dart';
import '../../controller/news_screen_controller/news_controller.dart';
import '../../models/news_category_model.dart';
import '../../services/api_services.dart';
import '../../utils/app_textstyle.dart';
import '../../utils/preferences.dart';
import '../../utils/theme_manager.dart';
import 'news_details_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late TabController subTabController;
  final Preferences _preferences = Preferences();
  final newsController = Get.find<NewsController>();
  final newsCategoryController = Get.put(NewsCategoryController());
  final newsSubCategoryController = Get.put(NewsSubCategoryController());
  List notificationList = [
    {
      "newImage": "assets/image/cloths.png",
      "newsHeadline":
          "मैनपुरी लोकसभा सीट पर 5 दिसंबर को उपचुनाव होना है. इस सीट से जहां सपा की ",
      "givenTime": "37 min ago",
      "timeToRead": "1 min read"
    },
    {
      "newImage": "assets/image/cloths.png",
      "newsHeadline":
          "भारत की इन खूबसूरत जगहों पर यूं ही नहीं घुस सकते हैं भारतीय, लेना पड़ता है परमिट",
      "givenTime": "10 min ago",
      "timeToRead": "1 min read"
    },
    {
      "newImage": "assets/image/cloths.png",
      "newsHeadline":
          "भारत की इन खूबसूरत जगहों पर यूं ही नहीं घुस सकते हैं भारतीय, लेना पड़ता है परमिट",
      "givenTime": "12 min ago",
      "timeToRead": "1 min read"
    },
    {
      "newImage": "assets/image/cloths.png",
      "newsHeadline":
          "भारत की इन खूबसूरत जगहों पर यूं ही नहीं घुस सकते हैं भारतीय, लेना पड़ता है परमिट",
      "givenTime": "12 min ago",
      "timeToRead": "1 min read"
    },
    {
      "newImage": "assets/image/cloths.png",
      "newsHeadline":
          "भारत की इन खूबसूरत जगहों पर यूं ही नहीं घुस सकते हैं भारतीय, लेना पड़ता है परमिट",
      "givenTime": "14 min ago",
      "timeToRead": "1 min read"
    },
    {
      "newImage": "assets/image/cloths.png",
      "newsHeadline":
          "भारत की इन खूबसूरत जगहों पर यूं ही नहीं घुस सकते हैं भारतीय, लेना पड़ता है परमिट",
      "givenTime": "20 min ago",
      "timeToRead": "1 min read"
    },
    {
      "newImage": "assets/image/cloths.png",
      "newsHeadline":
          "भारत की इन खूबसूरत जगहों पर यूं ही नहीं घुस सकते हैं भारतीय, लेना पड़ता है परमिट",
      "givenTime": "37 min ago",
      "timeToRead": "1 min read"
    },
    {
      "newImage": "assets/image/cloths.png",
      "newsHeadline":
          "भारत की इन खूबसूरत जगहों पर यूं ही नहीं घुस सकते हैं भारतीय, लेना पड़ता है परमिट",
      "givenTime": "37 min ago",
      "timeToRead": "1 min read"
    },
    {
      "newImage": "assets/image/cloths.png",
      "newsHeadline":
          "भारत की इन खूबसूरत जगहों पर यूं ही नहीं घुस सकते हैं भारतीय, लेना पड़ता है परमिट",
      "givenTime": "37 min ago",
      "timeToRead": "1 min read"
    },
  ];
  String newsCategoryId = "";
  RxList newSubcategoryList = [].obs;

  @override
  void initState() {
    newsController.getNews({
      "filter_from":
      "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day - DateTime.now().weekday % 7}",
      "filter_to":
          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
      "category_id": "",
      "sub_category_id": "",
      "city_id": _preferences.getCityId()
    });
    mainTabList.clear();
    NewsCategoryModel tempDataAdd = NewsCategoryModel(id: 0, name: "All");
    print(newsCategoryController.newsCategoryList[0].name);
    mainTabList.add(tempDataAdd);
    newsCategoryController.newsCategoryList
        .removeWhere((element) => element.name == "शोक संदेश");
    newsCategoryController.newsCategoryList
        .removeWhere((element) => element.name == "श्रद्धांजलि");
    mainTabList.addAll(newsCategoryController.newsCategoryList);
    _tabController = TabController(length: mainTabList.length, vsync: this);
    super.initState();
  }

  List<dynamic> mainTabList = [];
  int tabIndex = 0;

  String convertToAgo(String dateTime) {
    Duration diff = DateTime.now().difference(DateTime.parse(dateTime));

    if (diff.inDays >= 1) {
      return "${DateTime.now().difference(DateTime.parse(dateTime)).inDays.toString()} days ago";
    } else if (diff.inHours >= 1) {
      return "${DateTime.now().difference(DateTime.parse(dateTime)).inHours.toString()} hours ago";
    } else if (diff.inMinutes >= 1) {
      return "${DateTime.now().difference(DateTime.parse(dateTime)).inMinutes.toString()} minutes ago";
    } else if (diff.inSeconds >= 1) {
      return "${DateTime.now().difference(DateTime.parse(dateTime)).inSeconds.toString()} seconds ago";
    } else {
      return 'just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            color: ThemeManager().getWhiteColor,
            child: TabBar(
              onTap: (index) {
                print("object  => $index");
                tabIndex = index;
                if (index == 0) {
                  newsController.getNews({
                    "filter_from":
                        "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day - DateTime.now().weekday % 7}",
                    "filter_to":
                        "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
                    "category_id": "",
                    "sub_category_id": "",
                    "city_id": _preferences.getCityId()
                  });
                } else {
                  newsCategoryId = newsCategoryController
                      .newsCategoryList[index - 1].id
                      .toString();
                  newsController.getNews({
                    "filter_from":
                        "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day - DateTime.now().weekday % 7}",
                    "filter_to":
                        "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
                    "category_id": newsCategoryController
                        .newsCategoryList[index - 1].id
                        .toString(),
                    "sub_category_id": "",
                    "city_id": _preferences.getCityId()
                  }).then((value) {
                    for (var element in newsController.newsList) {
                      for (int i = 0;
                          i <
                              newsSubCategoryController
                                  .newsSubCategoryList.length;
                          i++) {
                        if (element.subCategoryId.toString() ==
                            newsSubCategoryController.newsSubCategoryList[i].id
                                .toString()) {
                          if (!newSubcategoryList.contains(
                              newsSubCategoryController
                                  .newsSubCategoryList[i])) {
                            newSubcategoryList.add(newsSubCategoryController
                                .newsSubCategoryList[i]);
                          }
                        }
                      }
                    }
                    subTabController = TabController(
                        length: newSubcategoryList.length, vsync: this);
                  });
                }
                setState(() {});
              },
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: UnderlineTabIndicator(
                insets: const EdgeInsets.only(left: 8),
                borderSide: BorderSide(
                    width: 5.0, color: ThemeManager().getThemeGreenColor),
              ),
              labelPadding: EdgeInsets.fromLTRB(16, 8, 8, 8),
              labelColor: ThemeManager().getBlackColor,
              unselectedLabelColor: ThemeManager().getBlackColor,
              labelStyle: poppinsSemiBold.copyWith(
                fontSize: Get.width * 0.038,
              ),
              unselectedLabelStyle: poppinsRegular.copyWith(
                fontSize: Get.width * 0.038,
              ),
              indicatorColor: ThemeManager().getThemeGreenColor,
              tabs: List.generate(mainTabList.length, (index) {
                return Tab(
                  text: mainTabList[index].name,
                );
              }),
            ),
          ),
          Container(
            color: ThemeManager().getLightGreyColor.withOpacity(0.2),
            height: 1,
            width: Get.width,
            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          ),

          /// ======================== all news

          Expanded(
            child: tabIndex == 0
                ? Obx(
                    () => newsController.isLoading.value == true &&
                            newsCategoryController.isLoading == true
                        ? Container(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              color: ThemeManager().getThemeGreenColor,
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(
                              left: Get.width * 0.05,
                              top: Get.height * 0.02,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Popular News",
                                  style: poppinsMedium.copyWith(
                                    fontSize: Get.width * 0.052,
                                    color: ThemeManager().getBlackColor,
                                  ),
                                ),
                                Expanded(
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      itemCount: newsController.newsList.length,
                                      padding: EdgeInsets.symmetric(
                                        vertical: Get.height * 0.025,
                                      ),
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                            height: Get.height * 0.02);
                                      },
                                      itemBuilder: (context, index) {
                                        // String category = "";
                                        // String subCategory = "";
                                        // for (int j = 0;
                                        //     j <
                                        //         newsCategoryController
                                        //             .newsCategoryList.length;
                                        //     j++) {
                                        //   if (newsController
                                        //           .newsList[index].categoryId
                                        //           .toString() ==
                                        //       newsCategoryController
                                        //           .newsCategoryList[j].id
                                        //           .toString()) {
                                        //     category = newsCategoryController
                                        //         .newsCategoryList[j].name;
                                        //     break;
                                        //   }
                                        // }
                                        // for (int i = 0;
                                        //     i <
                                        //         newsSubCategoryController
                                        //             .newsSubCategoryList.length;
                                        //     i++) {
                                        //   if (newsController
                                        //           .newsList[index].subCategoryId
                                        //           .toString() ==
                                        //       newsSubCategoryController
                                        //           .newsSubCategoryList[i].id
                                        //           .toString()) {
                                        //     subCategory =
                                        //         newsSubCategoryController
                                        //             .newsSubCategoryList[i]
                                        //             .name;
                                        //     break;
                                        //   }
                                        // }
                                        return GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              () => NewsDetailsScreen(
                                                  newsImage: mainUrl +
                                                      newsController
                                                          .newsList[index]
                                                          .bannerUrl,
                                                  newsTitle: newsController
                                                      .newsList[index].name,
                                                  newsPublishTime: convertToAgo(
                                                      newsController
                                                          .newsList[index]
                                                          .createdAt),
                                                  news: newsController
                                                      .newsList[index]
                                                      .description,
                                                  /*categoryTitle: category,
                                                  subCategoryTitle:
                                                      subCategory*/),
                                            );
                                          },
                                          child: Container(
                                            color: ThemeManager().getWhiteColor,
                                            child: Row(
                                              children: [
                                                newsController.newsList[index]
                                                                .bannerUrl !=
                                                            "" ||
                                                        newsController
                                                                .newsList[index]
                                                                .bannerUrl !=
                                                            null
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image.network(
                                                          "$mainUrl${newsController.newsList[index].bannerUrl}",
                                                          height:
                                                              Get.width * 0.2,
                                                          width:
                                                              Get.width * 0.2,
                                                          fit: BoxFit.fill,
                                                        ))
                                                    : Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: Get.width * 0.2,
                                                        width: Get.width * 0.2,
                                                        child: const Icon(
                                                            Icons.newspaper),
                                                      ),
                                                Container(
                                                  width: Get.width * 0.65,
                                                  margin: EdgeInsets.only(
                                                      left: Get.width * 0.05),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // Text(
                                                      //   category,
                                                      //   style: poppinsRegular
                                                      //       .copyWith(
                                                      //     fontSize:
                                                      //         Get.width * 0.035,
                                                      //     color: ThemeManager()
                                                      //         .getBlackColor,
                                                      //   ),
                                                      //   overflow: TextOverflow
                                                      //       .ellipsis,
                                                      // ),
                                                      // Text(
                                                      //   subCategory,
                                                      //   style: poppinsRegular
                                                      //       .copyWith(
                                                      //     fontSize:
                                                      //         Get.width * 0.035,
                                                      //     color: ThemeManager()
                                                      //         .getBlackColor,
                                                      //   ),
                                                      //   overflow: TextOverflow
                                                      //       .ellipsis,
                                                      // ),
                                                      Text(
                                                        newsController
                                                            .newsList[index]
                                                            .name,
                                                        style: poppinsMedium
                                                            .copyWith(
                                                          fontSize:
                                                              Get.width * 0.035,
                                                          color: ThemeManager()
                                                              .getBlackColor,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top:
                                                                    Get.height *
                                                                        0.0075),
                                                        child: Text(
                                                          convertToAgo(
                                                              newsController
                                                                  .newsList[
                                                                      index]
                                                                  .createdAt),
                                                          style: poppinsRegular
                                                              .copyWith(
                                                            fontSize:
                                                                Get.width *
                                                                    0.035,
                                                            color: ThemeManager()
                                                                .getLightGreyColor,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                  )
                : Container(
                    margin: EdgeInsets.only(
                      left: Get.width * 0.05,
                      top: Get.height * 0.02,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        newSubcategoryList.isEmpty
                            ? const Center(
                                child: Text("No results found.."),
                              )
                            : Container(
                                height: Get.height * 0.075,
                                width: Get.width,
                                color: ThemeManager().getWhiteColor,
                                child: TabBar(
                                  isScrollable: true,
                                  onTap: (index) {
                                    print("object  => $index");
                                    newsController.getNews({
                                      "filter_from":
                                          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day - DateTime.now().weekday % 7}",
                                      "filter_to":
                                          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
                                      "category_id": newsCategoryId,
                                      "sub_category_id":
                                          newsSubCategoryController
                                              .newsSubCategoryList[index].id
                                              .toString(),
                                      "city_id": _preferences.getCityId()
                                    });
                                    setState(() {});
                                  },
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  controller: subTabController,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  indicator: UnderlineTabIndicator(
                                    borderSide: BorderSide(
                                        width: 5.0,
                                        color:
                                            ThemeManager().getThemeGreenColor),
                                  ),
                                  labelPadding: const EdgeInsets.all(8),
                                  labelColor: ThemeManager().getBlackColor,
                                  unselectedLabelColor:
                                      ThemeManager().getBlackColor,
                                  labelStyle: poppinsSemiBold.copyWith(
                                    fontSize: Get.width * 0.038,
                                  ),
                                  unselectedLabelStyle: poppinsRegular.copyWith(
                                    fontSize: Get.width * 0.038,
                                  ),
                                  indicatorColor:
                                      ThemeManager().getThemeGreenColor,
                                  // tabs: List.generate(newsSubCategoryController.newsSubCategoryList.length, (index) {
                                  //   return Tab(text: newsSubCategoryController.newsSubCategoryList[index].name,
                                  //   );
                                  // }),
                                  tabs: List.generate(newSubcategoryList.length,
                                      (index) {
                                    return Tab(
                                      text: newSubcategoryList[index].name,
                                    );
                                  }),
                                ),
                              ),
                        Obx(
                          () => newSubcategoryList.isEmpty
                              ? Container(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(
                                    color: ThemeManager().getThemeGreenColor,
                                  ),
                                )
                              : Expanded(
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      itemCount: newsController.newsList.length,
                                      padding: EdgeInsets.symmetric(
                                        vertical: Get.height * 0.025,
                                      ),
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                            height: Get.height * 0.02);
                                      },
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              () => NewsDetailsScreen(
                                                newsImage: mainUrl +
                                                    newsController
                                                        .newsList[index]
                                                        .bannerUrl,
                                                newsTitle: newsController
                                                    .newsList[index].name,
                                                newsPublishTime: convertToAgo(
                                                    newsController
                                                        .newsList[index]
                                                        .createdAt),
                                                news: newsController
                                                    .newsList[index]
                                                    .description,
                                              ),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  mainUrl +
                                                      newsController
                                                          .newsList[index]
                                                          .bannerUrl,
                                                  height: Get.width * 0.2,
                                                  width: Get.width * 0.2,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Container(
                                                width: Get.width * 0.65,
                                                margin: EdgeInsets.only(
                                                    left: Get.width * 0.05),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      newsController
                                                          .newsList[index].name,
                                                      style: poppinsMedium
                                                          .copyWith(
                                                        fontSize:
                                                            Get.width * 0.035,
                                                        color: ThemeManager()
                                                            .getBlackColor,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: Get.height *
                                                              0.0075),
                                                      child: Text(
                                                        convertToAgo(
                                                            newsController
                                                                .newsList[index]
                                                                .createdAt),
                                                        style: poppinsRegular
                                                            .copyWith(
                                                          fontSize:
                                                              Get.width * 0.035,
                                                          color: ThemeManager()
                                                              .getLightGreyColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                        )
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
