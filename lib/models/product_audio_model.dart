class ProductAudioModel {
  String? message;
  bool? status;
  Data? data;

  ProductAudioModel({this.message, this.status, this.data});

  ProductAudioModel.fromJson(Map<String, dynamic> json) {
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
  List<Result>? result;
  int? count;
  Product? product;

  Data({this.result, this.count, this.product});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
    count = json['count'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Result {
  String? sId;
  Name? name;
  File? file;
  bool? locked;
  bool? isActive;
  int? order;

  Result({this.sId, this.name, this.file, this.locked, this.isActive, this.order});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    file = json['file'] != null ? File.fromJson(json['file']) : null;
    locked = json['locked'];
    isActive = json['is_active'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    if (file != null) {
      data['file'] = file!.toJson();
    }
    data['locked'] = locked;
    data['is_active'] = isActive;
    data['order'] = order;
    return data;
  }
}

class Name {
  String? uz;
  String? oz;
  String? ru;

  Name({this.uz, this.oz, this.ru});

  Name.fromJson(Map<String, dynamic> json) {
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

class File {
  String? mimetype;
  String? path;
  int? size;

  File({this.mimetype, this.path, this.size});

  File.fromJson(Map<String, dynamic> json) {
    mimetype = json['mimetype'];
    path = json['path'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mimetype'] = mimetype;
    data['path'] = path;
    data['size'] = size;
    return data;
  }
}

class Product {
  String? sId;
  Name? name;
  String? image;

  Product({this.sId, this.name, this.image});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['image'] = image;
    return data;
  }
}
