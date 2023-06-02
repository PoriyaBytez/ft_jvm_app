import 'package:get/get.dart';
import 'package:jym_app/services/api_services.dart';

class PattiController extends GetxController{
  RxBool isLoading = false.obs;
  RxList pattiList = [].obs;

  APIServices apiServices = APIServices();

  @override
  void onInit() async {
    pattiList.clear();
    isLoading = true.obs;
    var data = await apiServices.getPatti();
    pattiList.addAll(data);
    isLoading = false.obs;
    Get.forceAppUpdate();
    super.onInit();
  }
}