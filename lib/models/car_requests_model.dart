import 'car_model.dart';

class CarRequestModel {
  String? id;
  String? name;
  String? price;
  CarModel? carModel;
  CarRequestModel.fromJson(Map<String, dynamic> json) {
    id = "${json["id"]}";
    name = json["buyer"];
    price = json["price_suggested"];
    carModel = CarModel.fromJson(json["car"]);
  }
}
