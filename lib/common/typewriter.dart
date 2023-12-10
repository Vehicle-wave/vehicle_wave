import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class TypeWriter extends StatelessWidget {
  const TypeWriter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.0,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 26.0,
          fontWeight: FontWeight.w500,
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText('Be Our Pro Member'),
            TypewriterAnimatedText('Get More Additional Features'),
            TypewriterAnimatedText('Get 20% off on every shipment'),
            TypewriterAnimatedText('Give your vehicles a best Service'),
          ],
          repeatForever: true,
          onTap: () {
            print("Tap Event");
          },
        ),
      ),
    );
  }
}
