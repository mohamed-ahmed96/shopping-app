class HomeModel {
  bool? status;
  String? message;
  DataModel? data;

  HomeModel.fromJson(Map<String,dynamic> json)
  {
    status=json["status"];
    message=json["message"];
    data=DataModel.fromJson(json["data"]);
  }

}

class DataModel {
  List<Banner> banners = [];
  List<Product> products = [];

  DataModel.fromJson(Map<String, dynamic> json) {
    json["banners"].forEach((element) {
      banners.add(Banner.fromJson(element));
    });
    json["products"].forEach((element){
      products.add(Product.fromJson(element));
    });

  }
}

class Banner {
  int? id;
  String? image;

  Banner.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
  }
}

class Product {
  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? name;
  String? image;
  String? description;
  bool? in_favorites;

  Product.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    old_price = json["old_price"];
    discount = json["discount"];
    name = json["name"];
    image = json["image"];
    description = json["description"];
    in_favorites = json["in_favorites"];
  }
}
