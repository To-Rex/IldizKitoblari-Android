class DeliveryPrice {
  String? message;
  bool? status;
  Data? data;

  DeliveryPrice({this.message, this.status, this.data});

  DeliveryPrice.fromJson(Map<String, dynamic> json) {
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
  Price? price;

  Data({this.price});

  Data.fromJson(Map<String, dynamic> json) {
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (price != null) {
      data['price'] = price!.toJson();
    }
    return data;
  }
}

class Price {
  String? sId;
  int? value;

  Price({this.sId, this.value});

  Price.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['value'] = value;
    return data;
  }
}
