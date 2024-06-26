import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_maimaid/services/end_point.dart';

class HomeServices {
  static Future dataListUser(int page) async {
    print('dataListUser Service');
    var response = await http.get(
      Uri.parse('$baseUrl/users?page=$page'),
      headers: {
        'Accept': '*/*',
        'Content-Type': 'application/json',
      },
    );

    debugPrint("Data List User RES : " + response.body);
    if (response.statusCode != 200) return json.decode(response.body);
    return json.decode(response.body);
  }

  static Future addListUserService(String name, String job) async {
    print('addListUser Service');
    var response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {
        'Accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'name': name,
          'job': job,
        },
      ),
    );

    debugPrint("Add List User RES : " + response.body);
    if (response.statusCode != 200) return json.decode(response.body);
    return json.decode(response.body);
  }

  static Future updateListUserService(String name, String job, int id) async {
    print('updateListUser Service');
    var response = await http.put(
      Uri.parse('$baseUrl/users/$id'),
      headers: {
        'Accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'name': name,
          'job': job,
        },
      ),
    );

    debugPrint("Update List User RES : " + response.body);
    if (response.statusCode != 200) return json.decode(response.body);
    return json.decode(response.body);
  }

  static Future deleteListUserService(int id) async {
    print('deleteListUser Service');
    print('$baseUrl/users/$id');
    var response = await http.delete(
      Uri.parse('$baseUrl/users/$id'),
      headers: {
        'Accept': '*/*',
        'Content-Type': 'application/json',
      },
    );

    debugPrint("Delete List User RES : " + response.body);
    if (response.statusCode != 200 || response.statusCode == 204) {
      return {
        'success': true,
        'message': response.statusCode == 204
            ? 'User berhasil dihapus, tidak ada konten yang dikembalikan'
            : json.decode(response.body),
      };
    } else {
      return {
        'error': true,
        'statusCode': response.statusCode,
        'message': json.decode(response.body)
      };
    }
  }
}
