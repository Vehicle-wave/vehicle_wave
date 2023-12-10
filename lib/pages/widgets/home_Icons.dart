import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeIcon extends StatefulWidget {
  final String MyImageIcon;
  final double iconSize;

  const HomeIcon({
    Key? key,
    required this.MyImageIcon,
    this.iconSize = 100,
  }) : super(key: key);

  @override
  State<HomeIcon> createState() => _HomeIconState();
}

class _HomeIconState extends State<HomeIcon> {
  bool _showIcon = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          decoration: BoxDecoration(
            color: HexColor('#360033'),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(230, 143, 143, 143)
                    .withOpacity(0.9), // color of the shadow
                spreadRadius: 3, // spread radius
                blurRadius: 5,
                // blur radius for the shadow
                offset: Offset(2, 2), // changes position of shadow
              ),
            ],
          ),
          child: Image(
            image: AssetImage(widget.MyImageIcon),
            height: widget.iconSize,
            width: widget.iconSize,
          )),
    );
  }
}
