import 'package:flutter/material.dart';
import 'package:food_saver/util/constant.dart';

Widget searchTextField(Function(String value) onChanged) {
  return TextField(
    autofocus: true, //Display the keyboard when TextField is displayed
    cursorColor: primary,
    style: const TextStyle(color: black, fontSize: textSizeNormal),
    textInputAction:
        TextInputAction.search, //Specify the action button on the keyboard
    decoration: const InputDecoration(
      //Style of TextField
      enabledBorder: UnderlineInputBorder(
        //Default TextField border
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: UnderlineInputBorder(
        //Borders when a TextField is in focus
        borderSide: BorderSide(color: primary),
      ),
      hintText: 'Rechercher', //Text that is displayed when nothing is entered.
      hintStyle: TextStyle(
        //Style of hintText
        color: primary,
        fontSize: textSizeNormal,
      ),
    ),
    onChanged: (String value) {
      onChanged.call(value);
    },
  );
}
