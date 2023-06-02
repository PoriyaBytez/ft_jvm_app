import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePostController extends GetxController {
  RxList<File> mediaFiles = <File>[].obs;

  TextEditingController postController = TextEditingController();
  RxList postList = [
    {
      "postImage": "assets/icon/photos.png",
      "postName": "Photos",
    },
    {
      "postImage": "assets/icon/photos.png",
      "postName": "Video",
    },
  ].obs;

////==============add post==============
  Future<bool> postData(
      {List<File>? files,
      String? description,
      String? custId,
      String? uploadType}) async {
    const url = 'https://jymnew.spitel.com/api/post/';
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      "description": description ?? "",
      "cust_id": custId ?? "",
      "upload_type": uploadType ?? "",
    });
    print("files ==> $files");
    for (var i = 0; i < files!.length; i++) {
      final file = await http.MultipartFile.fromPath('post_file', files[i].path);
      request.files.add(file);
    }

    final response = await request.send();
    if (response.statusCode == 200) {

      Get.back();
      print('Success!');
      return true;

    } else {
      print('Error: ${response.statusCode}');
      return false;

    }
  }

}
