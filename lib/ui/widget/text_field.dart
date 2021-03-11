import 'package:flutter/material.dart';
import 'package:navi_task/other/constants.dart';

Widget placeTextField(String hint, TextEditingController controller) {
  return Container(
    child: TextFormField(
      controller: controller,
      validator: (value) {
        if (value.isEmpty) return 'Please enter this field';
        return null;
      },
      cursorColor: kButtonColor,
      style: TextStyle(
          color: kTextColor2, fontSize: 18, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
          filled: true,
          hintText: hint,
          fillColor: Colors.white,
          hintStyle: TextStyle(color: kTextColor, fontSize: 18),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none),
    ),
  );
}
