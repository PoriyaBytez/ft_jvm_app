import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jym_app/screens/home_screen/create_post_controller.dart';
import 'package:jym_app/utils/preferences.dart';
import '../../utils/app_textstyle.dart';
import '../../utils/theme_manager.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  // photo and video only to be shown with space between

  final createPostController = Get.put(CreatePostController());
  bool postButton = false;

  Preferences _preferences = Preferences();

  Future<void> _pickImage() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select option for upload image"),
          actions: [
            TextButton(
                onPressed: () async {
                  final pickedFile =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  Navigator.pop(context);
                  if (pickedFile != null) {
                    createPostController.mediaFiles.add(File(pickedFile.path));
                    setState(() {
                      postButton = true;
                    });
                  }
                },
                child: const Text("Camera")),
            TextButton(
                onPressed: () async {
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  Navigator.pop(context);
                  if (pickedFile != null) {
                    createPostController.mediaFiles.add(File(pickedFile.path));
                    setState(() {
                      postButton = true;
                    });
                  }
                },
                child: const Text("Gallery")),
          ],
        );
      },
    );
  }

  Future<void> _pickVideo() async {
    final pickedFile =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      createPostController.mediaFiles.add(File(pickedFile.path));
    }
  }

  void _removeMedia(int index) {
    createPostController.mediaFiles.removeAt(index);
  }

  Widget _buildMediaItem(BuildContext context, int index) {
    final mediaFile = createPostController.mediaFiles[index];
    final isImage = mediaFile.path.endsWith('.jpg') ||
        mediaFile.path.endsWith('.jpeg') ||
        mediaFile.path.endsWith('.png');
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Image.file(
          mediaFile,
          width: 100,
          height: 100,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              _removeMedia(index);
              postButton = false;
              setState(() {});
            },
            child: const Icon(
              Icons.cancel_outlined,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    createPostController.mediaFiles.forEach((file) => file.delete());
    super.dispose();
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
          "Create Post",
          style: poppinsSemiBold.copyWith(
            fontSize: Get.width * 0.05,
            color: ThemeManager().getBlackColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            buildTextFormField(
                hintText: "Write somethings here.",
                maxLength: 200,
                maxLine: 5,
                controller: createPostController.postController),
            Obx(
              () => GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, crossAxisSpacing: 5, mainAxisSpacing: 5),
                shrinkWrap: true,
                itemCount: createPostController.mediaFiles.length,
                itemBuilder: _buildMediaItem,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: Get.width,
            height: Get.height * 0.06,
            margin: EdgeInsets.all(
              Get.width * 0.05,
            ),
            child: ElevatedButton(
              // onPressed: createPostController.postController.text.length > 9
              //     ? () {}
              //     : null,
              onPressed: () async {
                if(createPostController.mediaFiles.isNotEmpty) {
                  File f = File(createPostController.mediaFiles[0].path);
                  var s = f.lengthSync();
                  var fileSizeInKB = s / 1024;
                  // Convert the KB to MegaBytes (1 MB = 1024 KBytes)
                  var fileSizeInMB = fileSizeInKB / 1024;

                  if (fileSizeInMB < 5) {
                    createPostController.postData(
                        custId: _preferences.getUid().toString(),
                        description: createPostController.postController.text,
                        uploadType: "1",
                        files: createPostController.mediaFiles).then((value) {
                      if (value == true) {
                        Fluttertoast.showToast(
                            msg: "Post Sent Successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    });
                  } else {
                    showDialog(context: context, builder: (context) {
                      return const AlertDialog(title: Text("Please select image below of 5 MB"),);
                    },);
                    print("file can be selected");
                  }
                } else if(createPostController.mediaFiles.isEmpty){
                  createPostController.postData(
                      custId: _preferences.getUid().toString(),
                      description: createPostController.postController.text,
                      uploadType: "1",
                      ).then((value) {
                    if (value == true) {
                      Fluttertoast.showToast(
                          msg: "Post Sent Successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                  });
                }

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeManager().getThemeGreenColor,
                disabledBackgroundColor:
                    ThemeManager().getThemeGreenColor.withOpacity(0.57),
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
          postButton == false
              ? SizedBox(
                  height: Get.height * 0.05,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: createPostController.postList.length,
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: Get.width * 0.02,
                      );
                    },
                    itemBuilder: (context, index) {
                      print(
                          "object ==> ${createPostController.mediaFiles.length}");
                      return GestureDetector(
                        onTap: () {
                          // Focus.of(context).unfocus();
                          if (index == 0) {
                            _pickImage().then((value) {
                              if (createPostController.mediaFiles.isEmpty) {

                              }
                            });
                          } /*else {
                            _pickVideo().then((value) {
                              if (createPostController.mediaFiles.isEmpty) {
                                // setState(() {
                                //   postButton = true;
                                // });
                              }
                            });
                          }*/
                        },
                        child: Container(
                          height: Get.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1.2, color: Colors.black
                                // color: ThemeManager().getThemeGreenColor,
                                ),
                          ),
                          padding: EdgeInsets.all(Get.width * 0.02),
                          child: Row(
                            children: [
                              Image.asset(createPostController.postList[index]
                                  ["postImage"]),
                              Text(
                                createPostController.postList[index]
                                    ["postName"],
                                style: poppinsRegular.copyWith(
                                  fontSize: Get.width * 0.035,
                                  color: ThemeManager().getThemeGreenColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  TextFormField buildTextFormField(
      {String? hintText,
      TextEditingController? controller,
      int? maxLine,
      int? maxLength}) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText ?? "",
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.05,
          vertical: Get.width * 0.05,
        ),
      ),
      scrollPadding: const EdgeInsets.all(20.0),
      keyboardType: TextInputType.multiline,
      controller: controller,
      //max line 5
      maxLines: maxLine,
      //max word length
      maxLength: maxLength,
      autofocus: true,
    );
  }
}
