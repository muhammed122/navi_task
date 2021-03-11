import 'dart:convert';

import 'package:navi_task/model/place_order/place_order_response.dart';
import 'package:navi_task/model/vehicles/vihicles_response.dart';
import 'package:http/http.dart' as http;
import 'package:navi_task/other/constants.dart';

class VehicleService {
  static Future<VehiclesResponse> getVehicles() async {
    Map<String, String> headers = {
      'Content-Type': 'text/plain',
      'charset': 'UTF-8'
    };
    final body = jsonEncode({'do': getVehicle, 'token': token});
    final response = await http.post(BASE_URL, headers: headers, body: body);
    if (response.statusCode == 200) {
      final responseString = response.body;
      final Map data = jsonDecode(responseString);
      return VehiclesResponse.fromJson(data);
    }
    return null;
  }

  static Future<PlaceOrderResponse> confirmOrder(int vehicle) async {
    Map<String, String> headers = {
      'Content-Type': 'text/plain',
      'charset': 'UTF-8'
    };
    final body = jsonEncode({
      'do': placeOrder,
      'token': token,
      'origin': origin,
      'destination': destination,
      'VehicleID': vehicle
    });
    final response = await http.post(BASE_URL, headers: headers, body: body);
    if (response.statusCode == 200) {
      final responseString = response.body;
      final Map data = jsonDecode(responseString);
      return PlaceOrderResponse.fromJson(data);
    }
    return null;
  }
}
