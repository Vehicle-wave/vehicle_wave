import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vehicle_wave/UI/Shipment_box.dart';
import 'package:vehicle_wave/UI/my_profile.dart';
import 'package:vehicle_wave/UI/profile_page.dart';
import 'package:vehicle_wave/UI/shipment_details.dart';
import 'package:vehicle_wave/pages/customerhomepage.dart';
import 'UI/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(VehicleWave());
}

class VehicleWave extends StatelessWidget {
  Color _primaryColor = HexColor('#360033');
  Color _accentColor = HexColor('#0b8793');

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'VehicleWave',
      theme: ThemeData(
        primaryColor: _primaryColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
            .copyWith(secondary: _accentColor),
      ),
      home: SplashScreen(title: 'Vehicle Wave'),
      routes: {
        '/Home': (context) => Chomepage(),
        '/Shipment': (context) => MyShipments(),
        '/Profile': (context) => MyProfile(),
      },
    );
  }
}

  // Design color
  // Color _primaryColor= HexColor('#FFC867');
  // Color _accentColor= HexColor('#FF3CBD');

  // Our Logo Color
  // Color _primaryColor= HexColor('#D44CF6');
  // Color _accentColor= HexColor('#5E18C8');

  // Our Logo Blue Color
  //Color _primaryColor= HexColor('#651BD2');
  //Color _accentColor= HexColor('#320181');

  // This widget is the root of your application.//