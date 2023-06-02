import 'package:get/get.dart';
import 'package:jym_app/services/api_services.dart';

class CityController extends GetxController{
  RxBool isLoading = false.obs;
  RxList cityList = [].obs;
  RxList searchCityResultList = [].obs;
  APIServices apiServices = APIServices();

  @override
  void onInit() async {
    cityList.clear();
    isLoading = true.obs;
    var data = await apiServices.getCity();
    cityList.addAll(data);
    isLoading = false.obs;
    Get.forceAppUpdate();
    super.onInit();
  }
}