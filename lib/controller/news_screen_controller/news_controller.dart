import 'package:jym_app/services/api_services.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  APIServices apiServices = APIServices();
  RxList newsList = [].obs;
  RxBool isLoading = false.obs;

  Future getNews(dataBody) async {
    print(dataBody);
    isLoading = true.obs;
    newsList.clear();
    var data = await apiServices.getNews(dataBody);
    newsList.addAll(data);
    print(newsList);
    isLoading = false.obs;
    Get.forceAppUpdate();
  }
}
