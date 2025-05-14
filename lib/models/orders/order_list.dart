class OrderListModel {
  String? message;
  bool? status;
  Data? data;

  OrderListModel({this.message, this.status, this.data});

  OrderListModel.fromJson(Map<String, dynamic> json) {
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
  int? status;
  int? deliveryStatus;
  bool? isClosed;
  int? uid;
  int? type;
  int? price;
  int? deliveryPrice;
  District? district;
  String? city;
  String? address;
  String? paymentDate;
  String? createdAt;


  Result({this.sId, this.status, this.deliveryStatus, this.isClosed, this.uid, this.type, this.price, this.deliveryPrice, this.district, this.city, this.address, this.paymentDate, this.createdAt});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    deliveryStatus = json['delivery_status'];
    isClosed = json['is_сlosed'];
    uid = json['uid'];
    type = json['type'];
    price = json['price'];
    deliveryPrice = json['delivery_price'];
    district = json['district'] != null
        ? District.fromJson(json['district'])
        : null;
    city = json['city'];
    address = json['address'];
    paymentDate = json['payment_date'];
    createdAt = json['createdAt'];
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
    if (district != null) data['district'] = district!.toJson();
    data['city'] = city;
    data['address'] = address;
    data['payment_date'] = paymentDate;
    data['createdAt'] = createdAt;
    return data;
  }
}

class District {
  String? sId;
  Name? name;
  Country? country;

  District({this.sId, this.name, this.country});

  District.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    country =
    json['country'] != null ? Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (name != null) data['name'] = name!.toJson();
    if (country != null) data['country'] = country!.toJson();
    return data;
  }
}

class Name {
  String? uz;
  String? oz;
  String? en;
  String? ru;

  Name({this.uz, this.oz, this.en, this.ru});

  Name.fromJson(Map<String, dynamic> json) {
    uz = json['uz'];
    oz = json['oz'];
    en = json['en'];
    ru = json['ru'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uz'] = uz;
    data['oz'] = oz;
    data['en'] = en;
    data['ru'] = ru;
    return data;
  }
}

class Country {
  String? sId;
  Name? name;

  Country({this.sId, this.name});

  Country.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (name != null) data['name'] = name!.toJson();
    return data;
  }
}
