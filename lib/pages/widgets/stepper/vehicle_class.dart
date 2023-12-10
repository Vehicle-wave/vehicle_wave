import 'package:flutter/material.dart';

class VehicleDetails {
  TextEditingController makeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  String? typeVehicle = 'ATV';
  String selectedMake = '';
  String selectedModel = '';
  String selectedType = '';

  bool showMakeSuggestion = false;
  bool showModelSuggestion = false;
  bool showTypeSuggestions = false;
  List<String> makes = [];
  List<String> modelSuggestions = [];
  List<String> filteredModelSuggestions = [];
  List<String> VehicleTypesList = [];
}
