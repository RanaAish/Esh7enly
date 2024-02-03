// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names, file_names

import 'package:esh7enly/core/utils/colors.dart';

import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final double w;
  final TextInputType type;

  final VoidCallback OnTab;
  final hint;
  final IconData ic;
  final Color bordercolor;
  final double paddingright;
  final Color fillcolor;
  final controller;
  final bool valueread;
  final seen;
  final changed;
  final completetext;
  final obsesure;
  final dense;
  final EdgeInsets Padding;
  final suffic;
  final lines;
  final value;
  final bool enable;

  String _errorMessage(String str) {
    return translator.translate(  "required");
  }

  CustomTextField({
    this.hint,
    this.obsesure = false,
    this.lines = 1,
    this.enable = true,
    this.changed,
    this.seen,
    this.dense = false,
    this.value,
    this.valueread = false,
    this.bordercolor = Colors.grey,
    this.completetext,
  
    this.paddingright = 15,
    this.fillcolor = Colors.white,
    required this.OnTab,
    this.ic = Icons.person,
    this.suffic,
    this.w = 200,
    this.controller,
   
    this.Padding = const EdgeInsets.only(
      right: 15, // paddingright,
      left: 15,
      bottom: 10, //10
    ),
    this.type = TextInputType.text,

    
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
      
        if (hint != translator.translate("enter mob") &&
            hint != translator.translate("enter name") && hint != translator.translate("enter email")) {
          if (value!.isEmpty) {
            return _errorMessage(hint);
            // ignore: missing_return
          }
        }
        
        if (hint == translator.translate("enter email")&& controller.text.isNotEmpty || hint == translator.translate("em") 
        && controller.text.isNotEmpty) {
          final bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value!);
        
          if (!emailValid) return 'Not  vaild email';
        } 
          return null;
      },
      enabled: enable,
      controller: controller,
      obscureText: obsesure,
      onChanged: changed,
      maxLines: lines,
      initialValue: value,
      onTap: OnTab,
      readOnly: valueread,
      cursorColor: Colors.blue,
      keyboardType: type,
      onEditingComplete: completetext,
      
      decoration: InputDecoration(
        hintText: hint,
        isDense: dense,
        suffixIcon: suffic,

        // hintStyle: const TextStyle(fontWeight: FontWeight.bold),
        filled: true,

        contentPadding: Padding,

        fillColor: fillcolor,
        

        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: bordercolor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: CustomColors.MainColor)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: bordercolor)),
      ),
    );
  }
}
