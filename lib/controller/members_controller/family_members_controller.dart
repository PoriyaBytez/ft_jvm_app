import 'package:get/get.dart';
import 'package:jym_app/services/api_services.dart';

class FamilyMembersController extends GetxController{
  APIServices apiServices = APIServices();
  RxList familyMembersList = [].obs;
  RxBool isLoading = false.obs;

  @override
  onInit() async {
    isLoading = true.obs;
    familyMembersList.clear();
    var data = await apiServices.getFamilyMember();
    familyMembersList.addAll(data);
    isLoading = false.obs;
    Get.forceAppUpdate();
    super.onInit();
  }
}