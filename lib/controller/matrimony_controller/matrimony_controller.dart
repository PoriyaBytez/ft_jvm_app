import 'package:get/get.dart';
import '../../services/api_services.dart';

class MatrimonyController extends GetxController{
  RxBool isLoading = false.obs;
  APIServices apiServices = APIServices();
  RxList matrimonyMaleList = [].obs;
  RxList matrimonyFeMaleList = [].obs;

  Future getMatrimony() async {
    matrimonyMaleList.clear();
    matrimonyFeMaleList.clear();
    isLoading = true.obs;
    var fullData = await apiServices.getMatrimony();
    for(int i=0; i<fullData.data.length; i++){
      if(fullData.data[i].gender == "1"){
        matrimonyMaleList.add(fullData.data[i]);
      }else{
        matrimonyFeMaleList.add(fullData.data[i]);
      }
    }
    isLoading = false.obs;
    Get.forceAppUpdate();
  }
}