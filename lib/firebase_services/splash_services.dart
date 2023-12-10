import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_wave/UI/profile_page.dart';
import 'package:vehicle_wave/pages/bookshipment.dart';
import 'package:vehicle_wave/pages/customerhomepage.dart';
import 'package:vehicle_wave/pages/widgets/bottom_nav.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => CustomBottomNavigationBar(
                        indexx: 0,
                      )))));
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: ((context) => ProfilePage()))));
    }
  }
}
