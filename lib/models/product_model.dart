class ProductModel {
  String? message;
  bool? status;
  Data? data;

  ProductModel({this.message, this.status, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Result>? result;
  int? count;

  Data({this.result, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class Result {
  String? sId;
  String? name;
  String? slug;
  int? price;
  int? sale;
  int? views;
  int? searched;
  int? count;
  bool? famous;
  bool? newProduct;
  String? productType;
  String? menuSlug;
  String? image;

  Result({this.sId, this.name, this.slug, this.price, this.sale, this.views, this.searched, this.count, this.famous, this.newProduct, this.productType, this.menuSlug, this.image});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    price = json['price'];
    sale = json['sale'];
    views = json['views'];
    searched = json['searched'];
    count = json['count'];
    famous = json['famous'];
    newProduct = json['new_product'];
    productType = json['product_type'];
    menuSlug = json['menu_slug'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['slug'] = slug;
    data['price'] = price;
    data['sale'] = sale;
    data['views'] = views;
    data['searched'] = searched;
    data['count'] = count;
    data['famous'] = famous;
    data['new_product'] = newProduct;
    data['product_type'] = productType;
    data['menu_slug'] = menuSlug;
    data['image'] = image;
    return data;
  }
}
