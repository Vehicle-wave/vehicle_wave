import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vehicle_wave/UI/Shipment_box.dart';
import 'package:vehicle_wave/UI/track_order.dart';
import 'package:vehicle_wave/pages/bookshipment.dart';
import 'package:vehicle_wave/common/cards.dart';
import 'package:vehicle_wave/pages/widgets/bottom_nav.dart';
import 'package:vehicle_wave/pages/widgets/drawer.dart';
import 'package:vehicle_wave/common/typewriter.dart';
import 'package:vehicle_wave/pages/widgets/home_Icons.dart';

class Chomepage extends StatefulWidget {
  Chomepage({Key? key}) : super(key: key);

  @override
  State<Chomepage> createState() => _ChomepageState();
}

class _ChomepageState extends State<Chomepage> {
  final _auth = FirebaseAuth.instance;

  final Gradient gradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [HexColor('#0b8793'), HexColor('#360033')]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
          gradient: gradient,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          drawer: Drawer(
            child: MyDrawer(),
          ),
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Container(
                decoration: BoxDecoration(
                    color: HexColor('#360033'),
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi, VehicleWave User!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Text("Welcome",
                                      style: TextStyle(
                                          color: Colors.yellow.shade300,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    " to our App",
                                    style:
                                        TextStyle(color: Colors.grey.shade300),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60)),
                    ),
                    padding: EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text("What are you looking today?",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          Divider(),
                          SizedBox(
                            height: 20,
                          ),
                          SingleChildScrollView(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BookShipment()));
                                  },
                                  child: Column(
                                    children: [
                                      HomeIcon(
                                        MyImageIcon: 'assets/shipment.jpg',
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Book Shipment',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: HexColor('#360033'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TrackShipment()));
                                  },
                                  child: Column(
                                    children: [
                                      HomeIcon(
                                        MyImageIcon: 'assets/track.jpg',
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Track Order',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: HexColor('#360033')),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      HomeIcon(
                                        MyImageIcon: 'assets/pricecheck.jpg',
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Check Price',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: HexColor('#360033')),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Divider(),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 250,
                            width: 450,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 127, 126, 126)
                                        .withOpacity(1),

                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 0), // changes position of shadow
                                  ),
                                ],
                                image: DecorationImage(
                                    image: AssetImage('assets/propro.gif'),
                                    colorFilter: ColorFilter.mode(
                                      Colors.white.withOpacity(0.2),
                                      BlendMode.dstATop,
                                    ),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(20),
                                color: HexColor('#498FDD')),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TypeWriter(),
                                  Image(
                                    image: AssetImage('assets/pro.png'),
                                    height: 200,
                                    width: 200,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              'Our Services',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: HexColor('#360033'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          HorizontalCarousel(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
