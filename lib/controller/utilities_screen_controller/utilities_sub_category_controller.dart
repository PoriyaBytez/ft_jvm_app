import 'package:get/get.dart';
import '../../services/api_services.dart';

class UtilitiesSubCategoryController extends GetxController{
  APIServices apiServices = APIServices();
  RxList utilitiesSubCategoryList = [].obs;
  RxBool isLoading = false.obs;

  getUtilitiesSubCategory(dataId) async {
    isLoading = true.obs;
    utilitiesSubCategoryList.clear();
    var data = await apiServices.getUtilitiesSubcategory(dataId);
    utilitiesSubCategoryList.addAll(data);
    isLoading = false.obs;
    super.onInit();
  }
}