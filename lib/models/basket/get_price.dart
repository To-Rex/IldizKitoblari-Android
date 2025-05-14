class GetPrice {
  Data? data;
  bool? status;

  GetPrice({this.data, this.status});

  GetPrice.fromJson(Map<String, dynamic> json) {
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
  int? totalPrice;
  int? salePrice;

  Data({this.message, this.totalPrice, this.salePrice});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    totalPrice = json['total_price'];
    salePrice = json['sale_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['total_price'] = totalPrice;
    data['sale_price'] = salePrice;
    return data;
  }
}
