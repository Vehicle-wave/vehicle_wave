import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_wave/UI/Shipment_box.dart';
import 'package:vehicle_wave/common/constant.dart';
import 'package:vehicle_wave/pages/customerhomepage.dart';
import 'package:vehicle_wave/pages/update_shipment/address_details.dart';
import 'package:vehicle_wave/pages/update_shipment/customer_details.dart';
import '../pages/widgets/bottom_nav.dart';
import '../pages/widgets/header_widget.dart';

User? user = FirebaseAuth.instance.currentUser;
String? userId = user?.uid;

class MyShipmentDetails extends StatelessWidget {
  final dynamic list;
  final DataSnapshot? snapshot;
  const MyShipmentDetails({Key? key, this.list, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseReference userRef = FirebaseDatabase.instance.ref('Shipment');
    Future<void> updateData(String orderID) async {
      try {
        final DatabaseReference shipmentRef =
            userRef.child(userId.toString()).child(orderID).child('status');
        await shipmentRef.set('canceled');
        print('Data updated successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Order Canceled'),
            duration: Duration(seconds: 2), // Adjust the duration as needed
          ),
        );
      } catch (error) {
        print('Error updating data: $error');
      }
    }

    bool isStatusSubmitted = list['status'] == 'submitted';
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: Container(
          decoration: BoxDecoration(gradient: gradient),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Padding(
              padding: const EdgeInsets.only(left: 60),
              child: Text(
                'Order Details',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            leading: Builder(builder: (BuildContext context) {
              return IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => CustomBottomNavigationBar(
                                  indexx: 1,
                                ))));
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ));
            }),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(100, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
                child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Text(
                        'Submitted Order',
                        style: TextStyle(
                            color: primaryColr,
                            fontWeight: FontWeight.w800,
                            fontSize: 20),
                      )),
                      Divider(),
                      Row(
                        children: [
                          Text(
                            'Price:',
                            style: TextStyle(
                                color: accentColr, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${list['Price'].toString()}\$',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(width: 10),
                          Text('Your payment for this shipment  (COD)',
                              style: TextStyle(color: Colors.red.shade200)),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Customer Details',
                            style: TextStyle(
                                color: accentColr, fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: accentColr,
                            ),
                            onPressed: () async {
                              final updatedData =
                                  await Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              EditDetailsScreen(
                                                orderId: list['order id'],
                                                userId: userId!,
                                                customer_email:
                                                    '${list['personal_email']}',
                                                customer_name:
                                                    '${list['cutomer_name']}',
                                                customer_phone:
                                                    '${list['personal_phone']}',
                                                estimatedPickup:
                                                    '${list['estimatedPickup']}',
                                                originalList: list,
                                              )));
                              if (updatedData != null) {}
                            },
                          )
                        ],
                      ),
                      Divider(
                        color: accentColr,
                        thickness: 2,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order ID:',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text('${list['order id']}')
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Cutomer Name:',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text('${list['cutomer_name']}')
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Email:',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text('${list['personal_email']}')
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phone:',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text('${list['personal_phone']}')
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Estimated Pickup:',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text('${list['estimatedPickup']}')
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Address Details',
                            style: TextStyle(
                                color: accentColr, fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: accentColr,
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          EditAddressDetails(
                                            orderId: list['order id'],
                                            userId: userId!,
                                            pickUp_contact:
                                                list['pickup contact'],
                                            dropOff_contact:
                                                list['drop off contact'],
                                            originalList: list,
                                          )));
                            },
                          )
                        ],
                      ),
                      Divider(
                        color: accentColr,
                        thickness: 2,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: primaryColr)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'PickUp Address:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Container(
                                    width: 180,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text('${list['pickup address']}')
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pick Up contact:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text('${list['pickup contact']}')
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pick up Type:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text('${list['pickup_location_type']}')
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: primaryColr)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Dropoff Address:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Container(
                                    width: 180,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text('${list['dropff address']}')
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Drop off Contact:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text('${list['drop off contact']}')
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Drop off Type:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text('${list['dropoff_location_type']}')
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Vehicle Details',
                        style: TextStyle(
                            color: accentColr, fontWeight: FontWeight.w500),
                      ),
                      Divider(
                        color: accentColr,
                        thickness: 2,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      for (var vehicle in list['vehicleData'] ?? [])
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: primaryColr)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        "Vehicle",
                                        style: TextStyle(
                                            color: primaryColr,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Make',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Container(
                                            width: 180,
                                            child: SingleChildScrollView(
                                                child: Text(
                                              '${vehicle['make']}',
                                              textAlign: TextAlign.right,
                                            )))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Model:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Container(
                                            width: 180,
                                            child: SingleChildScrollView(
                                                child: Text(
                                              '${vehicle['model']}',
                                              textAlign: TextAlign.right,
                                            )))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Type:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Container(
                                            width: 180,
                                            child: SingleChildScrollView(
                                                child: Text(
                                              '${vehicle['vehicleType']}',
                                              textAlign: TextAlign.right,
                                            )))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Year:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Container(
                                            width: 180,
                                            child: SingleChildScrollView(
                                                child: Text(
                                              '${vehicle['year']}',
                                              textAlign: TextAlign.right,
                                            )))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      Text(
                        'Other Details',
                        style: TextStyle(
                            color: accentColr, fontWeight: FontWeight.w500),
                      ),
                      Divider(
                        color: accentColr,
                        thickness: 2,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Condition:',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text('${list['Vehicle_runningcondition']}')
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Extras:',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text('${list['Inop_needs']}')
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Description:',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text('${list['description']}')
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                accentColr, // Change the button's background color
                            minimumSize: Size(
                                400, 40), // Set the minimum width and height
                            padding:
                                EdgeInsets.all(20), // Adjust padding as needed
                          ),
                          onPressed: () {
                            // showDialog(
                            //     context: context,
                            //     builder: (BuildContext contexy) {
                            //       return AlertDialog(
                            //         title: Text('Driver'),
                            //         content: Text('Waiting for dispatching'),
                            //         actions: [
                            //           TextButton(
                            //             onPressed: () {
                            //               Navigator.of(context).pop();
                            //             },
                            //             child: Text('Close'),
                            //           ),
                            //         ],
                            //       );
                            //     });


                            if(snapshot==null){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext contexy) {
                                    return AlertDialog(
                                      title: Text('Driver'),
                                      content: Text('Waiting for dispatching'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Close'),
                                        ),
                                      ],
                                    );
                                  });
                            }else{
                              if(snapshot!.exists){
                                showDialog(
                                    context: context,
                                    builder: (BuildContext contexy) {
                                      return AlertDialog(
                                        title: Text('Driver Details'),
                                        content: Container(
                                          height: 240,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Name',style: TextStyle(fontWeight: FontWeight.bold),),
                                                SizedBox(height: 5,),
                                                Text(snapshot!.child('driverName').value.toString(),),
                                                SizedBox(height: 5,),
                                                Text('Company',style: TextStyle(fontWeight: FontWeight.bold),),
                                                SizedBox(height: 5,),
                                                Text(snapshot!.child('companyName').value.toString(),),
                                                SizedBox(height: 5,),
                                                Text('Phone Number',style: TextStyle(fontWeight: FontWeight.bold),),
                                                SizedBox(height: 5,),
                                                Text(snapshot!.child('phoneNumber').value.toString(),),

                                                SizedBox(height: 5,),
                                                Text('Pickup Time',style: TextStyle(fontWeight: FontWeight.bold),),
                                                SizedBox(height: 5,),
                                                Text(snapshot!.child('pickupTime').value.toString(),),


                                                SizedBox(height: 5,),
                                                Text('Drop Time',style: TextStyle(fontWeight: FontWeight.bold),),
                                                SizedBox(height: 5,),
                                                Text(snapshot!.child('dropTime').value.toString(),),

                                              ],
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Ok',style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold
                                            ),),
                                          ),
                                        ],
                                      );
                                    });
                              }else{
                                showDialog(
                                    context: context,
                                    builder: (BuildContext contexy) {
                                      return AlertDialog(
                                        title: Text('Driver'),
                                        content: Text('Waiting for dispatching'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Close'),
                                          ),
                                        ],
                                      );
                                    });
                              }
                            }


                          },
                          child: Text(
                            'Check Driver',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                      Divider(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                primaryColr, // Change the button's background color
                            minimumSize: Size(
                                400, 40), // Set the minimum width and height
                            padding:
                                EdgeInsets.all(20), // Adjust padding as needed
                          ),
                          onPressed: () {},
                          child: Text(
                            'Check Status',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (isStatusSubmitted)
                            TextButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Canel Booking'),
                                          content: Text(
                                              'Are you sure to Cancel this booking?'),
                                          actions: [
                                            TextButton(
                                              child: Text("Cancel"),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                              },
                                            ),
                                            TextButton(
                                              child: Text(
                                                "OK",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MyShipments())); // Close the dialog
                                                updateData(list['order id']);
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Text(
                                  'Cancel Booking',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red),
                                )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

//  Text(
//                       'You have to pay  ${list['Price'].toString()}\$  for this shipment',
//                       style: TextStyle(color: Colors.red),
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),