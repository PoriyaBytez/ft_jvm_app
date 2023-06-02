import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_textstyle.dart';
import '../utils/theme_manager.dart';

class CustomDropDownField extends StatefulWidget {
  final List<DropdownMenuItem>? items;
  final ValueChanged? onChanged;
  final String? labelText;
  final FormFieldValidator? validator;
  final dynamic value;

  const CustomDropDownField({
    Key? key,
    this.items,
    this.onChanged,
    this.labelText,
    this.validator,
    this.value,
  }) : super(key: key);

  @override
  State<CustomDropDownField> createState() => _CustomDropDownFieldState();
}

class _CustomDropDownFieldState extends State<CustomDropDownField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: widget.value,
      items: widget.items,
      validator: widget.validator,
      onChanged: widget.onChanged,
      icon: Image.asset(
        "assets/icon/down_arrow.png",
        height: 20,
        width: 22,
        fit: BoxFit.fill,
      ),
      decoration: InputDecoration(
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
    );
  }
}


