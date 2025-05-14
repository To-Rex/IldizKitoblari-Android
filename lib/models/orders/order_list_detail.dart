class OrderListDetail {
  String? message;
  bool? status;
  Data? data;

  OrderListDetail({this.message, this.status, this.data});

  OrderListDetail.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  int? status;
  int? deliveryStatus;
  bool? isClosed;
  int? uid;
  int? type;
  int? price;
  int? deliveryPrice;
  String? district;
  String? city;
  String? address;
  List<OrderProducts>? orderProducts;
  String? country;

  Data(
      {this.sId,
        this.status,
        this.deliveryStatus,
        this.isClosed,
        this.uid,
        this.type,
        this.price,
        this.deliveryPrice,
        this.district,
        this.city,
        this.address,
        this.orderProducts,
        this.country});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    deliveryStatus = json['delivery_status'];
    isClosed = json['is_сlosed'];
    uid = json['uid'];
    type = json['type'];
    price = json['price'];
    deliveryPrice = json['delivery_price'];
    district = json['district'];
    city = json['city'];
    address = json['address'];
    if (json['order_products'] != null) {
      orderProducts = <OrderProducts>[];
      json['order_products'].forEach((v) {
        orderProducts!.add(OrderProducts.fromJson(v));
      });
    }
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['status'] = status;
    data['delivery_status'] = deliveryStatus;
    data['is_сlosed'] = isClosed;
    data['uid'] = uid;
    data['type'] = type;
    data['price'] = price;
    data['delivery_price'] = deliveryPrice;
    data['district'] = district;
    data['city'] = city;
    data['address'] = address;
    if (orderProducts != null) {
      data['order_products'] =
          orderProducts!.map((v) => v.toJson()).toList();
    }
    data['country'] = country;
    return data;
  }
}

class OrderProducts {
  String? sId;
  String? order;
  Product? product;
  String? image;
  int? orderSale;
  int? orderPrice;
  int? productCount;
  int? orderCount;

  OrderProducts({this.sId, this.order, this.product, this.orderSale, this.orderPrice, this.productCount, this.orderCount});

  OrderProducts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    order = json['order'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    image = json['image'];
    orderSale = json['order_sale'];
    orderPrice = json['order_price'];
    productCount = json['product_count'];
    orderCount = json['order_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['order'] = order;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['image'] = image;
    data['order_sale'] = orderSale;
    data['order_price'] = orderPrice;
    data['product_count'] = productCount;
    data['order_count'] = orderCount;
    return data;
  }
}

class Product {
  String? sId;
  Name? name;
  double? weight;

  Product({this.sId, this.name, this.weight});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['weight'] = weight;
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
