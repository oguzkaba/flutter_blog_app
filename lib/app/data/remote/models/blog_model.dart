// To parse this JSON data, do
//
//     final getBlogModel = getBlogModelFromJson(jsonString);
//url:
//http://test020.internative.net/Blog/GetBlogs
import 'dart:convert';

GetBlogModel getBlogModelFromJson(String str) =>
    GetBlogModel.fromJson(json.decode(str));

String getBlogModelToJson(GetBlogModel data) => json.encode(data.toJson());

class GetBlogModel {
  GetBlogModel({
    this.validationErrors,
    this.hasError,
    this.message,
    required this.data,
  });

  final List<dynamic>? validationErrors;
  final bool? hasError;
  final dynamic message;
  final List<Datum> data;

  factory GetBlogModel.fromJson(Map<String, dynamic> json) => GetBlogModel(
        validationErrors:
            List<dynamic>.from(json["ValidationErrors"].map((x) => x)),
        hasError: json["HasError"],
        message: json["Message"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ValidationErrors": List<dynamic>.from(validationErrors!.map((x) => x)),
        "HasError": hasError,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.title,
    this.content,
    this.image,
    this.categoryId,
    this.id,
  });

  final String? title;
  final String? content;
  final String? image;
  final String? categoryId;
  final String? id;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["Title"],
        content: json["Content"],
        image: json["Image"],
        categoryId: json["CategoryId"],
        id: json["Id"],
      );

  Map<String, dynamic> toJson() => {
        "Title": title,
        "Content": content,
        "Image": image,
        "CategoryId": categoryId,
        "Id": id,
      };
}
