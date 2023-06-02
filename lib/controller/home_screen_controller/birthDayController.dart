import 'package:get/get.dart';
import '../../services/api_services.dart';

class BirthDayController extends GetxController{
  RxBool isLoading = false.obs;
  RxList birthDayList = [].obs;

  void getBirthDay(dateBody) async {
    print("birthday filter ==> ${dateBody}");
    isLoading = true.obs;
    birthDayList.clear();
    APIServices apiServices = APIServices();
    var data = await apiServices.getBirthDay(dateBody);
    birthDayList.addAll(data);
    print(birthDayList);
    isLoading = false.obs;
  }



  //check for birthday list
  // RxList birthdayList = [
  //   {
  //     "image": "https://img.freepik"
  //         ".com/free-photo/portrait-joyful-young-man-white-shirt_171337-17467.jpg?w=1060&t=st=1682961820~exp=1682962420~hmac=ee7692434d3543dd3ccb73685374f4bf71d274351dc7b18ed58497abb94026e7",
  //    "name": "Rameshbhai",
  //   },
  //   {
  //     "image":"https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?w=1060&t=st=1682961806~exp=1682962406~hmac=02addb210b4cacab182b80449779b65d97b7d2bd3e36058a7d90247ed522ff1d",
  //     "name":"Hirenbhai",
  //   },
  //   {
  //     "image":"https://images.unsplash"
  //         ".com/photo-1568602471122-7832951cc4c5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
  //     "name":"Deepbhai",
  //   },
  // ].obs;
}