import 'car_model.dart';

class CarRequestModel {
  String? id;
  String? name;
  String? price;
  String? status;
  CarModel? carModel;
  CarRequestModel.fromJson(Map<String, dynamic> json) {
    id = "${json["id"]}";
    name = json["buyer"];
    status = json["status"];
    price = json["price_suggested"];
    carModel = CarModel.fromJson(json["car"]);
  }
}
