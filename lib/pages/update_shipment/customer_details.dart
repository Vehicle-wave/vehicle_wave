import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vehicle_wave/UI/Shipment_box.dart';
import 'package:vehicle_wave/UI/shipment_details.dart';

import '../../common/constant.dart';
import '../../common/theme_helper.dart';

class EditDetailsScreen extends StatefulWidget {
  final String userId;
  final String orderId;
  final String customer_name;
  final String customer_email;
  final String customer_phone;
  final String estimatedPickup;
  final dynamic originalList;

  EditDetailsScreen(
      {Key? key,
      required this.originalList,
      required this.orderId,
      required this.userId,
      required this.customer_name,
      required this.customer_phone,
      required this.customer_email,
      required this.estimatedPickup})
      : super(key: key);

  @override
  State<EditDetailsScreen> createState() => _EditDetailsScreenState();
}

class _EditDetailsScreenState extends State<EditDetailsScreen> {
  DatabaseReference userRef = FirebaseDatabase.instance.ref('Shipment');

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController estimatedPickup = TextEditingController();
  DateTime selectedDate = DateTime.now();

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
    nameController.text = widget.customer_name;
    phoneController.text = widget.customer_phone;
    emailController.text = widget.customer_email;
    estimatedPickup.text = widget.estimatedPickup;
  }

  void updateData() {
    try {
      userRef.child(widget.userId).child(widget.orderId).update({
        'cutomer_name': nameController.text,
        'personal_phone': phoneController.text,
        'personal_email': emailController.text,
        'estimatedPickup': DateFormat('yyyy-MM-dd').format(selectedDate)
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => MyShipments())));
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
                            'Edit Customer Details',
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
                              "Please update your shipment details here if you're not interested simply go back from this screen",
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
                          'Enter Your Full Name',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            controller: nameController,
                            decoration:
                                ThemeHelper().textInputDecoration('', ""),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              final nameRegex = RegExp(r'^[a-zA-Z ]+$');

                              if (!nameRegex.hasMatch(value)) {
                                return 'Please enter a valid name';
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Your Personal Phone number',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: ThemeHelper()
                                .textInputDecoration('', "(123)1111 1234"),
                            validator: validatePhoneNumber,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Enter your Email',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            controller: emailController,
                            decoration: ThemeHelper()
                                .textInputDecoration('', "enter your Email"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Your Email';
                              }
                              final emailRegex = RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');

                              if (!emailRegex.hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Enter your Estimated Pickup',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColr,
                                    textStyle: TextStyle(fontSize: 15)),
                                onPressed: () async {
                                  final picker = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2030));

                                  if (picker != null) {
                                    setState(() {
                                      selectedDate = picker;
                                    });
                                  }

                                  // DatePicker.showDatePicker(context,
                                  //     showTitleActions: true,
                                  //     minTime: DateTime.now(),
                                  //     // maxTime: DateTime(DateTime.now().year,
                                  //     //         DateTime.now().month + 1, 1)
                                  //     //     .subtract(Duration(days: 1)),
                                  //     onConfirm: (date) {
                                  //   setState(() {
                                  //     selectedDate = date;
                                  //   });
                                  // },
                                  //     currentTime: selectedDate,
                                  //     locale: LocaleType.en);
                                },
                                child: Text('Select Date')),
                            SizedBox(
                              width: 25,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2, style: BorderStyle.solid)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(DateFormat('yyyy-MM-dd')
                                    .format(selectedDate)
                                    .toString()),
                              ),
                            ),
                          ],
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
