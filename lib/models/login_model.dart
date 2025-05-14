class LoginModel {
  Data? data;
  bool? status;

  LoginModel({this.data, this.status});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  String? token;

  Data({this.message, this.result, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class Result {
  String? sId;
  String? fullName;
  String? password;
  String? phone;
  bool? status;
  String? avatar;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Result(
      {this.sId,
        this.fullName,
        this.password,
        this.phone,
        this.status,
        this.avatar,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['full_name'];
    password = json['password'];
    phone = json['phone'];
    status = json['status'];
    avatar = json['avatar'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['full_name'] = fullName;
    data['password'] = password;
    data['phone'] = phone;
    data['status'] = status;
    data['avatar'] = avatar;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
