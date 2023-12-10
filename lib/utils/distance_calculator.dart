import 'dart:convert';
import 'package:http/http.dart' as http;

class DistanceCalculator {
  static Future<String> calculateDistance(
      String pickupAddress, String dropoffAddress) async {
    String apiKey =
        'AIzaSyDfBAN-K4V3bVXZuEThQRMfmWLDa9F06w8'; // Replace with your Google Maps API key
    String url = 'https://maps.googleapis.com/maps/api/distancematrix/json'
        '?units=metric'
        '&origins=$pickupAddress'
        '&destinations=$dropoffAddress'
        '&key=$apiKey';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      String distance = data['rows'][0]['elements'][0]['distance']['text'];
      return distance;
    } else {
      throw Exception('Failed to calculate distance');
    }
  }
}
