// To parse this JSON data, do
//
//     final toggleFavoriteModel = toggleFavoriteModelFromJson(jsonString);

import 'dart:convert';

ToggleFavoriteModel toggleFavoriteModelFromJson(String str) =>
    ToggleFavoriteModel.fromJson(json.decode(str));

String toggleFavoriteModelToJson(ToggleFavoriteModel data) =>
    json.encode(data.toJson());

class ToggleFavoriteModel {
  ToggleFavoriteModel({
    this.validationErrors,
    this.hasError,
    this.message,
    this.data,
  });

  final List<ValidationError>? validationErrors;
  final bool? hasError;
  final String? message;
  final List<dynamic>? data;

  factory ToggleFavoriteModel.fromJson(Map<String, dynamic> json) =>
      ToggleFavoriteModel(
        validationErrors: json["ValidationErrors"] == null
            ? null
            : List<ValidationError>.from(json["ValidationErrors"]
                .map((x) => ValidationError.fromJson(x))),
        hasError: json["HasError"],
        message: json["Message"],
        data: json["Data"] == null
            ? null
            : List<dynamic>.from(json["Data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ValidationErrors": validationErrors == null
            ? null
            : List<dynamic>.from(validationErrors!.map((x) => x.toJson())),
        "HasError": hasError,
        "Message": message,
        "Data": data == null ? null : List<dynamic>.from(data!.map((x) => x)),
      };
}

class ValidationError {
  ValidationError({
    this.key,
    this.value,
  });

  final String? key;
  final String? value;

  factory ValidationError.fromJson(Map<String, dynamic> json) =>
      ValidationError(
        key: json["Key"],
        value: json["Value"],
      );

  Map<String, dynamic> toJson() => {
        "Key": key,
        "Value": value,
      };
}
