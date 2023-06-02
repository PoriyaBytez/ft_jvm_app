import 'package:get/get.dart';
import '../../services/api_services.dart';

class UtilitiesMainCategoryController extends GetxController{
  APIServices apiServices = APIServices();
  RxList utilitiesList = [].obs;
  RxBool isLoading = false.obs;

  @override
  onInit() async {
    isLoading = true.obs;
    utilitiesList.clear();
    var data = await apiServices.getUtilities();
    utilitiesList.addAll(data);
    isLoading = false.obs;
    super.onInit();
  }
}