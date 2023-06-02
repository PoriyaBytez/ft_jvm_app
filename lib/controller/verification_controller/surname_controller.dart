import 'package:get/get.dart';
import 'package:jym_app/services/api_services.dart';

class SurnameController extends GetxController {
  RxBool isLoading = false.obs;
  RxList surnameList = [].obs;

  @override
  void onInit() async {
    isLoading = true.obs;
    surnameList.clear();
    APIServices apiServices = APIServices();
    var data = await apiServices.getSurname();
    surnameList.addAll(data);
    isLoading = false.obs;
    Get.forceAppUpdate();
    super.onInit();
  }
}