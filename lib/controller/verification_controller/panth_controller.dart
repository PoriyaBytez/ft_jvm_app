import 'package:get/get.dart';
import 'package:jym_app/services/api_services.dart';

class PanthController extends GetxController{
  RxBool isLoading = false.obs;
  RxList panthList = [].obs;
  APIServices apiServices = APIServices();

  @override
  void onInit() async {
    panthList.clear();
    isLoading = true.obs;
    var data = await apiServices.getPanth();
    panthList.addAll(data);
    isLoading = false.obs;
    Get.forceAppUpdate();
    super.onInit();
  }
}