import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:uuid/uuid.dart';
import 'package:vehicle_wave/UI/Shipment_box.dart';
import 'package:vehicle_wave/pages/widgets/bottom_nav.dart';
import 'package:vehicle_wave/utils/addressvalidator.dart';
import 'package:vehicle_wave/utils/utils.dart';
import '../../../common/constant.dart';
import 'package:date_range_form_field/date_range_form_field.dart';
import '../../../common/theme_helper.dart';
import 'dart:core';
import 'package:vehicle_wave/utils/distance_calculator.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../models/vehicle_make_model.dart';
import '../../../utils/order_id.dart';
import 'vehicle_class.dart';

// vehicle list
List<VehicleDetails> vehicleDetailsList = [VehicleDetails()];
//Adress Class
TextEditingController _pickupController = TextEditingController();
TextEditingController _dropoffController = TextEditingController();
TextEditingController _pickupcontactController = TextEditingController();
TextEditingController _dropoffcontactController = TextEditingController();
//Vehicle Details
TextEditingController _makeController = TextEditingController();
TextEditingController _modelController = TextEditingController();
TextEditingController _yearController = TextEditingController();
TextEditingController _vehicletypeController = TextEditingController();
//Personal Details
TextEditingController _nameController = TextEditingController();
TextEditingController _PphoneController = TextEditingController();
TextEditingController _PEmailController = TextEditingController();
DateTimeRange? myDateRange1;
final TextEditingController dropdownController = TextEditingController();
DateTime selectedDate = DateTime.now();
//Condition
String? _selectedOption;
String? _selectedSubOption;
String? _selectedPickLocation;
String? _selectedDropLocation;
String? distance;
final _describeController = TextEditingController();

class formkeys {
  static final _formKey = GlobalKey<FormState>();
  static final _formKey2 = GlobalKey<FormState>();
  static final _formKey3 = GlobalKey<FormState>();
  static final _formKey4 = GlobalKey<FormState>();
}

class FormSlider extends StatefulWidget {
  const FormSlider({Key? key}) : super(key: key);

  @override
  State<FormSlider> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<FormSlider> {
  int _currentStep = 0;
  final databaseRef = FirebaseDatabase.instance.ref('Shipment');

  final _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];
  //veriables

  void saveAddressToFirebase() {
    String pickupAddress = _pickupController.text.toString();
    String dropoffAddress = _dropoffController.text.toString();
    String pickupContactAddress = _pickupcontactController.text.toString();
    String dropoffContactAddress = _dropoffcontactController.text.toString();
    setState(() {
      loading = true;
    });
    databaseRef
        .child('1')
        .set({
          'pickup address': pickupAddress,
          'dropff address': dropoffAddress,
          'pickup contact': pickupContactAddress,
          'drop off contact': dropoffContactAddress,
        })
        .then((value) => {
              Utils().toastMessage('Data added'),
              setState(() {
                loading = false;
              })
            })
        .onError((error, stackTrace) => {
              Utils().toastMessage(error.toString()),
              setState(() {
                loading = false;
              })
            });
  }

  void saveVehicleDataToFirebase() {
    String make = _makeController.text.toString();
    String model = _modelController.text.toString();
    String year = _yearController.text.toString();
    String vehicle = _vehicletypeController.text.toString();
    setState(() {
      loading = true;
    });
    databaseRef
        .child('1')
        .set({
          'make': make,
          'model': model,
          'year': year,
          'vehicle': vehicle,
        })
        .then((value) => {
              Utils().toastMessage('Data added'),
              setState(() {
                loading = false;
              })
            })
        .onError((error, stackTrace) => {
              Utils().toastMessage(error.toString()),
              setState(() {
                loading = false;
              })
            });
  }

  bool loading = false;
  void savePersonalDataToFirebase() {
    String customername = _nameController.text.toString();
    String phone = _PphoneController.text.toString();
    String email = _PEmailController.text.toString();
    String estimatedPickup = myDateRange1.toString();

    setState(() {
      loading = true;
    });
    databaseRef
        .child('1')
        .set({
          'cutomer_name': customername,
          'personal_phone': phone,
          'personal_email': email,
          'estimated_pickup': estimatedPickup,
        })
        .then((value) => {
              Utils().toastMessage('Data added'),
              setState(() {
                loading = false;
              })
            })
        .onError((error, stackTrace) => {
              Utils().toastMessage(error.toString()),
              setState(() {
                loading = false;
              })
            });
  }

  void saveConditionToFirebase() {
    String pickuplocation = _selectedPickLocation.toString();
    String dropofflocation = _selectedDropLocation.toString();
    String condition = _selectedOption.toString();
    String extras = _selectedSubOption.toString();
    String description = _describeController.text.toString();
    setState(() {
      loading = true;
    });
    databaseRef
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        .set({
          'order id': DateTime.now().millisecondsSinceEpoch.toString(),
          'cutomer_name': _nameController.text.toString(),
          'personal_phone': _PphoneController.text.toString(),
          'personal_email': _PEmailController.text.toString(),
          'make': _makeController.text.toString(),
          'model': _modelController.text.toString(),
          'year': _yearController.text.toString(),
          'estimatedPickup': myDateRange1.toString(),
          'vehicle': _vehicletypeController.text.toString(),
          'pickup address': _pickupController.text.toString(),
          'dropff address': _dropoffController.text.toString(),
          'pickup contact': _pickupcontactController.text.toString(),
          'drop off contact': _dropoffcontactController.text.toString(),
          'pickup_location_type': pickuplocation,
          'dropoff_location_type': dropofflocation,
          'Vehicle_runningcondition': condition,
          'Inop_needs': extras,
          'description': description,
        })
        .then((value) => {
              Utils().toastMessage('Data added'),
              setState(() {
                loading = false;
              })
            })
        .onError((error, stackTrace) => {
              Utils().toastMessage(error.toString()),
              setState(() {
                loading = false;
              })
            });
  }

  _stepState(int step) {
    if (_currentStep > step) {
      return StepState.complete;
    } else {
      return StepState.editing;
    }
  }

  _steps() => [
        Step(
          title: const Text('Address'),
          content: _AddressForm(formKey: _formKeys[0]),
          state: _stepState(0),
          isActive: _currentStep == 0,
        ),
        Step(
          title: const Text('Vehicle Details'),
          content: _CardForm(formKey: _formKeys[1]),
          state: _stepState(1),
          isActive: _currentStep == 1,
        ),
        Step(
          title: const Text('Shipment details'),
          content: _ShipmentDetails(formKey: _formKeys[2]),
          state: _stepState(2),
          isActive: _currentStep == 2,
        ),
        Step(
          title: const Text('Condition'),
          content: Condition(formKey: _formKeys[3]),
          state: _stepState(3),
          isActive: _currentStep == 3,
        ),
        Step(
          title: const Text('Overview'),
          content: const _Overview(),
          state: _stepState(4),
        )
      ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stepper(
        physics: NeverScrollableScrollPhysics(),
        controlsBuilder: (BuildContext context, ControlsDetails controls) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: <Widget>[
                if (_currentStep != 4)
                  FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: HexColor('#0b8793'),
                        minimumSize: Size(130, 50),
                        elevation: 10),
                    onPressed: () => {
                      if (_currentStep == 0
                          ? formkeys._formKey.currentState!.validate()
                          : _currentStep == 1
                              ? formkeys._formKey2.currentState!.validate()
                              : _currentStep == 2
                                  ? formkeys._formKey3.currentState!.validate()
                                  : _currentStep == 3
                                      ? formkeys._formKey4.currentState!
                                          .validate()
                                      : false)
                        {
                          setState(() {
                            _currentStep += 1;
                          }),
                        }
                    },
                    child: const Text('SUBMIT'),
                  ),
                if (_currentStep != 0)
                  TextButton(
                    onPressed: controls.onStepCancel,
                    child: const Text(
                      'BACK',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
              ],
            ),
          );
        },
        onStepTapped: (step) => setState(
          () => {
            if (_currentStep == 0
                ? formkeys._formKey.currentState!.validate()
                : _currentStep == 1
                    ? formkeys._formKey2.currentState!.validate()
                    : _currentStep == 2
                        ? formkeys._formKey3.currentState!.validate()
                        : _currentStep == 3
                            ? formkeys._formKey4.currentState!.validate()
                            : false)
              {
                _currentStep = step,
              }
          },
        ),
        onStepContinue: () {
          setState(() {
            if (_currentStep < _steps().length - 1) {
              _currentStep += 1;
            } else {
              _currentStep = 0;
            }
          });
        },
        onStepCancel: () {
          setState(() {
            if (_currentStep > 0) {
              _currentStep -= 1;
            } else {
              _currentStep = 0;
            }
          });
        },
        currentStep: _currentStep,
        steps: _steps(),
      ),
    );
  }
}

class _AddressForm extends StatefulWidget {
  _AddressForm({Key? key, required GlobalKey<FormState> formKey})
      : super(key: key);

  @override
  State<_AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<_AddressForm> {
  var uuid = Uuid();
  String _sessionToken = '122344';
  bool _addressSelected = false;
  List<dynamic> _pickupPlaceList = [];
  List<dynamic> _dropoffPlaceList = [];
  bool _showPickupSuggestion = false;
  bool _showDropoffSuggestion = false;
  String test = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pickupController.addListener(() {
      onChanged(true);
    });
    _dropoffController.addListener(() {
      onChanged(false);
    });
  }

  void onChanged(bool isPickup) {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    if (isPickup) {
      getSuggestion(_pickupController.text, true);
      setState(() {
        _addressSelected = false;
        _showPickupSuggestion = true;
      });
    } else {
      getSuggestion(_dropoffController.text, false);
      setState(() {
        _addressSelected = false;
        _showDropoffSuggestion = true;
      });
    }
  }

  getSuggestion(String input, bool isPickup) async {
    String kPLACES_API_KEY = "AIzaSyDfBAN-K4V3bVXZuEThQRMfmWLDa9F06w8";
    final String country = 'PK';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&components=country:$country&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print(data);
    if (response.statusCode == 200) {
      setState(() {
        if (isPickup) {
          _pickupPlaceList =
              jsonDecode(response.body.toString())['predictions'];
        } else {
          _dropoffPlaceList =
              jsonDecode(response.body.toString())['predictions'];
        }
      });
    } else {
      throw Exception('failed');
    }
  }

  void clearSuggestion() async {
    setState(() {
      _pickupPlaceList.clear();
      _dropoffPlaceList.clear();
      _addressSelected = true;
      _showPickupSuggestion = false;
      _showDropoffSuggestion = false;
    });
    String pickupAddress = _pickupController.text;
    String dropoffAddress = _dropoffController.text;
    if (pickupAddress.isNotEmpty && dropoffAddress.isNotEmpty) {
      try {
        distance = await DistanceCalculator.calculateDistance(
            pickupAddress, dropoffAddress);
        print('Distance: $distance');
      } catch (e) {
        print('error');
      }
    }
  }

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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
            key: formkeys._formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'To',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showPickupSuggestion = true;
                    });
                  },
                  child: Container(
                    child: TextFormField(
                      controller: _pickupController,
                      decoration: ThemeHelper().textInputDecoration(
                          'pick up address', 'Enter your Pick Up address'),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Please enter an address';
                        }
                        if (value.length < 5) {
                          return 'Address must be at least 5 characters long';
                        }

                        // Check if the address contains alphanumeric characters, spaces, and certain special characters
                        RegExp addressRegex =
                            RegExp(r'^[a-zA-Z0-9\s\-\#\.\,\/]+$');
                        if (!addressRegex.hasMatch(value)) {
                          return 'Please enter a valid address containing letters, numbers, spaces, and certain special characters (e.g., - # . , /)';
                        }
                        return null;
                      },
                    ),
                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  ),
                ),
                if (_showPickupSuggestion)
                  Container(
                    height: 200,
                    child: ListView.builder(
                        itemCount: _pickupPlaceList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () async {
                              List<Location> locations =
                                  await locationFromAddress(
                                      _pickupPlaceList[index]['description']);
                              setState(() {
                                _pickupController.text =
                                    _pickupPlaceList[index]['description'];
                                clearSuggestion();
                              });
                            },
                            title: Text(_pickupPlaceList[index]['description']),
                          );
                        }),
                  ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: TextFormField(
                    controller: _pickupcontactController,
                    keyboardType: TextInputType.phone,
                    decoration: ThemeHelper().textInputDecoration(
                        'pick up contact', 'Contact at Pick Up '),
                    validator: validatePhoneNumber,
                  ),
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'From',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: TextFormField(
                    controller: _dropoffController,
                    decoration: ThemeHelper().textInputDecoration(
                        'Drop off address', 'Enter your Drop off address'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an address';
                      }
                      if (value.length < 5) {
                        return 'Address must be at least 5 characters long';
                      }

                      // Check if the address contains alphanumeric characters, spaces, and certain special characters
                      RegExp addressRegex =
                          RegExp(r'^[a-zA-Z0-9\s\-\#\.\,\/]+$');
                      if (!addressRegex.hasMatch(value)) {
                        return 'Please enter a valid address containing letters, numbers, spaces, and certain special characters (e.g., - # . , /)';
                      }
                      return null;
                    },
                  ),
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                ),
                if (_showDropoffSuggestion)
                  Container(
                    height: 200,
                    child: ListView.builder(
                        itemCount: _dropoffPlaceList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () async {
                              List<Location> locations =
                                  await locationFromAddress(
                                      _dropoffPlaceList[index]['description']);
                              print(locations.last.longitude);
                              print(locations.last.latitude);
                              setState(() {
                                _dropoffController.text =
                                    _dropoffPlaceList[index]['description'];
                                clearSuggestion();
                              });
                            },
                            title:
                                Text(_dropoffPlaceList[index]['description']),
                          );
                        }),
                  ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: TextFormField(
                    controller: _dropoffcontactController,
                    keyboardType: TextInputType.phone,
                    decoration: ThemeHelper().textInputDecoration(
                        'Drop off contact', 'Contact at Drop off '),
                    validator: validatePhoneNumber,
                  ),
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardForm extends StatefulWidget {
  _CardForm({
    Key? key,
    required GlobalKey<FormState> formKey,
  }) : super(key: key);

  @override
  State<_CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<_CardForm> {
  bool isMakeSelected = false;
  bool showError = false;
  void onAddVehicle() {
    setState(() {
      vehicleDetailsList
          .add(VehicleDetails()); // Add a new empty vehicle details object
    });
  }

  void getMakeSug(String make, int vehicleIndex) async {
    final url =
        'http://vpic.nhtsa.dot.gov/api/vehicles/getallmakes?format=json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> results = responseData['Results'];

      final List<VehicleMake> vehicleMakes =
          results.map((item) => VehicleMake.fromJson(item)).toList();
      final List<String> makeNames =
          vehicleMakes.map((make) => make.makeName).toList();

      final List<String> filteredMakes = makeNames
          .where(
              (makeName) => makeName.toLowerCase().contains(make.toLowerCase()))
          .toList();
      print('this output: $filteredMakes');
      setState(() {
        vehicleDetailsList[vehicleIndex].makes =
            filteredMakes; // Update the class-level makes variable
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  Future<List<String>> getModelsForMakeId(int makeId) async {
    final url =
        'https://vpic.nhtsa.dot.gov/api/vehicles/GetModelsForMakeId/$makeId?format=json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> results = responseData['Results'];

      final List<String> modelNames =
          results.map((item) => item['Model_Name']).cast<String>().toList();

      return modelNames;
    } else {
      print('Error: ${response.statusCode}');
      return [];
    }
  }

  Future<List<String>> getVehicleTypesForMake(String make) async {
    final url =
        'https://vpic.nhtsa.dot.gov/api/vehicles/GetVehicleTypesForMake/$make?format=json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> results = responseData['Results'];

      final List<String> vehicleTypes = results
          .map((item) => item['VehicleTypeName'])
          .cast<String>()
          .toList();

      return vehicleTypes;
    } else {
      print('Error: ${response.statusCode}');
      return [];
    }
  }

  Future<void> updateModelSuggestions(
      String selectedMake, int vehicleIndex) async {
    final url =
        'http://vpic.nhtsa.dot.gov/api/vehicles/getallmakes?format=json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> results = responseData['Results'];

      final selectedMakeData = results.firstWhere(
        (makeData) =>
            makeData['Make_Name'].toString().toLowerCase() ==
            selectedMake.toLowerCase(),
        orElse: () => null,
      );

      if (selectedMakeData != null) {
        final makeId = selectedMakeData['Make_ID'];
        final models = await getModelsForMakeId(makeId);
        print(models);
        setState(() {
          vehicleDetailsList[vehicleIndex].modelSuggestions =
              models; // Update model suggestions
        });
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  bool validateMake(String value, int vehicleIndex) {
    return vehicleDetailsList[vehicleIndex].makes.contains(value);
  }

  @override
  void initState() {
    super.initState();
  }

  void onChanged(String value, int vehicleIndex) async {
    print('onChnaged: $vehicleIndex+ $value');
    print(vehicleDetailsList[vehicleIndex].modelSuggestions);
    setState(() {
      vehicleDetailsList[vehicleIndex].selectedMake = value;
      showError = false;
      vehicleDetailsList[vehicleIndex].showMakeSuggestion = true;
      getMakeSug(value, vehicleIndex);
      isMakeSelected = validateMake(value, vehicleIndex);
      vehicleDetailsList[vehicleIndex].showModelSuggestion = true;
      vehicleDetailsList[vehicleIndex].showTypeSuggestions = true;

      // Call the API to get suggestions
    });

    updateModelSuggestions(value, vehicleIndex);
    final vehicleTypes = await getVehicleTypesForMake(value);
    setState(() {
      vehicleDetailsList[vehicleIndex].VehicleTypesList = vehicleTypes;
    });
    print(vehicleDetailsList[vehicleIndex]
        .modelSuggestions); // Fetch and update model suggestions
  }

  void onChangedModel(String value, int vehicleIndex) {
    print('onChangedModel: $value');
    print('no ${vehicleDetailsList.length}');
    setState(() {
      vehicleDetailsList[vehicleIndex].filteredModelSuggestions =
          vehicleDetailsList[vehicleIndex]
              .modelSuggestions
              .where((modelName) =>
                  modelName.toLowerCase().contains(value.toLowerCase()))
              .toList();
      vehicleDetailsList[vehicleIndex].showModelSuggestion = true;
    });
    print(vehicleDetailsList[vehicleIndex].filteredModelSuggestions);
  }

  void onSubmitted(String value, int vehicleIndex) {
    if (!vehicleDetailsList[vehicleIndex].makes.contains(value)) {
      setState(() {
        showError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
              key: formkeys._formKey2,
              child: Column(
                children: [
                  Column(
                    children: [
                      Text(
                        'Vehicle 1',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: HexColor('#360033')),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: TextFormField(
                          controller: vehicleDetailsList[0].makeController,
                          decoration: ThemeHelper().textInputDecoration(
                              'Make', "enter your vehicle's make"),
                          onChanged: (value) => onChanged(value, 0),
                          onFieldSubmitted: (value) => onSubmitted(value, 0),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter make of vehicle';
                            }
                            if (value.length < 2) {
                              return 'Make must be at least 2 characters long';
                            }

                            // Check if the make contains only alphabetic characters
                            RegExp makeRegex = RegExp(r'^[a-zA-Z]+$');
                            if (!makeRegex.hasMatch(value)) {
                              return 'Make must contain only letters';
                            }
                            return null;
                          },
                        ),
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      ),
                      if (vehicleDetailsList[0].showMakeSuggestion)
                        Container(
                          height: 200,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: vehicleDetailsList[0].makes.length,
                              itemBuilder: ((context, index) {
                                return ListTile(
                                    title: Text(
                                        vehicleDetailsList[0].makes[index]),
                                    onTap: () {
                                      setState(() {
                                        vehicleDetailsList[0].selectedMake =
                                            vehicleDetailsList[0].makes[index];
                                        showError = false;
                                        vehicleDetailsList[0]
                                                .makeController
                                                .text =
                                            vehicleDetailsList[0].selectedMake;
                                        vehicleDetailsList[0].makes.clear();
                                        vehicleDetailsList[0]
                                            .showMakeSuggestion = false;
                                      });
                                    });
                              })),
                        ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: TextFormField(
                          controller: vehicleDetailsList[0].modelController,
                          decoration: ThemeHelper().textInputDecoration(
                              'Model', "enter your vehicle's Model"),
                          onChanged: (value) => onChangedModel(value, 0),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Model of vehicle';
                            }
                            if (value.length < 2) {
                              return 'Vehicle model must be at least 2 characters long';
                            }

                            // Check if the vehicle model contains alphanumeric characters, spaces, and certain special characters
                            RegExp modelRegex =
                                RegExp(r'^[a-zA-Z0-9\s\-\#\.\,\/]+$');
                            if (!modelRegex.hasMatch(value)) {
                              return 'Please enter a valid vehicle model containing letters, numbers, spaces, and certain special characters (e.g., - # . , /)';
                            }
                            return null;
                          },
                        ),
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      ),
                      if (vehicleDetailsList[0].showModelSuggestion)
                        Container(
                          height: 200,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: vehicleDetailsList[0]
                                .filteredModelSuggestions
                                .length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(vehicleDetailsList[0]
                                    .filteredModelSuggestions[index]),
                                onTap: () {
                                  setState(() {
                                    vehicleDetailsList[0].selectedModel =
                                        vehicleDetailsList[0]
                                            .filteredModelSuggestions[index];
                                    vehicleDetailsList[0]
                                        .modelController
                                        .text = vehicleDetailsList[
                                            0]
                                        .selectedModel; // Set the selected suggestion as the text field value
                                    vehicleDetailsList[0]
                                        .filteredModelSuggestions
                                        .clear();
                                    vehicleDetailsList[0].showModelSuggestion =
                                        false;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: TextFormField(
                          controller: vehicleDetailsList[0].yearController,
                          keyboardType: TextInputType.datetime,
                          decoration: ThemeHelper().textInputDecoration(
                              'Year', "enter your vehicle's Year"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Year of vehicle';
                            }
                            int? year = int.tryParse(value);
                            if (year == null) {
                              return 'Please enter a valid year';
                            }

                            // Define the range of valid years (e.g., 1900 to current year)
                            int minYear = 1900;
                            int maxYear = DateTime.now().year;

                            // Check if the year is within the valid range
                            if (year < minYear || year > maxYear) {
                              return 'Please enter a valid vehicle year between $minYear and $maxYear';
                            }
                            return null;
                          },
                        ),
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: DropdownButtonFormField<String>(
                          value: vehicleDetailsList[0].typeVehicle,
                          items: [
                            'ATV',
                            'Boat',
                            'Car',
                            'Heavy Equipment',
                            'Large Yacht',
                            'Motorcycle',
                            'Pick Up',
                            'RV',
                            'SUV',
                            'Travel Trailer',
                            'Van',
                            'Other',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          decoration: ThemeHelper().textInputDecoration(
                              'Type', "Select your vehicle's type"),
                          onChanged: (newValue) {
                            setState(() {
                              vehicleDetailsList[0].typeVehicle = newValue!;
                            });
                          },
                        ),
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  for (int index = 1;
                      index < vehicleDetailsList.length;
                      index++)
                    Column(
                      children: [
                        Text(
                          'Vehicle ${index + 1}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: HexColor('#360033')),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: TextFormField(
                            controller:
                                vehicleDetailsList[index].makeController,
                            decoration: ThemeHelper().textInputDecoration(
                                'Make', "enter your vehicle's make"),
                            onChanged: (value) => onChanged(value, index),
                            onFieldSubmitted: (value) =>
                                onSubmitted(value, index),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter make of vehicle';
                              }
                              if (value.length < 2) {
                                return 'Make must be at least 2 characters long';
                              }

                              // Check if the make contains only alphabetic characters
                              RegExp makeRegex = RegExp(r'^[a-zA-Z]+$');
                              if (!makeRegex.hasMatch(value)) {
                                return 'Make must contain only letters';
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        if (vehicleDetailsList[index].showMakeSuggestion)
                          Container(
                            height: 200,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    vehicleDetailsList[index].makes.length,
                                itemBuilder: ((context, makeIndex) {
                                  return ListTile(
                                      title: Text(vehicleDetailsList[index]
                                          .makes[makeIndex]),
                                      onTap: () {
                                        setState(() {
                                          vehicleDetailsList[index]
                                                  .selectedMake =
                                              vehicleDetailsList[index]
                                                  .makes[makeIndex];
                                          showError = false;
                                          vehicleDetailsList[index]
                                                  .makeController
                                                  .text =
                                              vehicleDetailsList[index]
                                                  .selectedMake;
                                          vehicleDetailsList[index]
                                              .makes
                                              .clear();
                                          vehicleDetailsList[index]
                                              .showMakeSuggestion = false;
                                        });
                                      });
                                })),
                          ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: TextFormField(
                            controller:
                                vehicleDetailsList[index].modelController,
                            decoration: ThemeHelper().textInputDecoration(
                                'Model', "enter your vehicle's Model"),
                            onChanged: (value) => onChangedModel(value, index),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Model of vehicle';
                              }
                              if (value.length < 2) {
                                return 'Vehicle model must be at least 2 characters long';
                              }

                              // Check if the vehicle model contains alphanumeric characters, spaces, and certain special characters
                              RegExp modelRegex =
                                  RegExp(r'^[a-zA-Z0-9\s\-\#\.\,\/]+$');
                              if (!modelRegex.hasMatch(value)) {
                                return 'Please enter a valid vehicle model containing letters, numbers, spaces, and certain special characters (e.g., - # . , /)';
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        if (vehicleDetailsList[index].showModelSuggestion)
                          Container(
                            height: 200,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: vehicleDetailsList[index]
                                  .filteredModelSuggestions
                                  .length,
                              itemBuilder: (context, modelIndex) {
                                return ListTile(
                                  title: Text(vehicleDetailsList[index]
                                      .filteredModelSuggestions[modelIndex]),
                                  onTap: () {
                                    setState(() {
                                      vehicleDetailsList[index].selectedModel =
                                          vehicleDetailsList[index]
                                                  .filteredModelSuggestions[
                                              modelIndex];

                                      vehicleDetailsList[index]
                                          .modelController
                                          .text = vehicleDetailsList[
                                              index]
                                          .selectedModel; // Set the selected suggestion as the text field value
                                      vehicleDetailsList[index]
                                          .filteredModelSuggestions
                                          .clear();
                                      vehicleDetailsList[index]
                                          .showModelSuggestion = false;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: TextFormField(
                            controller:
                                vehicleDetailsList[index].yearController,
                            keyboardType: TextInputType.datetime,
                            decoration: ThemeHelper().textInputDecoration(
                                'Year', "enter your vehicle's Year"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Year of vehicle';
                              }
                              int? year = int.tryParse(value);
                              if (year == null) {
                                return 'Please enter a valid year';
                              }

                              // Define the range of valid years (e.g., 1900 to current year)
                              int minYear = 1900;
                              int maxYear = DateTime.now().year;

                              // Check if the year is within the valid range
                              if (year < minYear || year > maxYear) {
                                return 'Please enter a valid vehicle year between $minYear and $maxYear';
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: DropdownButtonFormField<String>(
                            value: vehicleDetailsList[index].typeVehicle,
                            items: <String>[
                              'ATV',
                              'Boat',
                              'Car',
                              'Heavy Equipment',
                              'Large Yacht',
                              'Motorcycle',
                              'Pick Up',
                              'RV',
                              'SUV',
                              'Travel Trailer',
                              'Van',
                              'Other',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            decoration: ThemeHelper().textInputDecoration(
                                'Type', "Select your vehicle's type"),
                            onChanged: (newValue) {
                              setState(() {
                                vehicleDetailsList[index].typeVehicle =
                                    newValue!;
                              });
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (index > 0)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                vehicleDetailsList.removeAt(
                                    index); // Remove the vehicle details at the specified index
                              });
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Remove Vehicle',
                                  style: TextStyle(color: Colors.red),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(HexColor('#3BA424'))),
                    onPressed: onAddVehicle,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Add Vehicle')
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(),
                ],
              ))
        ],
      ),
    );
  }
}

class _ShipmentDetails extends StatefulWidget {
  _ShipmentDetails({Key? key, required GlobalKey<FormState> formKey})
      : super(key: key);

  @override
  State<_ShipmentDetails> createState() => _ShipmentDetailsState();
}

class _ShipmentDetailsState extends State<_ShipmentDetails> {
  String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
              key: formkeys._formKey3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
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
                      controller: _nameController,
                      decoration: ThemeHelper()
                          .textInputDecoration('', "Your Full Name"),
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
                    'Enter your Estimated Pickup',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColr,
                                textStyle: TextStyle(fontSize: 15)),
                            onPressed: () {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  // maxTime: DateTime(DateTime.now().year,
                                  //         DateTime.now().month + 1, 1)
                                  //     .subtract(Duration(days: 1)),
                                  onConfirm: (date) {
                                setState(() {
                                  selectedDate = date;
                                  formattedDate = DateFormat('yyyy-MM-dd')
                                      .format(selectedDate);
                                });
                              },
                                  currentTime: selectedDate,
                                  locale: LocaleType.en);
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
                            child: Text(formattedDate),
                          ),
                        )
                      ],
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
                      controller: _PphoneController,
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
                      controller: _PEmailController,
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
                ],
              ))
        ],
      ),
    );
  }
}

class Condition extends StatefulWidget {
  Condition({Key? key, required GlobalKey<FormState> formKey})
      : super(key: key);

  @override
  State<Condition> createState() => _ConditionState();
}

class _ConditionState extends State<Condition> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
              key: formkeys._formKey4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Location Type for Pick-up'),
                  Row(
                    children: [
                      Radio<String>(
                          value: 'Residential',
                          groupValue: _selectedPickLocation,
                          onChanged: (value) {
                            setState(() {
                              _selectedPickLocation = value;
                            });
                          }),
                      Text('Residential'),
                      SizedBox(
                        width: 16,
                      ),
                      Radio<String>(
                          value: 'Non-residential',
                          groupValue: _selectedPickLocation,
                          onChanged: (value) {
                            setState(() {
                              _selectedPickLocation = value;
                            });
                          }),
                      Text('Non-res'),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Location Type for Dropoff'),
                  Row(
                    children: [
                      Radio<String>(
                          value: 'Residential',
                          groupValue: _selectedDropLocation,
                          onChanged: (value) {
                            setState(() {
                              _selectedDropLocation = value;
                            });
                          }),
                      Text('Residential'),
                      SizedBox(
                        width: 16,
                      ),
                      Radio<String>(
                          value: 'Non-residential',
                          groupValue: _selectedDropLocation,
                          onChanged: (value) {
                            setState(() {
                              _selectedDropLocation = value;
                            });
                          }),
                      Text('Non-res'),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Is your vehicle Operable?'),
                  Row(
                    children: [
                      Radio<String>(
                          value: 'Yes',
                          groupValue: _selectedOption,
                          onChanged: (value) {
                            setState(() {
                              _selectedOption = value;
                            });
                          }),
                      Text('Yes'),
                      SizedBox(
                        width: 16,
                      ),
                      Radio<String>(
                          value: 'No',
                          groupValue: _selectedOption,
                          onChanged: (value) {
                            setState(() {
                              _selectedOption = value;
                            });
                          }),
                      Text('No'),
                    ],
                  ),
                  if (_selectedOption == 'No')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('What do you need for vehicle?'),
                        Row(
                          children: [
                            Radio<String>(
                                value: 'wrench',
                                groupValue: _selectedSubOption,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedSubOption = value;
                                  });
                                }),
                            Text('Wrench'),
                            SizedBox(
                              width: 16.0,
                            ),
                            Radio<String>(
                                value: 'fork',
                                groupValue: _selectedSubOption,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedSubOption = value;
                                  });
                                }),
                            Text('Fork'),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Describe your vehicle Condition'),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            maxLines: 2,
                            controller: _describeController,
                            decoration: ThemeHelper().textInputDecoration(
                                'Short Description ',
                                "Describe your Vehicle's Condition"),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                      ],
                    )
                ],
              ))
        ],
      ),
    );
  }
}

class _Overview extends StatefulWidget {
  const _Overview({Key? key}) : super(key: key);

  @override
  State<_Overview> createState() => _OverviewState();
}

class _OverviewState extends State<_Overview> {
  User? user = FirebaseAuth.instance.currentUser;
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  final databaseRef = FirebaseDatabase.instance.ref('Shipment');
  bool loading = false;
  var SelectedPrice;
  double? value;
  double? _totalStprice;
  double? _totalStprice1;
  double? _totalStprice2;
  double? _totalStprice3;
  int? _totalOpenPrice;
  int? _totalClosedPrice;
  int? _expenditePrice;
  int? _expenditePrice1;

  void saveConditionToFirebase(String userId) {
    DateTime currentTime = DateTime.now();
    String pickuplocation = _selectedPickLocation.toString();
    String dropofflocation = _selectedDropLocation.toString();
    String condition = _selectedOption.toString();
    String extras = _selectedSubOption.toString();
    print(myDateRange1);
    String description = _describeController.text.toString();
    setState(() {
      loading = true;
    });
    _CardForm list = _CardForm(formKey: formkeys._formKey3);
    OrderIDGenerator orderIDGenerator = OrderIDGenerator();

    List<Map<String, dynamic>> vehicleDataList =
        vehicleDetailsList.map((details) {
      return {
        'make': details.makeController.text,
        'model': details.modelController.text,
        'year': details.yearController.text,
        'vehicleType': details.typeVehicle,
      };
    }).toList();
    DatabaseReference userRef = databaseRef.child(userId);
    userRef
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        .set({
          'order id': DateTime.now().millisecondsSinceEpoch.toString(),
          'cutomer_name': _nameController.text.toString(),
          'personal_phone': _PphoneController.text.toString(),
          'personal_email': _PEmailController.text.toString(),
          'vehicleData': vehicleDataList,
          'estimatedPickup': DateFormat('yyyy-MM-dd').format(selectedDate),
          'pickup address': _pickupController.text.toString(),
          'dropff address': _dropoffController.text.toString(),
          'pickup contact': _pickupcontactController.text.toString(),
          'drop off contact': _dropoffcontactController.text.toString(),
          'pickup_location_type': pickuplocation,
          'dropoff_location_type': dropofflocation,
          'Vehicle_runningcondition': condition,
          'Inop_needs': extras,
          'description': description,
          'Price': SelectedPrice,
          'order_date': DateFormat('yyyy-MM-dd').format(currentTime),
          'order_time': DateFormat('HH:mm').format(currentTime),
          'status': 'submitted',
          'load_id': orderIDGenerator.generateOrderID()
        })
        .then((value) => {
              Utils().toastMessage('Order Placed'),
              setState(() {
                loading = false;
              })
            })
        .onError((error, stackTrace) => {
              Utils().toastMessage(error.toString()),
              setState(() {
                loading = false;
              })
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = double.tryParse(distance!.replaceAll(RegExp('[^0-9.]'), ''));
    _totalStprice = value != null ? value! * 0.4 : null;
    _totalStprice1 = value != null ? value! * 0.48 : null;
    _totalStprice2 = value != null ? value! * 0.65 : null;
    _totalStprice3 = value != null ? value! * 0.8 : null;
    print('$_totalStprice');
    _totalOpenPrice = _totalStprice?.truncate();
    _totalClosedPrice = _totalStprice1?.truncate();
    _expenditePrice = _totalStprice2?.truncate();
    _expenditePrice1 = _totalStprice3?.truncate();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 2, 4, 9), // Starting color (e.g., blue)
                  Color.fromARGB(
                      255, 58, 59, 59), // Middle color (e.g., light blue)
                  Color.fromARGB(
                      255, 30, 52, 74), // Ending color (e.g., pale blue)
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    'Personal Details',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.orange.shade100),
                  )),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Customer Name:',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: HexColor('#FFFFFF')),
                        ),
                        Text(
                          _nameController.text,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Email:',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: HexColor('#FFFFFF')),
                        ),
                        Text(
                          _PEmailController.text,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Phone:',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: HexColor('#FFFFFF')),
                        ),
                        Text(
                          _PphoneController.text,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Text(
                    'Vehicle Details',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.orange.shade100),
                  )),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Make:',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: HexColor('#FFFFFF')),
                        ),
                        Text(
                          _makeController.text,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Model:',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: HexColor('#FFFFFF')),
                        ),
                        Text(
                          _modelController.text,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Year:',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: HexColor('#FFFFFF')),
                        ),
                        Text(
                          _yearController.text,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Type:',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: HexColor('#FFFFFF')),
                        ),
                        Text(
                          _vehicletypeController.text,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Text(
                    'Address Details',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.orange.shade100),
                  )),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'EstimatedPickup:',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: HexColor('#FFFFFF')),
                        ),
                        Text(
                          dropdownController.text,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pickup Address:',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: HexColor('#FFFFFF')),
                        ),
                        Text(
                          _pickupController.text,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pick up Contact:',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: HexColor('#FFFFFF')),
                        ),
                        Text(
                          _pickupcontactController.text,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pick Up Type:',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: HexColor('#FFFFFF')),
                        ),
                        Text(
                          '${_selectedPickLocation}',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dropoff Address:',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: HexColor('#FFFFFF')),
                        ),
                        Text(
                          _dropoffController.text,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dropoff Contact:',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: HexColor('#FFFFFF')),
                        ),
                        Text(
                          _dropoffcontactController.text,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dropoff Type:',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: HexColor('#FFFFFF')),
                        ),
                        Text(
                          '${_selectedDropLocation}',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Condition:',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: HexColor('#FFFFFF')),
                        ),
                        Text(
                          '${_selectedOption}',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Extras:',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: HexColor('#FFFFFF')),
                        ),
                        Text(
                          '${_selectedSubOption}',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Description:',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: HexColor('#FFFFFF')),
                        ),
                        Text(
                          _describeController.text,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(
                      horizontal: 30, vertical: 15), // Change padding
                ),
                backgroundColor:
                    MaterialStateProperty.all<Color>(HexColor('#0b8793')),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(100), // Change border radius
                    // Change border color
                  ),
                ),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                            'We have different prices for you according to your requirments.'),
                        content: Container(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Note:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey.shade700),
                                ),
                                Text(
                                  'Please click on your desired price to book your shipment. If you don\'t want then simply click on back ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey.shade800),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Standard',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: Colors.green.shade900),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Open',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.blueGrey.shade900),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      SelectedPrice = _totalOpenPrice;
                                      String userId = user!.uid;
                                      saveConditionToFirebase(userId);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  CustomBottomNavigationBar(
                                                    indexx: 1,
                                                  ))));
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                      230, 143, 143, 143)
                                                  .withOpacity(
                                                      0.9), // color of the shadow
                                              spreadRadius: 3, // spread radius
                                              blurRadius: 5,
                                              // blur radius for the shadow
                                              offset: Offset(2,
                                                  2), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.green.shade800),
                                      child: Center(
                                        child: Text(
                                          '$_totalOpenPrice \$',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Closed',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.blueGrey.shade900),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      SelectedPrice = _totalClosedPrice;
                                      String userId = user!.uid;
                                      saveConditionToFirebase(userId);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  CustomBottomNavigationBar(
                                                    indexx: 1,
                                                  ))));
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                    230, 143, 143, 143)
                                                .withOpacity(
                                                    0.9), // color of the shadow
                                            spreadRadius: 3, // spread radius
                                            blurRadius: 5,
                                            // blur radius for the shadow
                                            offset: Offset(2,
                                                2), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.green.shade800,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '$_totalClosedPrice \$',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Expendite',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color:
                                          const Color.fromARGB(255, 117, 3, 3)),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Open',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.blueGrey.shade900),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      SelectedPrice = _expenditePrice;
                                      String userId = user!.uid;
                                      saveConditionToFirebase(userId);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  CustomBottomNavigationBar(
                                                    indexx: 1,
                                                  ))));
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                      230, 143, 143, 143)
                                                  .withOpacity(
                                                      0.9), // color of the shadow
                                              spreadRadius: 3, // spread radius
                                              blurRadius: 5,
                                              // blur radius for the shadow
                                              offset: Offset(2,
                                                  2), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color:
                                              Color.fromARGB(255, 58, 0, 14)),
                                      child: Center(
                                        child: Text(
                                          '$_expenditePrice \$',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Closed',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.blueGrey.shade900),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      SelectedPrice = _expenditePrice1;
                                      String userId = user!.uid;
                                      saveConditionToFirebase(userId);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  CustomBottomNavigationBar(
                                                    indexx: 1,
                                                  ))));
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                      230, 143, 143, 143)
                                                  .withOpacity(
                                                      0.9), // color of the shadow
                                              spreadRadius: 3, // spread radius
                                              blurRadius: 5,
                                              // blur radius for the shadow
                                              offset: Offset(2,
                                                  2), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color:
                                              Color.fromARGB(255, 58, 0, 14)),
                                      child: Center(
                                        child: Text(
                                          '$_expenditePrice1 \$',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Back'))
                        ],
                      );
                    });
              },
              child: Text('Generate Price'))
        ],
      ),
    );
  }
}
