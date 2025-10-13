//consumo de la API desde flutter

import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/usermodel.dart';
import 'package:http/http.dart' as http;

Future<List<Usermodel>> obtenerUsuarios() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:3000/usuarios'));

  return compute(decodeJson, response.body);
}

List<Usermodel> decodeJson(String responseBody) {
  final List<dynamic> parsed = json.decode(responseBody);
  return parsed.map<Usermodel>((json) => Usermodel.fromJson(json)).toList();
}
