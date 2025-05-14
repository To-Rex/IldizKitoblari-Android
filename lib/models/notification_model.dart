class NotificationModel {
  bool? status;
  Data? data;

  NotificationModel({this.status, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
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
  List<Result>? result;
  String? message;

  Data({this.result, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Result {
  String? sId;
  Title? title;
  Title? description;
  bool? status;
  String? createdAt;
  bool? isRead;
  Product? product;

  Result(
      {this.sId,
        this.title,
        this.description,
        this.status,
        this.createdAt,
        this.isRead,
        this.product});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    description = json['description'] != null
        ? Title.fromJson(json['description'])
        : null;
    status = json['status'];
    createdAt = json['createdAt'];
    isRead = json['is_read'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    if (description != null) {
      data['description'] = description!.toJson();
    }
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['is_read'] = isRead;
    if (product != null) {
      data['product'] = product!.toJson();
    }
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

class Product {
  Title? name;
  String? slug;
  String? menuSlug;

  Product({this.name, this.slug, this.menuSlug});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? Title.fromJson(json['name']) : null;
    slug = json['slug'];
    menuSlug = json['menu_slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['slug'] = slug;
    data['menu_slug'] = menuSlug;
    return data;
  }
}


class NotificationCountModel {
  bool? status;
  NotificationCountModelData? notificationCountModelData;

  NotificationCountModel({this.status, this.notificationCountModelData});

  NotificationCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    notificationCountModelData = json['data'] != null
        ? NotificationCountModelData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (notificationCountModelData != null) {
      data['data'] = notificationCountModelData!.toJson();
    }
    return data;
  }
}

class NotificationCountModelData {
  int? count;
  String? message;

  NotificationCountModelData({this.count, this.message});

  NotificationCountModelData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    message = json['message'];
  }

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['message'] = message;
    return data;
  }
}
