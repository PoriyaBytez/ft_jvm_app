import 'package:get/get.dart';
import '../services/api_services.dart';

class NewsCategoryController extends GetxController{
  bool isLoading = false;
  APIServices apiServices = APIServices();
  List newsCategoryList = [];

  @override
  void onInit() async {
    newsCategoryList.clear();
    isLoading = true;
    var data = await apiServices.getNewsCategory("category");
    newsCategoryList.addAll(data);
    isLoading = false;
    super.onInit();
  }
}

class NewsSubCategoryController extends GetxController{
  bool isLoading = false;
  APIServices apiServices = APIServices();
  List newsSubCategoryList = [];

  @override
  void onInit() async {
    newsSubCategoryList.clear();
    isLoading = true;
    var data = await apiServices.getNewsCategory("sub-category");
    newsSubCategoryList.addAll(data);
    isLoading = false;
    super.onInit();
  }
}