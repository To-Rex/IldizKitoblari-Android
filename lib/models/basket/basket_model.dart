class BasketModel {
  Data? data;
  bool? status;

  BasketModel({this.data, this.status});

  BasketModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class Data {
  String? message;
  List<Result>? result;

  Data({this.message, this.result});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? sId;
  int? count;
  String? productType;
  String? user;
  int? cartCount;
  String? productId;
  Name? name;
  String? menuSlug;
  int? price;
  String? slug;
  int? sale;
  double? weight;
  String? image;

  Result({this.sId, this.count, this.productType, this.user, this.cartCount, this.productId, this.name, this.menuSlug, this.price, this.slug, this.sale, this.weight, this.image});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    count = json['count'];
    productType = json['product_type'];
    user = json['user'];
    cartCount = json['cart_count'];
    productId = json['product_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    menuSlug = json['menu_slug'];
    price = json['price'];
    slug = json['slug'];
    sale = json['sale'];
    weight = json['weight'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['count'] = count;
    data['product_type'] = productType;
    data['user'] = user;
    data['cart_count'] = cartCount;
    data['product_id'] = productId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['menu_slug'] = menuSlug;
    data['price'] = price;
    data['slug'] = slug;
    data['sale'] = sale;
    data['weight'] = weight;
    data['image'] = image;
    return data;
  }
}

class Name {
  String? uz;
  String? oz;
  String? ru;

  Name({this.uz, this.oz, this.ru});

  Name.fromJson(Map<String, dynamic> json) {
    uz = json['uz'];
    oz = json['oz'];
    ru = json['ru'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uz'] = uz;
    data['oz'] = oz;
    data['ru'] = ru;
    return data;
  }
}
