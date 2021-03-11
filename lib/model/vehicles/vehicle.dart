/// ID : 1
/// Name : "Economy"
/// Photo : "https://via.placeholder.com/150"

class Vehicle {
  int _id;
  String _name;
  String _photo;

  int get id => _id;
  String get name => _name;
  String get photo => _photo;

  Vehicle({
      int id, 
      String name, 
      String photo}){
    _id = id;
    _name = name;
    _photo = photo;
}

  Vehicle.fromJson(dynamic json) {
    _id = json["ID"];
    _name = json["Name"];
    _photo = json["Photo"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["ID"] = _id;
    map["Name"] = _name;
    map["Photo"] = _photo;
    return map;
  }

}