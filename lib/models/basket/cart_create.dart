class CartCreate {
  String? sId;
  int? count;
  String? productType;
  String? type;

  CartCreate({
    this.sId, this.count,
    this.productType,
    this.type
  });

  CartCreate.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    count = json['count'];
    productType = json['product_type'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['count'] = count;
    data['product_type'] = productType;
    data['type'] = type;
    return data;
  }
}
