class ProductRate {
  Data? data;
  bool? status;

  ProductRate({this.data, this.status});

  ProductRate.fromJson(Map<String, dynamic> json) {
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
  int? i1;
  int? i2;
  int? i3;
  int? i4;
  int? i5;
  double? average;
  int? total;

  Result(
      {this.i1, this.i2, this.i3, this.i4, this.i5, this.average, this.total});

  Result.fromJson(Map<String, dynamic> json) {
    i1 = json['1'] ?? 0;
    i2 = json['2'] ?? 0;
    i3 = json['3'] ?? 0;
    i4 = json['4'] ?? 0;
    i5 = json['5'] ?? 0;
    average = json['average'] != null ? json['average'].toDouble() : 0.0;
    total = json['total'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['1'] = i1 ?? 0;
    data['2'] = i2 ?? 0;
    data['3'] = i3 ?? 0;
    data['4'] = i4 ?? 0;
    data['5'] = i5 ?? 0;
    data['average'] = average ?? 0.0;
    data['total'] = total ?? 0;
    return data;
  }
}
