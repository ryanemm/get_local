import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return Container(
    child: AppBar(
      title: const Text("Chatz"),
      elevation: 0,
      centerTitle: false,
    ),
  );
}

TextStyle simpleTextStyle(Color color) {
  return TextStyle(color: color, fontSize: 16);
}

InputDecoration textFieldInputDecoration(String hintText, Icon prefixIcon) {
  return InputDecoration(
      hintText: hintText,
      prefixIcon: prefixIcon,
      hintStyle: const TextStyle(color: Colors.grey),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 0, 23, 226)),
          borderRadius: BorderRadius.all(Radius.circular(32))),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(32))));
}
