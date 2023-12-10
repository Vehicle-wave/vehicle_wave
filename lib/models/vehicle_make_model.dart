class VehicleMake {
  final int makeId;
  final String makeName;

  VehicleMake({
    required this.makeId,
    required this.makeName,
  });

  factory VehicleMake.fromJson(Map<String, dynamic> json) {
    return VehicleMake(
      makeId: json['Make_ID'] as int,
      makeName: json['Make_Name'] as String,
    );
  }
}
