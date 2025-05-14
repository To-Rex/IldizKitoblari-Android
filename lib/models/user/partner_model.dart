class PartnerModel {
  String? message;
  bool? status;
  Data? data;

  PartnerModel({this.message, this.status, this.data});

  PartnerModel.fromJson(Map<String, dynamic> json) {
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

  Data({this.result});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) data['result'] = result!.map((v) => v.toJson()).toList();
    return data;
  }
}

class Result {
  String? sId;
  Address? address;
  Address? title;
  Address? referencePoint;
  String? workTime;
  String? link;
  String? phone;
  bool? status;

  Result({this.sId, this.address, this.title, this.referencePoint, this.workTime, this.link, this.phone, this.status});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    title = json['title'] != null ? Address.fromJson(json['title']) : null;
    referencePoint = json['reference_point'] != null ? Address.fromJson(json['reference_point']) : null;
    workTime = json['work_time'];
    link = json['link'];
    phone = json['phone'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (address != null) data['address'] = address!.toJson();
    if (title != null) data['title'] = title!.toJson();
    if (referencePoint != null) data['reference_point'] = referencePoint!.toJson();
    data['work_time'] = workTime;
    data['link'] = link;
    data['phone'] = phone;
    data['status'] = status;
    return data;
  }
}

class Address {
  String? uz;
  String? oz;
  String? ru;

  Address({this.uz, this.oz, this.ru});

  Address.fromJson(Map<String, dynamic> json) {
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
