class CarPartModel {
  int? id;
  String? category;
  String? name;
  String? description;
  String? price;
  String? imageUrl;
  CarPartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    imageUrl = json['image_url'];
  }
}
