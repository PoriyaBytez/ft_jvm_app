import 'package:flutter/material.dart';

class ListViewCommon extends StatelessWidget {
   ListViewCommon({required this.listShow,this.onTapList,Key? key}) : super(key: key);
   List<dynamic> listShow = [];

   GestureTapCallback? onTapList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: listShow.length,/*searchList.isNotEmpty ? searchList.length : busineCategoryController
          .businessCategotyList.length,*/
      itemBuilder: (context, index) {
        var selectItem = listShow[index];
        return InkWell(
            onTap: () {
              Navigator.pop(context,index);
              // businessCategoryController.text = selectItem.name;
              // businessCategoryId = selectItem.id.toString();
            },
            child: Container(
              alignment:
              Alignment.centerLeft,
              height: 40,
              width: double.infinity,
              child: Text(
                  "${selectItem.name}",
                  style: const TextStyle(
                      fontSize: 14)),
            ));
      },
    );
  }
}
