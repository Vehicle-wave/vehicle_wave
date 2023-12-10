import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vehicle_wave/UI/aboutus.dart';
import 'package:vehicle_wave/UI/auth/login_page.dart';
import 'package:vehicle_wave/UI/forgot_password_page.dart';
import 'package:vehicle_wave/UI/forgot_password_verification_page.dart';
import 'package:vehicle_wave/UI/registration_page.dart';
import 'package:vehicle_wave/UI/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyDrawer extends StatelessWidget {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  MyDrawer({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;

  double _drawerIconSize = 24;
  double _drawerFontSize = 17;
  final Gradient gradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [HexColor('#0b8793'), HexColor('#360033')]);
  Future<DocumentSnapshot> fetchUserData() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userSnapshot =
          await usersCollection.doc(currentUser.uid).get();
      return userSnapshot;
    } else {
      // If the current user is null (not logged in), return an empty snapshot
      return Future.error('User not logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        FutureBuilder<DocumentSnapshot>(
            future: fetchUserData(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data!.get('email'));

                String name = snapshot.data!.get('firstName') ?? "";
                String email = snapshot.data!.get('email') ?? "";
                return UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage('assets/cont_image001.jpg')),
                  accountEmail: Text(email),
                  accountName: Text(
                    name,
                    style: TextStyle(fontSize: 24.0),
                  ),
                  decoration: BoxDecoration(
                    gradient: gradient,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return UserAccountsDrawerHeader(
                  currentAccountPicture: Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade100,
                      child: CircleAvatar()),
                  accountEmail: Shimmer.fromColors(
                    baseColor: Colors.grey.shade700,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 10,
                      width: 200,
                      color: Colors.white,
                    ),
                  ),
                  accountName: Shimmer.fromColors(
                    baseColor: Colors.grey.shade700,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 10,
                      width: 150,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                    gradient: gradient,
                  ),
                );
              }
            })),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text(
            'Profile',
            style: TextStyle(fontSize: 24.0),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => AboutUs()),
            );
          },
        ),
        Divider(),
        ListTile(
          leading: const Icon(Icons.message),
          title: const Text(
            'Messages',
            style: TextStyle(fontSize: 24.0),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => AboutUs()),
            );
          },
        ),
        Divider(),
        ListTile(
          leading: const Icon(Icons.phone_android),
          title: const Text(
            'Contact Us',
            style: TextStyle(fontSize: 24.0),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => AboutUs()),
            );
          },
        ),
        Divider(),
        ListTile(
          leading: const Icon(Icons.help_outlined),
          title: const Text(
            'Help',
            style: TextStyle(fontSize: 24.0),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => AboutUs()),
            );
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.logout_sharp),
          title: const Text(
            'Signout',
            style: TextStyle(fontSize: 24.0),
          ),
          onTap: () {
            _auth.signOut().then((value) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            });
          },
        ),
      ],
    ));
  }
}
