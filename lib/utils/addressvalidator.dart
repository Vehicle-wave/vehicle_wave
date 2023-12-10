import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddressValidator {
  static Future<bool> validateAddress(String address) async {
    final apiKey = 'AIzaSyDfBAN-K4V3bVXZuEThQRMfmWLDa9F06w8';
    final encodedAddress = Uri.encodeComponent(address);
    final requestUrl =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$encodedAddress&key=$apiKey';

    final response = await http.get(Uri.parse(requestUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'OK' && data['results'].isNotEmpty) {
        // Address is valid
        return true;
      }
    }
    // Address is invalid
    return false;
  }
}
