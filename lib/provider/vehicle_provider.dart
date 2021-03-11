import 'package:flutter/cupertino.dart';
import 'package:navi_task/model/vehicles/vihicles_response.dart';
import 'package:navi_task/services/vehicle_service.dart';

class VehicleProvider extends ChangeNotifier {
  VehiclesResponse vehiclesResponse;

  getVehicles() async {
    vehiclesResponse = await VehicleService.getVehicles();
    notifyListeners();
  }
}
