class ShipmentData {
  String pickupAddress;
  String pickupContact;
  String dropoffAddress;
  String dropoffContact;
  String make;
  String model;
  String year;
  String vehicleType;
  String fullName;
  String phone;
  String email;
  String estimatedPickup;
  String estimatedDropoff;
  String pickupType;
  String dropoffType;
  String condition;
  String extras;
  String description;

  ShipmentData(
      {required this.pickupAddress,
      required this.pickupContact,
      required this.dropoffAddress,
      required this.dropoffContact,
      required this.make,
      required this.model,
      required this.year,
      required this.vehicleType,
      required this.fullName,
      required this.phone,
      required this.email,
      required this.estimatedPickup,
      required this.estimatedDropoff,
      required this.pickupType,
      required this.dropoffType,
      required this.condition,
      required this.extras,
      required this.description
      // Initialize other properties
      });

  // Convert the data model to a Map for storing in the Realtime Database
  Map<String, dynamic> toMap() {
    return {
      'pickupAddress': pickupAddress,
      'pickupContact': pickupContact,
      'dropoffAddress': dropoffAddress,
      'dropoffContact': dropoffContact,
      'make': make,
      'model': model,
      'year': year,
      'vehicleType': vehicleType,
      'fullName': fullName,
      'phone': phone,
      'email': email,
      'estimatedPickup': estimatedPickup,
      'estimatedDropoff': estimatedDropoff,
      'pickupType': pickupType,
      'dropoffType': dropoffType,
      'condition': condition,
      'extras': extras,
      'description': description,
      // Add other properties as needed
    };
  }
}
