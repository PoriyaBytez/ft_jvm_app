import 'package:get/get.dart';
import '../services/api_services.dart';

class UserDataController extends GetxController{
  RxBool isLoading = false.obs;
  APIServices apiServices = APIServices();
  var userData;

  void getUserData() async {
    isLoading = true.obs;
    if(userData != null){
      userData = {};
    }
    var data = await apiServices.getUserData();
    userData = data;
    isLoading = false.obs;
    Get.forceAppUpdate();
  }
}