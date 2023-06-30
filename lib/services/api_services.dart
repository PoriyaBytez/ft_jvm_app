import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jym_app/models/blood_group_model.dart';
import 'package:jym_app/models/business_category_model.dart';
import 'package:jym_app/models/family_members_model/family_members_model.dart';
import 'package:jym_app/models/get_post.dart';
import 'package:jym_app/models/home_screen_model/advertisement_model.dart';
import 'package:jym_app/models/home_screen_model/birthday_new_model.dart';
import 'package:jym_app/models/home_screen_model/calendar_model.dart';
import 'package:jym_app/models/home_screen_model/video_list_model.dart';
import 'package:jym_app/models/news_category_model.dart';
import 'package:jym_app/models/patti_model.dart';
import 'package:jym_app/models/relationship_model.dart';
import 'package:jym_app/models/verification_screen_model/surname_model.dart';
import 'package:jym_app/screens/home_screen/home_screen.dart';
import 'package:jym_app/utils/preferences.dart';
import '../models/home_screen_model/anniversary_model.dart';
import '../models/home_screen_model/birthday_model.dart';
import '../models/matrimony_model/matrimony_model.dart';
import '../models/member_model.dart';
import '../models/news_model/punya_tithi_model.dart';
import '../models/news_model/news_model.dart';
import '../models/post_like_model.dart';
import '../models/utilities_model/utilities_main_category_model.dart';
import '../models/utilities_model/utilities_model.dart';
import '../models/utilities_model/utilities_sub_category_model.dart';
import '../models/verification_screen_model/city_model.dart';
import '../models/verification_screen_model/panth_model.dart';
import '../models/verification_screen_model/state_model.dart';
import '../models/verification_screen_model/user_data_model.dart';

String mainUrl = "https://jymnew.spitel.com";
String apiUrl = "https://jymnew.spitel.com/api";
String userName = "t2jymhbl";
  String password = "Ashok123";
String senderId = "AJYMIN";
String entityId = "1701159498384357810";
String templateID = "1707161788466826900";
String message = "Your One Time Password is";
Preferences _preferences = Preferences();

class APIServices {
  ///-------------Otp-------------------

  Future sendOtp(String mobileNumber) async {
    try {
      var response = await http.post(Uri.parse("$apiUrl/send-otp"), body: {
        "phone_no": mobileNumber,
      });
      return response;
    } catch (e) {
      print(e);
    }
  }

  ///-------------Third Party Otp-------------------

  Future sendUserOTP(String mobileNumber, String otp) async {
    try {
      var response = await http.get(Uri.parse(
          "http://websmsindia.net/api/swsendSingle.asp?username=$userName&password=$password&sender=$senderId&sendto=91$mobileNumber&entityID=$entityId&templateID=$templateID&message=$message \"$otp\" (AJYMIN)."));
      return response;
    } catch (e) {
      print(e);
    }
  }

  ///-------------Third Party Otp-------------------

  Future verifyOTP(String mobileNumber, String otp) async {
    var dataBody = {"phone_no": mobileNumber, "otp": otp};
    try {
      var response = await http.post(
          Uri.parse("$apiUrl/verify-otp"), body: dataBody);
      print("=============>${response.body}");
      return response;
    } catch (e) {
      print(e);
    }
  }

  ///-------------City-------------------

  Future getCity() async {
    try {
      var response = await http.get(Uri.parse("$apiUrl/get-cities"));
      if (response.statusCode == 200) {
        var result = json.decode(response.body);

        var data = result.map((e) => CityModel.fromJson(e)).toList();
        for (int i = 0; i < result.length; i++) {
          if (_preferences.getCityId() == result[i]["id"].toString()) {
            _preferences.setCityName(result[i]["city"]);
          }
        }
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  ///-------------City-------------------

  Future getCityByState(String stateId) async {
    try {
      var response = await http.post(Uri.parse("$apiUrl/get-cities-of-state"),
          body: {"state_id": stateId});
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = result.map((e) => CityModel.fromJson(e)).toList();
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  ///-------------State-------------------

  Future getState() async {
    try {
      var response = await http.get(Uri.parse("$apiUrl/get-state"));
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = result.map((e) => StateModel.fromJson(e)).toList();
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  ///_________________ uplosad image avtar _______________
  Future uploadImageAvtar(String image,) async {
    try {

      /*   var response = await http.post(
        Uri.parse(""),
        headers: {
          "Authorization": "Bearer ${_preferences.getToken()}",
        },
        body: dataBody,
      );*/
      Map<String, String> headers = {
        "Authorization": "Bearer ${_preferences.getToken()}"
      };
      final multipartRequest = http.MultipartRequest('POST',
          Uri.parse("https://jymnew.spitel.com/api/customer/upload-avtar"));
      multipartRequest.headers.addAll(headers);
      http.MultipartFile multipartFileIdFront =
      await http.MultipartFile.fromPath('avtar', image);

      multipartRequest.files.add(multipartFileIdFront);

      var response = await multipartRequest.send();
      if (kDebugMode) {
        print(response);
      }
      var responded = await http.Response.fromStream(response);
      final responseData = json.decode(responded.body);
      if (kDebugMode) {
        print(responseData);
      }
      return responseData;
    } catch (e) {
      print(e);
    }
  }

  ///-------------Insert User Data-------------------

  Future postUserData(dataBody,context) async {
    try {
      print(jsonEncode(dataBody));
      var response = await http.post(
        Uri.parse("$apiUrl/customer-register"),
        headers: {
          "Authorization": "Bearer ${_preferences.getToken()}",
        },
        body: dataBody,
      );
      log("Response================>${response.body}");
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = UserDataModel.fromJson(result);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your profile data updated")));
        return data;
      }
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data nnnnnnnnnnnnnnnnnnnn Edited")));

    } catch (e) {
      print(e);
    }
  }

  ///-------------UserData-------------------

  Future getUserData() async {
    try {
      print(Preferences().getToken());
      var response = await http.get(Uri.parse("$apiUrl/user"), headers: {
        "Authorization": "Bearer ${Preferences().getToken()}",
      });
      return response;
    } catch (e) {
      print(e);
    }
  }

  ///-------------Calendar-------------------

  Future getCalendar(String passedDate) async {
    try {
      var response = await http.get(Uri.parse(
          "https://jymnew.spitel.com/api/get-calendar-event?date=$passedDate"));
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = CalendarModel.fromJson(result);
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  ///-------------Panth-------------------

  Future getPanth() async {
    try {
      var response = await http.get(Uri.parse("$apiUrl/get-panth"));
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = result.map((e) => PanthModel.fromJson(e)).toList();
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  Future getSurname() async {
    try {
      var response = await http.get(Uri.parse("$apiUrl/get-surname"));
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = result.map((e) => SurNameModel.fromJson(e)).toList();
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  ///-------------Blood Group-------------------

  Future getBloodGroup() async {
    try {
      var response = await http.get(Uri.parse("$apiUrl/get-blood_group"));
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = result.map((e) => BloodGroupModel.fromJson(e)).toList();
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  ///-------------relationship-------------------

  Future getRelationShip() async {
    try {
      var response = await http.get(
          Uri.parse("https://jymnew.spitel.com/api/get-relationship"));
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = result.map((e) => RelationShipModel.fromJson(e)).toList();
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  ///-------------Advertisement-------------------

  Future getAdvertisement(dataBody) async {
    final uri = Uri.http("jymnew.spitel.com", "/api/advertisement", dataBody);
    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = result.map((e) => AdvertisementModel.fromJson(e)).toList();
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  ///-------------Posts from city-------------------

  Future getAllPostsByCity() async {
    try {
      var response = await http.get(Uri.parse(
          "https://jymnew.spitel.com/api/post/get-data?city_id=${_preferences.getCityId()}"));
      //  var response = await http.get(Uri.parse("https://jymnew.spitel.com/api/post/get-data"));
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = PostByIdModel.fromJson(result);
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  ///-------------Video-------------------

  Future getVideo() async {
    try {
      var response = await http.get(Uri.parse("$apiUrl/video"));
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = VideoModel.fromJson(result);
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  ///-------------News-------------------

  Future getNews(dataBody) async {
    final uri = Uri.http("jymnew.spitel.com", "/api/news", dataBody);
    try {
      var response = await http.get(uri);
      print("response code ==> ${response.statusCode}");
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = result.map((e) => NewsModel.fromJson(e)).toList();
        return data;
      }
    } catch (e) {
      print("error $e");
    }
  }

  ///-------------News Category & SubCategory-------------------

  Future getNewsCategory(String categoryType) async {
    try {
      var response = await http.get(
        Uri.parse("$apiUrl/news/$categoryType"),
        headers: {
          "Authorization": "Bearer ${_preferences.getToken()}",
        },
      );
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = result.map((e) => NewsCategoryModel.fromJson(e)).toList();
        return data;
      }
    } catch (e) {
      print(e);
    }
  }


  ///-------------punya tithi-------------------

  Future getPunyaTithi(punayTithiBody) async {
    print("_preferences.getCityId() ==> ${_preferences.getCityId()}");
    print("_preferences.getCityId() ==> ${punayTithiBody}");
    final uri = Uri.http("jymnew.spitel.com", "/api/get-expiry", punayTithiBody);

    var response = await http.get(uri);

    // var response = await http.get(Uri.parse("https://jymnew.spitel.com/api/get-expiry?city_id=${_preferences.getCityId()}"));//${_preferences.getCityId()} 28
    try {
      print("response code ==> ${response.statusCode}");
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        print("api data ==>$result");

        var data = PunyaTithi.fromJson(result);
        return data;
      }
    } catch (e) {
      print("error $e");
    }
  }
  ///-------------Anniversary-------------------

  Future getAnniversary(dateBody) async {
    final uri = Uri.http("jymnew.spitel.com", "/api/anniversary", dateBody);

    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = result.map((e) => AnniversaryModel.fromJson(e)).toList();
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  ///-------------BirthDay-------------------

  Future getBirthDay(dateBody) async {
    final uri = Uri.http("jymnew.spitel.com", "/api/birthday", dateBody);
    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = result.map((e) => BirthdayNewModel.fromJson(e)).toList();
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  ///-------------Matrimony-------------------

  Future getMatrimony() async {
    try {
      var response = await http.get(Uri.parse("$apiUrl/matrimony"),
        headers: {
          "Authorization": "Bearer ${_preferences.getToken()}",
        },
      );
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = MatrimonyModel.fromJson(result);
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  ///-------------------Utilities MainCategory-----------------------

  Future getUtilities() async {
    try {
      var response = await http.get(
        Uri.parse("$apiUrl/get-utilities-category"),
        headers: {
          "Authorization": "Bearer ${_preferences.getToken()}",
        },
      );
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = result.map((e) => UtilitiesMainCategoryModel.fromJson(e))
            .toList();
        print("data ==> $data");
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  ///-------------------Utilities SubCategory-----------------------

  Future getUtilitiesSubcategory(data) async {
    try {
      final uri = Uri.http("jymnew.spitel.com", "/api/get-utilities-sub-category", data);
      var response = await http.get(uri,
        headers: {
          "Authorization": "Bearer ${_preferences.getToken()}",
        },
      );
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = result.map((e) => UtilitiesSubCategory.fromJson(e))
            .toList();
        print("data ==> $data");
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  //---------------business categery
  Future getBusinessCategory() async {
    try {
      var response = await http.get(
        Uri.parse("$apiUrl/get-business-category"),
        headers: {
          "Authorization": "Bearer ${_preferences.getToken()}",
        },
      );
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = result.map((e) => BusinessCategory.fromJson(e)).toList();
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  ///---------------business patti
  Future getPatti() async {
    try {
      var response = await http.get(
        Uri.parse("$apiUrl/get-patti"),
        headers: {
          "Authorization": "Bearer ${_preferences.getToken()}",
        },
      );
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = result.map((e) => PattiModel.fromJson(e)).toList();
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  ///-------------------Utilities Data-----------------------

  Future getUtilitiesData(dataBody) async {
    final uri = Uri.http("jymnew.spitel.com", "/api/utilities", dataBody);
    try {
      var response = await http.get(uri,
        headers: {
          "Authorization": "Bearer ${_preferences.getToken()}",
        },
      );
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        print("result ==> ${result["data"]}");
        var data = result["data"].map((e) => UtilitiesModel.fromJson(e));
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  ///-------------------family member Data-----------------------

  Future getFamilyMember() async {
    try {
      var response = await http.get(
        Uri.parse("$apiUrl/family_member"),
        headers: {
          "Authorization": "Bearer ${_preferences.getToken()}",
        },
      );
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = result.map((e) => FamilyMembersModel.fromJson(e)).toList();
        return data;
      }
    } catch (e) {
      print(e);
    }
  }


  Future uploadPhoto ({String? pickedImage}) async {

    try {
      Map<String, String> headers = {
        "Authorization": "Bearer ${_preferences.getToken()}"
      };
      final multipartRequest = http.MultipartRequest('POST',
          Uri.parse("https://jymnew.spitel.com/api/upload-image"));
      multipartRequest.headers.addAll(headers);
      http.MultipartFile multipartFileIdFront =
      await http.MultipartFile.fromPath('avtar', pickedImage!);

      multipartRequest.files.add(multipartFileIdFront);

      var response = await multipartRequest.send();
      if (kDebugMode) {
        print("response $response");
      }
      var responded = await http.Response.fromStream(response);
      final responseData = json.decode(responded.body);
      if (kDebugMode) {
        print("responseData $responseData");
      }
      return responseData;
    } catch (e) {
      print(e);
    }
    // const url = 'https://jymnew.spitel.com/api/post/';
    // final request = http.MultipartRequest('POST', Uri.parse(url));
    // final file = await http.MultipartFile.fromPath('avtar', pickedImage);
    // request.files.add(file);
    // final response = await request.send();
  }
  ///-------------Insert User Data-------------------


  Future addFamilyOrMatrimonyData(dataBody) async {
    try {
      var response = await http.post(
        Uri.parse("$apiUrl/family_member/create"),
        headers: {
          "Authorization": "Bearer ${_preferences.getToken()}",
        },
        body: dataBody,
      );
      print("Response================>${response.body}");
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = UserDataModel.fromJson(result);
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  ///-----------------post delete
  Future deletePost(String id) async {
    try {
      var response = await http.get(
        Uri.parse("$apiUrl/post/delete/$id"),
        headers: {
          "Authorization": "Bearer ${_preferences.getToken()}",
        },
        // body: ,
      );
      print("Response================>${response.body}");
      if (response.statusCode == 200) {
        // var result = json.decode(response.body);
        // var data = UserDataModel.fromJson(result);
        return response.body;
      }
    } catch (e) {
      print(e);
    }
  }

  ///-----------------post like details post
  Future likeCountDetailsPost({
    required String postId,
    required String customerId,
    required bool isLiked
  }) async {
    print("isliked ==> $isLiked");
    int like = isLiked==true ? 1 : 0;
    // try {
      var response = await http.post(
        Uri.parse("$apiUrl/post/post-like?cust_id=$customerId&post_id=$postId&is_like=$like"),
        // body: {
        //   "cust_id" : customerId.toString(),
        //   "post_id" : postId.toString(),
        //   "is_like" : isLiked == true ? 1 : 0
        // },
      );
      print("Response================>${response.body}");
      if (response.statusCode == 200) {
      }
  }

  ///-----------------post like count
   Future likeCountPost(String postId) async {
    try {
      var response = await http.get(
        Uri.parse("$apiUrl/post/likes-list?post_id=$postId"),
      );
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        // var data = PostLike.fromJson(result);
        String data = result["count"].toString();
        // return PostLike.fromJson(result);
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  ///----------------- get member list
  Future getCustomerMember() async {
    final uri = Uri.http("jymnew.spitel.com", "/api/get-customer");
    try {
      var response = await http.get(uri);
      print("response.body ==> ${response.body}");
      print("response.code ==> ${response.statusCode}");

      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = result["data"].map((e) => MemberDetails.fromJson(e));
        print("result ==> ${result}");
        print("data ==> ${data}");
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

}
