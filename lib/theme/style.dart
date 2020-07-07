import 'package:flutter/material.dart';

final Color whiteColor = Color(0xFFffffff);

final AutomaticNotchedShape tabsShape = AutomaticNotchedShape(
  RoundedRectangleBorder(
    side: BorderSide(),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(35.0),
      topRight: Radius.circular(35.0),
    ),
  ),
  StadiumBorder(
    side: BorderSide(),
  ),
);
