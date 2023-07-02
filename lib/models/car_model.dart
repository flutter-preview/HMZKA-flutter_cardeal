class CarModel {
  int? id;
  String? make;
  String? model;
  int? year;
  String? color;
  String? price;
  String? condition;
  String? type;
  String? transmission;
  int? mileage;
  String? description;
  String? imageUrl;
  String? owner;

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    make = json['manufacturer'];
    model = json['model'];
    year = json['year'];
    color = json['color'];
    type = json['type'];
    transmission = json['transmission'];
    condition = json['condition'];
    price = json['price'];
    mileage = json['mileage'];
    description = json['description'];
    imageUrl = json['image_url'];
    owner = json['owner'];
  }
}
