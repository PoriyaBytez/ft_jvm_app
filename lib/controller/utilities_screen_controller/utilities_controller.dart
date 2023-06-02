import 'package:get/get.dart';
import '../../services/api_services.dart';

class UtilitiesController extends GetxController{
  APIServices apiServices = APIServices();
  RxList utilitiesList = [].obs;
  RxBool isLoading = false.obs;
  // List h = List.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
  Future getUtilitiesData(dataBody) async {
    isLoading = true.obs;
    utilitiesList.clear();
    var data = await apiServices.getUtilitiesData(dataBody);
    utilitiesList.addAll(data);
    isLoading = false.obs;
    Get.forceAppUpdate();
  }
}