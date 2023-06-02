import 'package:get/get.dart';
import 'package:jym_app/services/api_services.dart';

class CalendarController extends GetxController{
  APIServices apiServices = APIServices();
  RxBool isLoading = false.obs;
  var calendarData;

  Future getCalendar(passedDate) async {
    isLoading = true.obs;
    if(calendarData != null){
      calendarData = {};
    }
    var data = await apiServices.getCalendar(passedDate);
    calendarData = data;
    isLoading = false.obs;
    Get.forceAppUpdate();
  }
}