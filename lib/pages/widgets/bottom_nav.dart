import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vehicle_wave/UI/Shipment_box.dart';
import 'package:vehicle_wave/UI/my_profile.dart';
import 'package:vehicle_wave/pages/customerhomepage.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  int indexx = 0;
  CustomBottomNavigationBar({Key? key, required this.indexx}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _pages = [Chomepage(), MyShipments(), MyProfile()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = widget.indexx;
  }

  void _onTapTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: HexColor('#360033'),
        selectedItemColor: HexColor('#0b8793'),
        unselectedItemColor: HexColor('#360033'),
        selectedIconTheme: IconThemeData(
          size: 30,
        ),
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        onTap: _onTapTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: 'Shipment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
