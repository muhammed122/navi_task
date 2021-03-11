import 'result.dart';

/// Status : 1
/// Result : {"orderID":757646326}

class PlaceOrderResponse {
  int _status;
  Result _result;

  int get status => _status;
  Result get result => _result;

  PlaceOrderResponse({
      int status, 
      Result result}){
    _status = status;
    _result = result;
}

  PlaceOrderResponse.fromJson(dynamic json) {
    _status = json["Status"];
    _result = json["Result"] != null ? Result.fromJson(json["Result"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["Status"] = _status;
    if (_result != null) {
      map["Result"] = _result.toJson();
    }
    return map;
  }

}