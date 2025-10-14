//consumo de la API desde flutter

import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/usermodel.dart';
import 'package:http/http.dart' as http;

Future<List<Usermodel>> obtenerUsuarios() async {
  final response = await http.get(
    Uri.parse('https://apismartstream.onrender.com/usuarios'),
  );

  return compute(decodeJson, response.body);
}

List<Usermodel> decodeJson(String responseBody) {
  final List<dynamic> parsed = json.decode(responseBody) as List<dynamic>;
  return parsed.map<Usermodel>((json) => Usermodel.fromJson(json)).toList();
}

Usermodel convertirMapaObjeto(String responseBody) {
  final Map<String, dynamic> parsed =
      json.decode(responseBody) as Map<String, dynamic>;

  return Usermodel.fromJson(parsed);
}

Future<Usermodel> crearUsuario(Usermodel newuser) async {
  final response = await http.post(
    Uri.parse('https://apismartstream.onrender.com/usuarios'),
    headers: {
      'Content-Type': 'application/json',
    }, //necesario porque estamos haciendo un POST y le debemos
    //enviar al servidor el formato del cuerpo del mensaje
    body: jsonEncode(newuser.toJson()),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    final Map<String, dynamic> parsed = json.decode(response.body);
    return Usermodel.fromJson(parsed);
  } else {
    throw Exception('Error al crear usuario: ${response.statusCode}');
  }
}

Future<Usermodel> intentoLogin(Usermodel user) async {
  final response = await http.post(
    Uri.parse('https://apismartstream.onrender.com/login'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(user.toJson()),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    final Map<String, dynamic> parsed = json.decode(response.body);
    return Usermodel.fromJson(parsed);
  }

  throw Exception("Error al loguear usuario ${response.statusCode}");
}
