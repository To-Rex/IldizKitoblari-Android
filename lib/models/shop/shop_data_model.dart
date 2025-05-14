class ShopDataModel {
  String? message;
  bool? status;
  Data? data;

  ShopDataModel({this.message, this.status, this.data});

  ShopDataModel.fromJson(Map<String, dynamic> json) {
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

  Data({this.result, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class Result {
  String? sId;
  Title? title;
  String? slug;
  String? link;
  int? menuId;
  bool? isStatic;
  int? order;
  bool? isFooter;
  bool? isHeader;
  Title? shortContent;
  List<Children>? children;
  Banner? banner;
  int? productCount;
  ShopProductModel? shopProductModel;


  Result({this.sId, this.title, this.slug, this.link, this.menuId, this.isStatic, this.order, this.isFooter, this.isHeader, this.shortContent, this.children, this.banner, this.productCount, this.shopProductModel});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    slug = json['slug'];
    link = json['link'];
    menuId = json['menu_id'];
    isStatic = json['is_static'];
    order = json['order'];
    isFooter = json['is_footer'];
    isHeader = json['is_header'];
    shortContent = json['short_content'] != null ? Title.fromJson(json['short_content']) : null;
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(Children.fromJson(v));
      });
    }
    banner = json['banner'] != null ? Banner.fromJson(json['banner']) : null;
    productCount = json['product_count'];
    if (json['shop_product_model'] != null) {
      shopProductModel = ShopProductModel.fromJson(json['shop_product_model']);
    } else {
      shopProductModel = ShopProductModel();
    }
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
    data['is_static'] = isStatic;
    data['order'] = order;
    data['is_footer'] = isFooter;
    data['is_header'] = isHeader;
    if (shortContent != null) {
      data['short_content'] = shortContent!.toJson();
    }
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    if (banner != null) {
      data['banner'] = banner!.toJson();
    }
    data['product_count'] = productCount;
    if (shopProductModel != null) {
      data['shop_product_model'] = shopProductModel!.toJson();
    } else {
      data['shop_product_model'] = shopProductModel;
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

class Children {
  String? sId;
  Title? title;
  String? slug;
  String? link;
  String? menuId;
  bool? isStatic;
  int? order;
  bool? isFooter;
  bool? isHeader;
  Title? shortContent;
  var banner;
  List<Childrens>? children;
  bool? isSelect = false;
  int? productCount = 0;

  Children({this.sId, this.title, this.slug, this.link, this.menuId, this.isStatic, this.order, this.isFooter, this.isHeader, this.shortContent, this.banner, this.children, this.isSelect, this.productCount});

  Children.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    slug = json['slug'];
    link = json['link'];
    menuId = json['menu_id'];
    isStatic = json['is_static'];
    order = json['order'];
    isFooter = json['is_footer'];
    isHeader = json['is_header'];
    shortContent = json['short_content'] != null
        ? Title.fromJson(json['short_content'])
        : null;
    banner = json['banner'];
    if (json['children'] != null) {
      children = <Childrens>[];
      json['children'].forEach((v) {
        children!.add(Childrens.fromJson(v));
      });
    }
    isSelect = json['isSelect'];
    productCount = json['product_count'];
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
    data['is_static'] = isStatic;
    data['order'] = order;
    data['is_footer'] = isFooter;
    data['is_header'] = isHeader;
    if (shortContent != null) {
      data['short_content'] = shortContent!.toJson();
    }
    data['banner'] = banner;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    data['isSelect'] = isSelect;
    data['product_count'] = productCount;
    return data;
  }
}

class Childrens {
  String? sId;
  Title? title;
  String? slug;
  String? link;
  String? menuId;
  Title? shortContent;
  bool? isStatic;
  bool? isHeader;
  bool? isFooter;
  int? order;
  int? productCount = 0;
  //var banner;

  Childrens(
      {this.sId,
        this.title,
        this.slug,
        this.link,
        this.menuId,
        this.shortContent,
        this.isStatic,
        this.isHeader,
        this.isFooter,
        this.order,
        this.productCount
        //this.banner
      });

  Childrens.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    slug = json['slug'];
    link = json['link'];
    menuId = json['menu_id'];
    shortContent = json['short_content'] != null
        ? Title.fromJson(json['short_content'])
        : null;
    isStatic = json['is_static'];
    isHeader = json['is_header'];
    isFooter = json['is_footer'];
    order = json['order'];
    productCount = json['product_count'];
    //banner = json['banner'];
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
    if (shortContent != null) {
      data['short_content'] = shortContent!.toJson();
    }
    data['is_static'] = isStatic;
    data['is_header'] = isHeader;
    data['is_footer'] = isFooter;
    data['order'] = order;
    data['product_count'] = productCount;
    //data['banner'] = banner;
    return data;
  }
}

class Banner {
  String? sId;
  String? name;
  String? link;
  String? menu;
  bool? status;
  String? imageUz;
  String? imageOz;
  String? imageRu;

  Banner(
      {this.sId,
        this.name,
        this.link,
        this.menu,
        this.status,
        this.imageUz,
        this.imageOz,
        this.imageRu});

  Banner.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    link = json['link'];
    menu = json['menu'];
    status = json['status'];
    imageUz = json['image_uz'];
    imageOz = json['image_oz'];
    imageRu = json['image_ru'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['link'] = link;
    data['menu'] = menu;
    data['status'] = status;
    data['image_uz'] = imageUz;
    data['image_oz'] = imageOz;
    data['image_ru'] = imageRu;
    return data;
  }
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ShopProductModel {
  String? message;
  bool? status;
  ProductModelData? data;

  ShopProductModel({this.message, this.status, this.data});

  ShopProductModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? ProductModelData.fromJson(json['data']) : null;
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

class ProductModelData {
  List<ProductModelResult>? result;
  int? count;

  ProductModelData({this.result, this.count});

  ProductModelData.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ProductModelResult>[];
      json['result'].forEach((v) {
        result!.add(ProductModelResult.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class ProductModelResult {
  String? sId;
  String? name;
  String? slug;
  int? price;
  int? sale;
  int? views;
  int? searched;
  int? count;
  bool? famous;
  bool? newProduct;
  String? menuSlug;
  String? image;

  ProductModelResult({this.sId, this.name, this.slug, this.price, this.sale, this.views, this.searched, this.count, this.famous, this.newProduct, this.menuSlug, this.image});

  ProductModelResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    price = json['price'];
    sale = json['sale'];
    views = json['views'];
    searched = json['searched'];
    count = json['count'];
    famous = json['famous'];
    newProduct = json['new_product'];
    menuSlug = json['menu_slug'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['slug'] = slug;
    data['price'] = price;
    data['sale'] = sale;
    data['views'] = views;
    data['searched'] = searched;
    data['count'] = count;
    data['famous'] = famous;
    data['new_product'] = newProduct;
    data['menu_slug'] = menuSlug;
    data['image'] = image;
    return data;
  }
}

