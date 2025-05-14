class OfferModel {
  String? message;
  bool? status;
  Data? data;

  OfferModel({this.message, this.status, this.data});

  OfferModel.fromJson(Map<String, dynamic> json) {
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
  Title? title;
  String? slug;
  String? link;
  String? menuId;
  Title? content;
  bool? isStatic;
  bool? isHeader;
  bool? isFooter;
  bool? status;
  String? image;
  List? options;
  Title? shortContent;

  Data({this.sId, this.title, this.slug, this.link, this.menuId, this.content, this.isStatic, this.isHeader, this.isFooter, this.status, this.image, this.options, this.shortContent});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    slug = json['slug'];
    link = json['link'];
    menuId = json['menu_id'];
    content =
    json['content'] != null ? Title.fromJson(json['content']) : null;
    isStatic = json['is_static'];
    isHeader = json['is_header'];
    isFooter = json['is_footer'];
    status = json['status'];
    image = json['image'];
    if (json['options'] != null) {
      options = <Null>[];
      json['options'].forEach((v) => options!.add(v));
    }
    shortContent = json['short_content'] != null ? Title.fromJson(json['short_content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    data['slug'] = slug;
    data['link'] = link;
    data['menu_id'] = menuId;
    if (content != null) {
      data['content'] = content!.toJson();
    }
    data['is_static'] = isStatic;
    data['is_header'] = isHeader;
    data['is_footer'] = isFooter;
    data['status'] = status;
    data['image'] = image;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    if (shortContent != null) {
      data['short_content'] = shortContent!.toJson();
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
