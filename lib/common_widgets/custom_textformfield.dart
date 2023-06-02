import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jym_app/utils/theme_manager.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final TextStyle? mainTextStyle, hintStyle, labelStyle;
  final Widget? prefix, prefixIcon, suffixIcon;
  final String? hintText, labelText;
  final FormFieldValidator? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final bool? readOnly;
  final TextInputAction? textInputAction;

  const CustomTextFormField({
    Key? key,
    this.controller,
    this.readOnly,
    this.validator,
    this.contentPadding,
    this.keyboardType,
    this.mainTextStyle,
    this.hintStyle,
    this.labelStyle,
    this.prefix,
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
    this.hintText,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.textInputAction,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: widget.textInputAction,
      controller: widget.controller,
      readOnly: widget.readOnly ?? false,
      style: widget.mainTextStyle,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      decoration: InputDecoration(
        prefix: widget.prefix,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
        labelStyle: widget.labelStyle,
        contentPadding: widget.contentPadding,
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
