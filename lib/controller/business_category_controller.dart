import 'package:get/get.dart';
import 'package:jym_app/services/api_services.dart';

class BusineCategoryController extends GetxController{
  RxBool isLoading = false.obs;
  RxList businessCategotyList = [].obs;

  APIServices apiServices = APIServices();

  @override
  void onInit() async {
    businessCategotyList.clear();
    isLoading = true.obs;
    var data = await apiServices.getBusinessCategory();
    businessCategotyList.addAll(data);
    isLoading = false.obs;
    Get.forceAppUpdate();
    super.onInit();
  }
}