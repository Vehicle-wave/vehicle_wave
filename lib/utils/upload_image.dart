import 'package:flutter/material.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image"),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: 200,
            child: Center(child: Icon(Icons.account_circle_outlined)),
          ),
          SizedBox(
            height: 39,
          )
        ],
      ),
    );
  }
}
