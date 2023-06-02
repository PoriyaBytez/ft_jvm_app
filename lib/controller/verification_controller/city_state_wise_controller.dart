import 'package:get/get.dart';
import '../../services/api_services.dart';

class CityStateWiseController extends GetxController{
  RxBool isLoading = false.obs;
  RxList cityStateWiseList = [].obs;

  void cityStateWise(String stateId) async {
    isLoading = true.obs;
    cityStateWiseList.clear();
    APIServices apiServices = APIServices();
    var data = await apiServices.getCityByState(stateId);
    cityStateWiseList.addAll(data);
    isLoading = false.obs;
  }
}