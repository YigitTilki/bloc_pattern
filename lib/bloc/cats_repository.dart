import 'dart:convert';
import 'dart:io';

import 'package:bloc_pattern/bloc/cat_model.dart';
import 'package:http/http.dart' as http;

abstract class CatsRepository {
  Future<List<CatModel>> getCats();
}

class SampleCatsRepository implements CatsRepository {
  final baseUrl = "https://hwasampleapi.firebaseio.com/http.json";
  @override
  Future<List<CatModel>> getCats() async {
    final response = await http.get(
      Uri.parse(baseUrl),
    );
    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonBody = jsonDecode(response.body) as List;
        return jsonBody.map((e) => CatModel.fromJson(e)).toList();
      default:
        throw NetworkError(response.statusCode.toString(), response.body);
    }
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;
  NetworkError(this.statusCode, this.message);
}
