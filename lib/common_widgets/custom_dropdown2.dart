import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_textstyle.dart';
import '../utils/theme_manager.dart';

class CustomDropDownField2 extends StatefulWidget {
  // final List<dynamic>? itemsList;

  // final ValueChanged? onChanged;
  final String? labelText;
  final FormFieldValidator? validator;

  // final dynamic value;
  final GestureTapCallback? dropDownOnTap;
  final TextEditingController? controller;
  const CustomDropDownField2({
    Key? key,
    // this.itemsList,
    // this.onChanged,
    this.labelText,
    this.validator,
    // this.value,
    this.dropDownOnTap,
    this.controller,
  }) : super(key: key);

  @override
  State<CustomDropDownField2> createState() => _CustomDropDownField2State();
}

class _CustomDropDownField2State extends State<CustomDropDownField2> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(controller: widget.controller,
      onTap: widget.dropDownOnTap,
      readOnly: true,
      decoration: InputDecoration(
        suffixIcon: Image.asset(
          "assets/icon/down_arrow.png",
          height: 10,
          width: 10,
        ),
        labelText: widget.labelText,
        labelStyle: poppinsRegular.copyWith(
          color: ThemeManager().getLightGreyColor,
          fontSize: Get.width * 0.04,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(
            color: ThemeManager().getLightGreyColor,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(
            color: ThemeManager().getLightGreyColor,
            width: 0.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(
            color: ThemeManager().getLightGreyColor,
            width: 0.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(
            color: ThemeManager().getLightGreyColor,
            width: 0.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(
            color: ThemeManager().getLightGreyColor,
            width: 0.5,
          ),
        ),
      ),
      validator: widget.validator,
    );
  }
}
