import 'package:get/get.dart';
import 'package:jym_app/services/api_services.dart';

class StateController extends GetxController {
  RxBool isLoading = false.obs;
  RxList stateList = [].obs;

  @override
  void onInit() async {
    isLoading = true.obs;
    stateList.clear();
    APIServices apiServices = APIServices();
    var data = await apiServices.getState();
    stateList.addAll(data);
    isLoading = false.obs;
    Get.forceAppUpdate();
    super.onInit();
  }
}
