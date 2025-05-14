class RegisterModel {
  Data? data;
  String? token;
  bool? status;

  RegisterModel({this.data, this.token, this.status});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    token = json['token'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = token;
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
  String? fullName;
  String? password;
  String? phone;
  bool? status;
  String? avatar;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Result(
      {this.fullName,
        this.password,
        this.phone,
        this.status,
        this.avatar,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Result.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    password = json['password'];
    phone = json['phone'];
    status = json['status'];
    avatar = json['avatar'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['password'] = password;
    data['phone'] = phone;
    data['status'] = status;
    data['avatar'] = avatar;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
