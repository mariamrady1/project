import 'package:flutter/material.dart';

class DrawerModel {
  final IconData iconData; // Change type to IconData
  final String title;
  final void Function()? onPressed;

  DrawerModel({
    required this.iconData, // Change type to IconData
    required this.title,
    this.onPressed,
  });
}
