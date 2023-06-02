import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../models/news_model/punya_tithi_model.dart';
import '../services/api_services.dart';

class PunyaTithiController extends GetxController {
  RxBool isLoading = false.obs;
  RxList punyaTithiList = [].obs;

  @override
  void getPunyatithi(punayTithiBody) async {
    isLoading = true.obs;
    punyaTithiList.clear();
    APIServices apiServices = APIServices();
    PunyaTithi punyaTithi = await apiServices.getPunyaTithi(punayTithiBody);
    print("data ==> ${punyaTithi.members}");
    // List<PunyaTithi> temList = data;
    punyaTithiList.addAll(punyaTithi.members as Iterable);
    print(punyaTithiList);
    isLoading = false.obs;
    print("data  ==> ${isLoading}");
    super.onInit();
  }
}