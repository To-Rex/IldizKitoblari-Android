import 'package:ildiz_kitoblari/models/books/text_book_model.dart';

class BooksModel {
  List<TextBookModel>? book;
  int? appPages;

  BooksModel({this.book, this.appPages});

  BooksModel.fromJson(Map<String, dynamic> json) {
    if (json['book'] != null) {
      book = <TextBookModel>[];
      json['book'].forEach((v) {
        book!.add(TextBookModel.fromJson(v));
      });
    }
    appPages = json['appPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (book != null) {
      data['book'] = book!.map((v) => v.toJson()).toList();
    }
    data['appPages'] = appPages;
    return data;
  }
}