import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:vehicle_wave/UI/Shipment_box.dart';
import 'package:vehicle_wave/UI/shipment_details.dart';

import '../../common/constant.dart';
import '../../common/theme_helper.dart';

class EditAddressDetails extends StatefulWidget {
  final String userId;
  final String orderId;
  final String pickUp_contact;
  final String dropOff_contact;
  final dynamic originalList;

  EditAddressDetails(
      {Key? key,
      required this.originalList,
      required this.orderId,
      required this.userId,
      required this.pickUp_contact,
      required this.dropOff_contact})
      : super(key: key);

  @override
  State<EditAddressDetails> createState() => _EditAddressDetailsState();
}

class _EditAddressDetailsState extends State<EditAddressDetails> {
  DatabaseReference userRef = FirebaseDatabase.instance.ref('Shipment');

  TextEditingController pickupcontactController = TextEditingController();
  TextEditingController dropoffcontactController = TextEditingController();

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    String numericValue = value.replaceAll(RegExp(r'\D'), '');
    if (numericValue.length != 11 || !numericValue.startsWith('03')) {
      return 'Invalid phone number';
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    pickupcontactController.text = widget.pickUp_contact;
    dropoffcontactController.text = widget.dropOff_contact;
  }

  void updateData() {
    try {
      userRef.child(widget.userId).child(widget.orderId).update({
        'pickup contact': pickupcontactController.text,
        'drop off contact': dropoffcontactController.text,
      });
      print('Data updated successfully');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data updated successfully'),
          duration: Duration(seconds: 2), // Adjust the duration as needed
        ),
      );
    } catch (error) {
      print('Error updating data: $error');
    }
  }

  // Fetch data from Firebase Realtime Database

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
          gradient: gradient,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: Builder(builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => MyShipmentDetails(
                        list: widget
                            .originalList, // Pass the original list data back to MyShipmentDetails
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              );
            }),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Container(
                decoration: BoxDecoration(
                  color: accentColr,
                  borderRadius: BorderRadius.circular(12),
                ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Edit Address Details',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
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
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  padding: EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Center(
                            child: Text(
                              "Address can't be Change if you want to then reorder, you can edit contacts ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Enter your PickUp contact',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                              controller: pickupcontactController,
                              decoration:
                                  ThemeHelper().textInputDecoration('', ""),
                              validator: validatePhoneNumber),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Your Dropoff Contact',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            controller: dropoffcontactController,
                            keyboardType: TextInputType.phone,
                            decoration: ThemeHelper()
                                .textInputDecoration('', "(123)1111 1234"),
                            validator: validatePhoneNumber,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                                backgroundColor: accentColr,
                                minimumSize: Size(130, 50),
                                elevation: 10),
                            onPressed: () => {
                              updateData(),
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MyShipmentDetails(
                                    list: widget
                                        .originalList, // Pass the original list data back to MyShipmentDetails
                                  ),
                                ),
                              )
                            },
                            child: const Text('Update'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
