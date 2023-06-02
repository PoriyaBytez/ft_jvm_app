import 'package:get/get.dart';
import 'package:jym_app/models/get_post.dart';
import 'package:jym_app/screens/home_screen/home_screen.dart';
import 'package:jym_app/services/api_services.dart';

import '../verification_controller/post_like_controller.dart';

class AdvertisementController extends GetxController{
  APIServices apiServices = APIServices();
  RxBool isLoading = false.obs;
  List advertisementList=[];
  Future getAdvertisement(dataBody) async {
    advertisementList.clear();
    isLoading = true.obs;
    var data = await apiServices.getAdvertisement(dataBody);
    advertisementList.addAll(data);
    // print("advertisementList==> ${advertisementList[0]}");
    isLoading = false.obs;
    update(["update"]);
    update();
    Get.forceAppUpdate();
  }
  PostByIdModel postByIdModel = PostByIdModel();
  List<PostByIdModel> getPostByCityIdList = [];
  Future getPostByCityIdApi() async {
    var data = await apiServices.getAllPostsByCity();

    postByIdModel=data;

    print(postByIdModel.posts?.length);

    update(["update"]);
  }

}