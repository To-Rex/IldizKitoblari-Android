class AudioLibraryList {
  String? message;
  bool? status;
  Data? data;

  AudioLibraryList({this.message, this.status, this.data});

  AudioLibraryList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) data['data'] = this.data!.toJson();
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
      json['result'].forEach((v) => result!.add(Result.fromJson(v)));
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) data['result'] = result!.map((v) => v.toJson()).toList();
    data['count'] = count;
    return data;
  }
}

class Result {
  String? sId;
  String? order;
  Product? product;
  String? productType;
  int? orderSale;
  int? orderPrice;

  Result({this.sId, this.order, this.product, this.productType, this.orderSale, this.orderPrice});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    order = json['order'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    productType = json['product_type'];
    orderSale = json['order_sale'];
    orderPrice = json['order_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['order'] = order;
    if (product != null) data['product'] = product!.toJson();
    data['product_type'] = productType;
    data['order_sale'] = orderSale;
    data['order_price'] = orderPrice;
    return data;
  }
}

class Product {
  String? sId;
  Name? name;
  int? audioPrice;
  int? ebookPrice;
  String? ebookPreview;
  String? ebook;
  String? image;

  Product({this.sId, this.name, this.audioPrice, this.ebookPrice, this.ebookPreview, this.ebook, this.image});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    audioPrice = json['audio_price'];
    ebookPrice = json['ebook_price'];
    ebookPreview = json['ebook_preview'];
    ebook = json['ebook'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (name != null) data['name'] = name!.toJson();
    data['audio_price'] = audioPrice;
    data['ebook_price'] = ebookPrice;
    data['ebook_preview'] = ebookPreview;
    data['ebook'] = ebook;
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

