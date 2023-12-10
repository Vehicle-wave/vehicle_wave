import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vehicle_wave/pages/widgets/bottom_nav.dart';
import 'package:vehicle_wave/utils/upload_image.dart';

import '../common/constant.dart';
import '../pages/widgets/drawer.dart';
import '../pages/widgets/header_widget.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("My Profile",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24)),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [primaryColr, accentColr]),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            child: HeaderWidget(50, false, Icons.person_add_alt_1_rounded),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UploadImageScreen()));
                },
                child: CircleAvatar(
                  radius: 80,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 350,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: Bilal',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('Phone: 03154634123', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Text('Email: muhammadbilal63400@gmail.com',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
