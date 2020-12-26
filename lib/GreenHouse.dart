import 'dart:ffi';

class GreenHouse {
  final String ghId;
  final String id;
  final double currentTemp;
  final String date;

  GreenHouse({this.ghId, this.id, this.currentTemp, this.date});

  factory GreenHouse.fromJson(Map<String, dynamic> json) {
    return GreenHouse(
        ghId: json['ghId'],
        id: json['_id'],
        currentTemp: json['currentTemp'],
        date: json['date']);
  }
}
