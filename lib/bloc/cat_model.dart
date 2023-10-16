// To parse this JSON data, do
//
//     final catModel = catModelFromJson(jsonString);

import 'dart:convert';

CatModel catModelFromJson(String str) => CatModel.fromJson(json.decode(str));

String catModelToJson(CatModel data) => json.encode(data.toJson());

class CatModel {
  String? description;
  String? imageUrl;
  int? statusCode;

  CatModel({
    this.description,
    this.imageUrl,
    this.statusCode,
  });

  factory CatModel.fromJson(Map<String, dynamic> json) => CatModel(
        description: json["description"],
        imageUrl: json["imageUrl"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "imageUrl": imageUrl,
        "statusCode": statusCode,
      };
}
