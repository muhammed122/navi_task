/// orderID : 757646326

class Result {
  int _orderID;

  int get orderID => _orderID;

  Result({int orderID}) {
    _orderID = orderID;
  }

  Result.fromJson(dynamic json) {
    _orderID = json["orderID"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["orderID"] = _orderID;
    return map;
  }
}
