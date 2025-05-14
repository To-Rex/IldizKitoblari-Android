class OrderCreateModel {
  String? message;
  bool? status;
  Data? data;

  OrderCreateModel({this.message, this.status, this.data});

  OrderCreateModel.fromJson(Map<String, dynamic> json) {
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
  int? status;
  String? deliveryStatus;
  bool? isLosed;
  int? uid;
  String? type;
  String? user;
  int? price;
  int? deliveryPrice;
  String? paymentId;
  String? district;
  String? city;
  String? address;
  String? description;
  String? paymentDate;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data({this.status, this.deliveryStatus, this.isLosed, this.uid, this.type, this.user, this.price, this.deliveryPrice, this.paymentId, this.district, this.city, this.address, this.description, this.paymentDate, this.sId, this.createdAt, this.updatedAt, this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    deliveryStatus = json['delivery_status'];
    isLosed = json['is_сlosed'];
    uid = json['uid'];
    type = json['type'];
    user = json['user'];
    price = json['price'];
    deliveryPrice = json['delivery_price'];
    paymentId = json['payment_id'];
    district = json['district'];
    city = json['city'];
    address = json['address'];
    description = json['description'];
    paymentDate = json['payment_date'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['delivery_status'] = deliveryStatus;
    data['is_сlosed'] = isLosed;
    data['uid'] = uid;
    data['type'] = type;
    data['user'] = user;
    data['price'] = price;
    data['delivery_price'] = deliveryPrice;
    data['payment_id'] = paymentId;
    data['district'] = district;
    data['city'] = city;
    data['address'] = address;
    data['description'] = description;
    data['payment_date'] = paymentDate;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
