class RegionModel {
  String? message;
  bool? status;
  Data? data;

  RegionModel({this.message, this.status, this.data});

  RegionModel.fromJson(Map<String, dynamic> json) {
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
  List<ResultRegion>? result;

  Data({this.result});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ResultRegion>[];
      json['result'].forEach((v) {
        result!.add(ResultRegion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultRegion {
  String? sId;
  NameRegion? name;
  String? country;
  int? deliveryPrice;
  NameRegion? text;
  String? priceType;

  ResultRegion(
      {this.sId,
        this.name,
        this.country,
        this.deliveryPrice,
        this.text,
        this.priceType});

  ResultRegion.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? NameRegion.fromJson(json['name']) : null;
    country = json['country'];
    deliveryPrice = json['delivery_price'];
    text = json['text'] != null ? NameRegion.fromJson(json['text']) : null;
    priceType = json['price_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['country'] = country;
    data['delivery_price'] = deliveryPrice;
    if (text != null) {
      data['text'] = text!.toJson();
    }
    data['price_type'] = priceType;
    return data;
  }
}

class NameRegion {
  String? uz;
  String? oz;
  String? en;
  String? ru;

  NameRegion({this.uz, this.oz, this.en, this.ru});

  NameRegion.fromJson(Map<String, dynamic> json) {
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
