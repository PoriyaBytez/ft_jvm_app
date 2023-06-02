import 'package:get/get.dart';
import 'package:jym_app/services/api_services.dart';

class VideoListController extends GetxController{
  APIServices apiServices = APIServices();
  var videoData;
  RxBool isLoading = false.obs;

  @override
  onInit() async {
    isLoading = true.obs;
    if(videoData != null){
      videoData = {};
    }
    var data = await apiServices.getVideo();
    videoData = data;
    isLoading = false.obs;
    super.onInit();
  }
}