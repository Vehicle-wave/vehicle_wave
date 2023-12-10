import 'dart:async';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vehicle_wave/UI/shipment_details.dart';
import 'package:vehicle_wave/common/constant.dart';

import '../common/buttons.dart';
import '../pages/widgets/bottom_nav.dart';
import '../pages/widgets/drawer.dart';
import '../pages/widgets/shipmentbox_widgets/status_widget.dart';

class MyShipments extends StatefulWidget {
  MyShipments({Key? key}) : super(key: key);

  @override
  State<MyShipments> createState() => _MyShipmentsState();
}

class _MyShipmentsState extends State<MyShipments> {
  bool isExpanded = false;

  void toggleCard() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  final _auth = FirebaseAuth.instance;
  StreamController<List<dynamic>> streamController =
      StreamController<List<dynamic>>();
  final ref = FirebaseDatabase.instance.ref('Shipment');

  int _currentIndex = 0;
  List<StreamSubscription<DatabaseEvent>?> streamSubscriptions =
      List.filled(5, null);
  void _onTabTapped(int index) {
    // Cancel previous stream subscription when switching tabs
    streamSubscriptions[_currentIndex]?.cancel();

    setState(() {
      _currentIndex = index; // Update the current tab index
    });

    // Create a new stream subscription for the selected tab
    streamSubscriptions[index] =
        _subscribeToShipmentStream(_getTabStatus(index));
  }

  String _getTabStatus(int index) {
    switch (index) {
      case 0:
        return 'submitted';
      case 1:
        return 'dispatched';
      case 2:
        return 'picked up';
      case 3:
        return 'delivered';
      case 4:
        return 'canceled';
      default:
        return 'submitted';
    }
  }

  StreamSubscription<DatabaseEvent> _subscribeToShipmentStream(String status) {
    return ref
        .child(_auth.currentUser!.uid)
        .orderByChild('status')
        .equalTo(status)
        .onValue
        .listen((snapshot) {
      // Handle the shipment data here
    });
  }

  final Gradient gradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [accentColr, primaryColr]);

  @override
  void initState() {
    streamSubscriptions[_currentIndex] =
        _subscribeToShipmentStream(_getTabStatus(_currentIndex));
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    for (var subscription in streamSubscriptions) {
      subscription?.cancel();
    }
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: false,
          appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColr, accentColr],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              actions: [],
              bottom: ButtonsTabBar(
                  radius: 12,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  borderWidth: 2,
                  borderColor: Colors.transparent,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF600088), // Deep purple
                      Color(0xFF360033), // Your original color
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )),
                  unselectedLabelStyle: TextStyle(color: Colors.black),
                  labelStyle: TextStyle(color: Colors.white),
                  height: 56,
                  onTap: _onTabTapped,
                  tabs: [
                    Tab(
                      child: Row(
                        children: [
                          Icon(Icons.pending_actions),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Submitted'),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: [
                          Icon(Icons.done),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Dispatched'),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: [
                          Icon(Icons.local_shipping_rounded),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Picked Up'),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: [
                          Icon(Icons.fact_check_sharp),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Delivered'),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: [
                          Icon(Icons.disabled_by_default),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Canceled'),
                        ],
                      ),
                    ),
                  ])),
          body: Container(
            color: Color.fromARGB(255, 252, 252, 252),
            child: TabBarView(children: [
              Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: ref
                          .child(_auth.currentUser!.uid)
                          .orderByChild('status')
                          .equalTo('submitted')
                          .onValue,
                      builder:
                          (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ListView.builder(
                              itemCount: 8,
                              itemBuilder: ((context, index) {
                                return Shimmer.fromColors(
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(40))),
                                            height: 300,
                                            width: 400,
                                            child: AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                margin: EdgeInsets.all(16.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white70,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                      offset: Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: Container(
                                                  height: 100,
                                                  width: 200,
                                                  child: Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey.shade700,
                                                    highlightColor:
                                                        Colors.grey.shade100,
                                                    child: Container(
                                                      height: 100,
                                                      width: 150,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                    baseColor: Colors.grey.shade700,
                                    highlightColor: Colors.grey.shade100);
                              }));
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData && !snapshot.hasData) {
                          return Container(child: Text('No SUbmitted Product'));
                        } else {
                          print('yes');
                          Map<dynamic, dynamic>? map = snapshot
                              .data?.snapshot.value as Map<dynamic, dynamic>?;
                          List<dynamic> list = map?.values.toList() ?? [];

                          return ListView.builder(
                              itemCount:
                                  snapshot.data!.snapshot.children.length,
                              itemBuilder: ((context, index) {
                                return AnimatedContainerWidget(
                                    shipmentData: list[index]);
                              }));
                        }
                      },
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: ref
                          .child(_auth.currentUser!.uid)
                          .orderByChild('status')
                          .equalTo('dispatched')
                          .onValue,
                      builder:
                          (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ListView.builder(
                              itemCount: 8,
                              itemBuilder: ((context, index) {
                                return Shimmer.fromColors(
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(40))),
                                            height: 300,
                                            width: 400,
                                            child: AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                margin: EdgeInsets.all(16.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white70,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                      offset: Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: Container(
                                                  height: 100,
                                                  width: 200,
                                                  child: Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey.shade700,
                                                    highlightColor:
                                                        Colors.grey.shade100,
                                                    child: Container(
                                                      height: 100,
                                                      width: 150,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                    baseColor: Colors.grey.shade700,
                                    highlightColor: Colors.grey.shade100);
                              }));
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData && !snapshot.hasData) {
                          return Container(child: Text('No dispatched order'));
                        } else {
                          print('yes');
                          Map<dynamic, dynamic>? map = snapshot
                              .data?.snapshot.value as Map<dynamic, dynamic>?;
                          List<dynamic> list = map?.values.toList() ?? [];

                          return ListView.builder(
                              itemCount:
                                  snapshot.data!.snapshot.children.length,
                              itemBuilder: ((context, index) {
                                return AnimatedContainerWidget(
                                    shipmentData: list[index]);
                              }));
                        }
                      },
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: ref
                          .child(_auth.currentUser!.uid)
                          .orderByChild('status')
                          .equalTo('picked up')
                          .onValue,
                      builder:
                          (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ListView.builder(
                              itemCount: 8,
                              itemBuilder: ((context, index) {
                                return Shimmer.fromColors(
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(40))),
                                            height: 300,
                                            width: 400,
                                            child: AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                margin: EdgeInsets.all(16.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white70,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                      offset: Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: Container(
                                                  height: 100,
                                                  width: 200,
                                                  child: Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey.shade700,
                                                    highlightColor:
                                                        Colors.grey.shade100,
                                                    child: Container(
                                                      height: 100,
                                                      width: 150,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                    baseColor: Colors.grey.shade700,
                                    highlightColor: Colors.grey.shade100);
                              }));
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData && !snapshot.hasData) {
                          return Container(child: Text('No Picked Up Order'));
                        } else {
                          print('yes');
                          Map<dynamic, dynamic>? map = snapshot
                              .data?.snapshot.value as Map<dynamic, dynamic>?;
                          List<dynamic> list = map?.values.toList() ?? [];

                          return ListView.builder(
                              itemCount:
                                  snapshot.data!.snapshot.children.length,
                              itemBuilder: ((context, index) {
                                return AnimatedContainerWidget(
                                    shipmentData: list[index]);
                              }));
                        }
                      },
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: ref
                          .child(_auth.currentUser!.uid)
                          .orderByChild('status')
                          .equalTo('delivered')
                          .onValue,
                      builder:
                          (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ListView.builder(
                              itemCount: 8,
                              itemBuilder: ((context, index) {
                                return Shimmer.fromColors(
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(40))),
                                            height: 300,
                                            width: 400,
                                            child: AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                margin: EdgeInsets.all(16.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white70,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                      offset: Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: Container(
                                                  height: 100,
                                                  width: 200,
                                                  child: Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey.shade700,
                                                    highlightColor:
                                                        Colors.grey.shade100,
                                                    child: Container(
                                                      height: 100,
                                                      width: 150,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                    baseColor: Colors.grey.shade700,
                                    highlightColor: Colors.grey.shade100);
                              }));
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData && !snapshot.hasData) {
                          return Container(child: Text('No Delived order'));
                        } else {
                          print('yes');
                          Map<dynamic, dynamic>? map = snapshot
                              .data?.snapshot.value as Map<dynamic, dynamic>?;
                          List<dynamic> list = map?.values.toList() ?? [];

                          return ListView.builder(
                              itemCount:
                                  snapshot.data!.snapshot.children.length,
                              itemBuilder: ((context, index) {
                                return AnimatedContainerWidget(
                                    shipmentData: list[index]);
                              }));
                        }
                      },
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: ref
                          .child(_auth.currentUser!.uid)
                          .orderByChild('status')
                          .equalTo('canceled')
                          .onValue,
                      builder:
                          (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ListView.builder(
                              itemCount: 8,
                              itemBuilder: ((context, index) {
                                return Shimmer.fromColors(
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(40))),
                                            height: 300,
                                            width: 400,
                                            child: AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                margin: EdgeInsets.all(16.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white70,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                      offset: Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: Container(
                                                  height: 100,
                                                  width: 200,
                                                  child: Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey.shade700,
                                                    highlightColor:
                                                        Colors.grey.shade100,
                                                    child: Container(
                                                      height: 100,
                                                      width: 150,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                    baseColor: Colors.grey.shade700,
                                    highlightColor: Colors.grey.shade100);
                              }));
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData && !snapshot.hasData) {
                          return Container(child: Text('No Canceled Order'));
                        } else {
                          print('yes');
                          Map<dynamic, dynamic>? map = snapshot
                              .data?.snapshot.value as Map<dynamic, dynamic>?;
                          List<dynamic> list = map?.values.toList() ?? [];

                          return ListView.builder(
                              itemCount:
                                  snapshot.data!.snapshot.children.length,
                              itemBuilder: ((context, index) {
                                return AnimatedContainerWidget(
                                    shipmentData: list[index]);
                              }));
                        }
                      },
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class AnimatedContainerWidget extends StatelessWidget {
  final Map<dynamic, dynamic> shipmentData;
  // final Function() onPressedCallback;

  AnimatedContainerWidget({
    required this.shipmentData,
    // required this.onPressedCallback,
  });

  @override
  Widget build(BuildContext context) {
    bool isStatusCanceled = shipmentData['status'] == 'canceled';
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8,
          top: 20,
          bottom: 20,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "OrderID:" + shipmentData['order id'],
                    style: TextStyle(
                        color: primaryColr,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Price: ${shipmentData['Price'].toString()}\$',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.redAccent),
                  )
                ],
              ),
              Divider(),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_sharp,
                          color: accentColr,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Pick up Location:',
                          style: TextStyle(fontSize: 14, color: primaryColr),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 180,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            shipmentData['pickup address'].toString(),
                            style: TextStyle(color: accentColr),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 7,
                  ),
                  Icon(
                    Icons.location_on_sharp,
                    color: accentColr,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Drop Off Location:',
                        style: TextStyle(fontSize: 14, color: primaryColr),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 180,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                shipmentData['dropff address'].toString(),
                                style: TextStyle(color: accentColr),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Divider(),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var vehicle in shipmentData['vehicleData'] ?? [])
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Text(
                                'VehicleType:',
                                style: TextStyle(color: primaryColr),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                vehicle['vehicleType'],
                                style: TextStyle(
                                    color: accentColr,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Status:',
                            style: TextStyle(color: primaryColr),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${shipmentData['status']}',
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              Divider(),
              if (!isStatusCanceled)
                Row(
                  children: [
                    WaveButton(buttonText: 'Track', onPressedCallback: () {}),
                    SizedBox(
                      width: 20,
                    ),
                    WaveButton(
                        buttonText: 'Check Driver', onPressedCallback: () {}),
                    SizedBox(
                      width: 20,
                    ),
                    WaveButton(
                      buttonText: 'Details',
                      myicon: Icons.navigate_next,
                      onPressedCallback: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    MyShipmentDetails(
                                      list: shipmentData,
                                    )));
                      },
                    )
                  ],
                ),
              Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${shipmentData['order_date']}'
                    " "
                    '${shipmentData['order_time']}', // Display the formatted posting time
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 10,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
