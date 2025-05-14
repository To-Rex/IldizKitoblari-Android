class ProductDetailModel {
  String? message;
  bool? status;
  Data? data;

  ProductDetailModel({this.message, this.status, this.data});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
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
  int? price;
  int? sale;
  int? views;
  int? searched;
  Menu? menu;
  int? count;
  bool? status;
  bool? famous;
  bool? newProduct;
  String? pdf;
  List<Book>? book;
  int? appPages;
  int? pdfPrice;
  List<Options>? options;
  Name? content;
  bool? hasAudio;
  int? audioPrice;
  int? ebookPrice;
  String? ebookPreview;
  List<SimularProducts>? simularProducts;
  List<Comments>? comments;
  List<Images>? images;

  Data(
      {this.sId,
        this.name,
        this.price,
        this.sale,
        this.views,
        this.searched,
        this.menu,
        this.count,
        this.status,
        this.famous,
        this.newProduct,
        this.pdf,
        this.book,
        this.appPages,
        this.pdfPrice,
        this.options,
        this.content,
        this.hasAudio,
        this.audioPrice,
        this.ebookPrice,
        this.ebookPreview,
        this.simularProducts,
        this.comments,
        this.images});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    price = json['price'];
    sale = json['sale'];
    views = json['views'];
    searched = json['searched'];
    menu = json['menu'] != null ? Menu.fromJson(json['menu']) : null;
    count = json['count'];
    status = json['status'];
    famous = json['famous'];
    newProduct = json['new_product'];
    pdf = json['pdf'];
    if (json['book'] != null) {
      book = <Book>[];
      json['book'].forEach((v) {
        book!.add(Book.fromJson(v));
      });
    }
    appPages = json['appPages'];
    pdfPrice = json['pdf_price'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    content = json['content'] != null ? Name.fromJson(json['content']) : null;
    hasAudio = json['has_audio'] ?? false;
    audioPrice = json['audio_price'] ?? 0;
    ebookPrice = json['ebook_price'] ?? 0;
    ebookPreview = json['ebook_preview'] ?? '';
    if (json['simular_products'] != null) {
      simularProducts = <SimularProducts>[];
      json['simular_products'].forEach((v) {
        simularProducts!.add(SimularProducts.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['price'] = price;
    data['sale'] = sale;
    data['views'] = views;
    data['searched'] = searched;
    if (menu != null) {
      data['menu'] = menu!.toJson();
    }
    data['count'] = count;
    data['status'] = status;
    data['famous'] = famous;
    data['new_product'] = newProduct;
    data['pdf'] = pdf;
    data['pdf_price'] = pdfPrice;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    if (content != null) {
      data['content'] = content!.toJson();
    }
    data['has_audio'] = hasAudio;
    data['audio_price'] = audioPrice;
    data['ebook_price'] = ebookPrice;
    data['ebook_preview'] = ebookPreview;
    if (simularProducts != null) {
      data['simular_products'] =
          simularProducts!.map((v) => v.toJson()).toList();
    }
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (book != null) {
      data['book'] = book!.map((v) => v.toJson()).toList();
    }
    data['appPages'] = appPages;
    return data;
  }
}

class Book {
  int? page;
  String? text;

  Book({this.page, this.text});

  Book.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['text'] = text;
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

class Menu {
  String? sId;
  String? slug;
  List<Option>? options;

  Menu({this.sId, this.slug, this.options});

  Menu.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    slug = json['slug'];
    if (json['options'] != null) {
      options = <Option>[];
      json['options'].forEach((v) {
        options!.add(Option.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['slug'] = slug;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Option {
  String? optionId;
  bool? onFilter;
  bool? isMain;
  String? sId;

  Option({this.optionId, this.onFilter, this.isMain, this.sId});

  Option.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'];
    onFilter = json['on_filter'];
    isMain = json['is_main'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['option_id'] = optionId;
    data['on_filter'] = onFilter;
    data['is_main'] = isMain;
    data['_id'] = sId;
    return data;
  }
}

class Options {
  OptionId? optionId;
  String? value;
  ValueId? valueId;
  String? sId;

  Options({this.optionId, this.value, this.valueId, this.sId});

  Options.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'] != null
        ? OptionId.fromJson(json['option_id'])
        : null;
    value = json['value'];
    valueId = json['value_id'] != null
        ? ValueId.fromJson(json['value_id'])
        : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (optionId != null) {
      data['option_id'] = optionId!.toJson();
    }
    data['value'] = value;
    if (valueId != null) {
      data['value_id'] = valueId!.toJson();
    }
    data['_id'] = sId;
    return data;
  }
}

class OptionId {
  String? sId;
  Name? name;
  int? type;

  OptionId({this.sId, this.name, this.type});

  OptionId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['type'] = type;
    return data;
  }
}

class ValueId {
  String? sId;
  Name? name;

  ValueId({this.sId, this.name});

  ValueId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    return data;
  }
}

class SimularProducts {
  String? sId;
  String? name;
  String? slug;
  int? price;
  int? sale;
  int? count;
  Options? option;
  String? image;

  SimularProducts(
      {this.sId,
        this.name,
        this.slug,
        this.price,
        this.sale,
        this.count,
        this.option,
        this.image
      });

  SimularProducts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    price = json['price'];
    sale = json['sale'];
    count = json['count'];
    option =
    json['option'] != null ? Options.fromJson(json['option']) : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['slug'] = slug;
    data['price'] = price;
    data['sale'] = sale;
    data['count'] = count;
    if (option != null) {
      data['option'] = option!.toJson();
    }
    data['image'] = image;
    return data;
  }
}

class Comments {
  String? sId;
  var rate;
  String? description;
  User? user;
  String? createdAt;

  Comments({this.sId, this.rate, this.description, this.user, this.createdAt});

  Comments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    rate = json['rate'] ?? 0;
    description = json['description'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['rate'] = rate ?? 0;
    data['description'] = description;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['createdAt'] = createdAt;
    return data;
  }
}

class User {
  String? sId;
  String? fullName;
  String? avatar;
  String? createdAt;

  User({this.sId, this.fullName, this.avatar, this.createdAt});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['full_name'];
    avatar = json['avatar'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['full_name'] = fullName;
    data['avatar'] = avatar;
    data['createdAt'] = createdAt;
    return data;
  }
}

class Images {
  String? sId;
  String? file;
  bool? isMain;

  Images({this.sId, this.file, this.isMain});

  Images.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    file = json['file'];
    isMain = json['is_main'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['file'] = file;
    data['is_main'] = isMain;
    return data;
  }
}
