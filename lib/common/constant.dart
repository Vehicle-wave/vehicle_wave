import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Color primaryColr = HexColor('#360033');
Color accentColr = HexColor('#0b8793');
Gradient gradient = LinearGradient(
  colors: [
    primaryColr,
    accentColr
  ], // Replace with your desired gradient colors
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
