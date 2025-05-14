class CountryModel {
  String? message;
  bool? status;
  Data? data;

  CountryModel({this.message, this.status, this.data});

  CountryModel.fromJson(Map<String, dynamic> json) {
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
  List<ResultCountry>? result;
  Data({this.result});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ResultCountry>[];
      json['result'].forEach((v) {
        result!.add(ResultCountry.fromJson(v));
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

class ResultCountry {
  String? sId;
  NameCountry? name;
  String? type;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ResultCountry({this.sId, this.name, this.type, this.createdAt, this.updatedAt, this.iV});

  ResultCountry.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? NameCountry.fromJson(json['name']) : null;
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['type'] = type;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }

  @override
  String toString() {
    return 'ResultCountry{sId: $sId, name: $name, type: $type, createdAt: $createdAt, updatedAt: $updatedAt, iV: $iV}';
  }

}

class NameCountry {
  String? uz;
  String? oz;
  String? en;
  String? ru;

  NameCountry({this.uz, this.oz, this.en, this.ru});

  NameCountry.fromJson(Map<String, dynamic> json) {
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