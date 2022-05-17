import 'package:flutter/material.dart';


const textInputDecoration = InputDecoration(
  hintText: '',
  hintStyle: TextStyle(
    color: Color(0xFF5D4037),
  ),
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFFD7CC8),
      width: 2.0
    )
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
        color: Color(0xFF5D4037),
        width:2.0
    )
  )
);