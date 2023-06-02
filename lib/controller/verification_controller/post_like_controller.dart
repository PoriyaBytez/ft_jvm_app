import 'package:get/get.dart';
import 'package:jym_app/services/api_services.dart';

import '../../models/post_like_model.dart';

class PostLikeController extends GetxController {

  PostLike postPostLike = PostLike();

  Future getPostLikeApi(String postId) async {
      APIServices apiServices = APIServices();
      // var data = await apiServices.likeCountPost(postId);

      // getLikeList.addAll(data);
      // print("getLikeList ==> ${getLikeList.length}");
      var data = await apiServices.likeCountPost(postId);
      postPostLike=data;
    }



}
