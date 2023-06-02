import 'package:get/get.dart';
import '../services/api_services.dart';

class BloodGroupController extends GetxController{
  APIServices apiServices = APIServices();
  RxBool isLoading = false.obs;
  RxList bloodGroupList = [].obs;

  Future getBloodGroup() async {
    isLoading = true.obs;
    bloodGroupList.clear();
    var data = await apiServices.getBloodGroup();
    bloodGroupList.addAll(data);
    isLoading = false.obs;
    Get.forceAppUpdate();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getBloodGroup();
    super.onInit();
  }
}
