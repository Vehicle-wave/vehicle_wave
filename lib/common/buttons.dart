import 'package:flutter/material.dart';

import 'constant.dart';

class WaveButton extends StatelessWidget {
  String buttonText;
  IconData? myicon;
  final VoidCallback? onPressedCallback;
  WaveButton(
      {Key? key,
      required this.buttonText,
      this.myicon,
      required this.onPressedCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            elevation: 10,
            backgroundColor: primaryColr),
        onPressed: onPressedCallback,
        child: Row(
          children: [
            Text(
              buttonText,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 5,
            ),
            if (myicon != null)
              Icon(
                myicon,
                color: Colors.white,
              )
          ],
        ));
  }
}
