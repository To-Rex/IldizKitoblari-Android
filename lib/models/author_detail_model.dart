class AuthorDetailModel {
  String? message;
  bool? status;
  Data? data;

  AuthorDetailModel({this.message, this.status, this.data});

  AuthorDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  Name? name;
  String? optionId;
  Name? content;
  String? image;
  List<SimilarAuthors>? similarAuthors;

  Data({this.sId, this.name, this.optionId, this.content, this.image, this.similarAuthors});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    optionId = json['option_id'];
    content =
    json['content'] != null ? Name.fromJson(json['content']) : null;
    image = json['image'];
    if (json['similar_authors'] != null) {
      similarAuthors = <SimilarAuthors>[];
      json['similar_authors'].forEach((v) {
        similarAuthors!.add(SimilarAuthors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['option_id'] = optionId;
    if (content != null) {
      data['content'] = content!.toJson();
    }
    data['image'] = image;
    if (similarAuthors != null) {
      data['similar_authors'] = similarAuthors!.map((v) => v.toJson()).toList();
    }
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

class SimilarAuthors {
  String? sId;
  Name? name;
  String? image;
  int? productCount;

  SimilarAuthors({this.sId, this.name, this.image, this.productCount});

  SimilarAuthors.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    image = json['image'];
    productCount = json['product_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['image'] = image;
    data['product_count'] = productCount;
    return data;
  }
}
