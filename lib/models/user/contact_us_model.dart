class ContactUsModel {
  bool? status;
  Data? data;

  ContactUsModel({this.status, this.data});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Result? result;
  String? message;

  Data({this.result, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Result {
  String? sId;
  Socials? socials;
  String? phone;
  String? corpPhone;
  List<Branches>? branches;
  Title? address;
  String? addressLink;

  Result(
      {this.sId,
        this.socials,
        this.phone,
        this.corpPhone,
        this.branches,
        this.address,
        this.addressLink});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    socials =
    json['socials'] != null ? Socials.fromJson(json['socials']) : null;
    phone = json['phone'];
    corpPhone = json['corp_phone'];
    if (json['branches'] != null) {
      branches = <Branches>[];
      json['branches'].forEach((v) {
        branches!.add(Branches.fromJson(v));
      });
    }
    address =
    json['address'] != null ? Title.fromJson(json['address']) : null;
    addressLink = json['address_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (socials != null) {
      data['socials'] = socials!.toJson();
    }
    data['phone'] = phone;
    data['corp_phone'] = corpPhone;
    if (branches != null) {
      data['branches'] = branches!.map((v) => v.toJson()).toList();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['address_link'] = addressLink;
    return data;
  }
}

class Socials {
  String? instagram;
  String? facebook;
  String? telegram;
  String? youtube;

  Socials({this.instagram, this.facebook, this.telegram, this.youtube});

  Socials.fromJson(Map<String, dynamic> json) {
    instagram = json['instagram'];
    facebook = json['facebook'];
    telegram = json['telegram'];
    youtube = json['youtube'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['instagram'] = instagram;
    data['facebook'] = facebook;
    data['telegram'] = telegram;
    data['youtube'] = youtube;
    return data;
  }
}

class Branches {
  Title? title;
  Title? address;
  Title? target;
  String? iframe;
  bool? status;
  String? sId;

  Branches(
      {this.title,
        this.address,
        this.target,
        this.iframe,
        this.status,
        this.sId});

  Branches.fromJson(Map<String, dynamic> json) {
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    address =
    json['address'] != null ? Title.fromJson(json['address']) : null;
    target = json['target'] != null ? Title.fromJson(json['target']) : null;
    iframe = json['iframe'];
    status = json['status'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (title != null) {
      data['title'] = title!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (target != null) {
      data['target'] = target!.toJson();
    }
    data['iframe'] = iframe;
    data['status'] = status;
    data['_id'] = sId;
    return data;
  }
}

class Title {
  String? uz;
  String? oz;
  String? ru;

  Title({this.uz, this.oz, this.ru});

  Title.fromJson(Map<String, dynamic> json) {
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
