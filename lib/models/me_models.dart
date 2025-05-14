class MeModel {
  Data? data;
  bool? status;

  MeModel({this.data, this.status});

  MeModel.fromJson(Map<String, dynamic> json) {
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
  Result? result;

  Data({this.message, this.result});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  String? sId;
  String? fullName;
  String? phone;
  String? avatar;

  Result({this.sId, this.fullName, this.phone, this.avatar});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['full_name'];
    phone = json['phone'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['full_name'] = fullName;
    data['phone'] = phone;
    data['avatar'] = avatar;
    return data;
  }
}
