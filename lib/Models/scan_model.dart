import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  ScanModel({
    this.id,
    this.type,
    @required this.data,
    @required this.active,
    @required this.status,
  }) {
    if (this.data.contains('http')) {
      this.type = 'http';
    } else {
      this.type = 'geo';
    }
  }

  int id;
  String type;
  String data;
  int active;
  int status;

  LatLng getLatLng() {
    final coordinates = this.data.substring(4).split(',');
    final lat = double.parse(coordinates[0]);
    final lng = double.parse(coordinates[1]);

    return LatLng(lat, lng);
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        type: json["type"],
        data: json["data"],
        active: json["active"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "data": data,
        "active": active,
        "status": status,
      };
}
