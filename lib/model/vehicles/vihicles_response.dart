import 'vehicle.dart';

/// Status : 1
/// Result : [{"ID":1,"Name":"Economy","Photo":"https://via.placeholder.com/150"},{"ID":2,"Name":"VIB","Photo":"https://via.placeholder.com/150"}]

class VehiclesResponse {
  int _status;
  List<Vehicle> _result;

  int get status => _status;

  List<Vehicle> get result => _result;

  VehiclesResponse({int status, List<Vehicle> result}) {
    _status = status;
    _result = result;
  }

  VehiclesResponse.fromJson(dynamic json) {
    _status = json["Status"];
    if (json["Result"] != null) {
      _result = [];
      json["Result"].forEach((v) {
        _result.add(Vehicle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["Status"] = _status;
    if (_result != null) {
      map["Result"] = _result.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
