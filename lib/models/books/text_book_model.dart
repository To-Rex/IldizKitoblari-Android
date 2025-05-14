class TextBookModel {
  String? text;
  int? page;

  TextBookModel({this.text, this.page});

  TextBookModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['page'] = page;
    return data;
  }
}
