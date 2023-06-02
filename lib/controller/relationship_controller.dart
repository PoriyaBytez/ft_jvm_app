import 'package:get/get.dart';
import 'package:jym_app/services/api_services.dart';

class RelationShipController extends GetxController{
  APIServices apiServices = APIServices();
  RxBool isLoading = false.obs;
  RxList relationShipList = [].obs;

  Future getRelationShip() async {
    isLoading = true.obs;
    relationShipList.clear();
    var data = await apiServices.getRelationShip();
    relationShipList.addAll(data);
    isLoading = false.obs;
    Get.forceAppUpdate();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getRelationShip();
    super.onInit();
  }
}