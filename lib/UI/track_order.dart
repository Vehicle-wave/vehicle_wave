import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vehicle_wave/common/constant.dart';
import 'package:vehicle_wave/pages/customerhomepage.dart';
import 'package:vehicle_wave/pages/widgets/drawer.dart';

class TrackShipment extends StatefulWidget {
  TrackShipment({Key? key}) : super(key: key);

  @override
  State<TrackShipment> createState() => _TrackShipmentState();
}

class _TrackShipmentState extends State<TrackShipment> {
  final _auth = FirebaseAuth.instance;
  final Completer<GoogleMapController> _controllerGoogleMap =
      Completer<GoogleMapController>();
  GoogleMapController? newGoogleMapController;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.642556, 73.15067),
    zoom: 14.4746,
  );
  List<Marker> _marker = [];
  List<Marker> _list = const [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(30.642556, 73.15067),
        infoWindow: InfoWindow(title: 'My position')),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(32.642556, 74.15067),
        infoWindow: InfoWindow(title: 'my house'))
  ];
  final Gradient gradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [HexColor('#0b8793'), HexColor('#360033')]);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: primaryColr,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white, // Change this color to your desired color
              ),
            );
          },
        ),
        elevation: 0,
        actions: [
          // Container(
          //   decoration: BoxDecoration(
          //       color: HexColor('#360033'),
          //       borderRadius: BorderRadius.circular(12)),
          //   padding: EdgeInsets.all(10),
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => Chomepage()));
          //     },
          //     child: Icon(
          //       Icons.arrow_back_sharp,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
        ],
      ),
      body: Container(
        constraints: BoxConstraints(
            maxWidth: double.infinity, maxHeight: double.infinity),
        child: SafeArea(
          child: GoogleMap(
            initialCameraPosition: _kGooglePlex,
            markers: Set<Marker>.of(_marker),
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_disabled_outlined),
          onPressed: () async {
            GoogleMapController controller = await _controllerGoogleMap.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
              target: LatLng(32.642556, 74.15067),
              zoom: 14,
            )));
            setState(() {});
          }),
    );
  }
}
