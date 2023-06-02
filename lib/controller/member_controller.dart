import 'package:get/get.dart';
import 'package:jym_app/services/api_services.dart';

class MemberController extends GetxController {
  RxBool isLoading = false.obs;
  RxList memberList = [].obs;

  @override
  void onInit() async {
    isLoading = true.obs;
    memberList.clear();
    APIServices apiServices = APIServices();
    var data = await apiServices.getCustomerMember();
    memberList.addAll(data);
    isLoading = false.obs;
    Get.forceAppUpdate();
    super.onInit();
  }
}
