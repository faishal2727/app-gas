import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../model/gas.dart';
import '../model/inventory.dart';
import '../model/user.dart';

class ApiService {
  static const String baseUrl =
      'https://gaskeun-production.up.railway.app/';

  Future<String?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/user/signin');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final token = response.body;
      print("NGENT $token");
      return token;
    } else {
      final errorMessage = response.body;
      throw Exception(errorMessage);
    }
  }

  Future<String?> inventory(
      String gasIjo, String brightGas, String blueGas) async {
    final url = Uri.parse('$baseUrl/inventory');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(
        {'gasIjo': gasIjo, 'brightGas': brightGas, 'blueGas': blueGas});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      final code = response.statusCode;
      final inV = response.body;
      print("NGENT $inV");
      print("codeW $code");
      return inV;
    } else {
      final code = response.statusCode;
      print("code $code");
      final errorMessage = response.body;
      print("eyoy $errorMessage");
      throw Exception(errorMessage);
    }
  }

  Future<void> register(
      String name, String email, String password, String rePassword) async {
    final url = Uri.parse('$baseUrl/user/signup');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
      're_password': rePassword,
    });
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print("SUKSES DAFTAR");
    } else {
      final errorMessage = response.body;
      throw Exception(errorMessage);
    }
  }

  Future<User> getCurrentUser(String token) async {
    final url = Uri.parse('$baseUrl/user/current');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(url, headers: headers);
    print("AMAN ${token}");
    if (response.statusCode == 200) {
      final userJson = jsonDecode(response.body);
      Map<String, dynamic> newData = {
        'name': userJson['data']['name'],
        'email': userJson['data']['email']
      };
      print("PERDI ${userJson}");
      final user = User.fromJson(newData);
      return user;
    } else {
      final errorMessage = response.body;
      throw Exception(errorMessage);
    }
  }

  Future<String> updateUser(
      String token, String newName, String newEmail) async {
    final url = Uri.parse('$baseUrl/user/update');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = jsonEncode({'name': newName, 'email': newEmail});

    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse.containsKey('message')) {
        final message = jsonResponse['message'] as String;
        return message;
      } else {
        throw Exception('Format respons tidak valid');
      }
    } else {
      final errorMessage = response.body;
      throw Exception(errorMessage);
    }
  }

  Future<List<Gas>> getListGas() async {
    final url = Uri.parse('$baseUrl/list/gas');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse.containsKey('data') && jsonResponse['data'] is List) {
        final gasList = <Gas>[];
        final data = jsonResponse['data'];
        for (var item in data) {
          if (item is Map<String, dynamic>) {
            final gas = Gas(
              id: item['id'].toString(),
              gasName: item['gasName'].toString(),
              image: item['image'].toString(),
              size: item['size'].toString(),
              currentStock: item['currentStock'].toString(),
              mustStock: item['mustStock'].toString(),
              minStock: item['minStock'].toString(),
              noHpDist: item['noHpDist'].toString(),
            );
            gasList.add(gas);
          }
        }
        return gasList;
      } else {
        throw Exception('Format respons tidak valid');
      }
    } else {
      final errorMessage = response.body;
      throw Exception(errorMessage);
    }
  }

  Future<void> sendEmail(String email) async {
    final String url = '$baseUrl/user/forgot-password';

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal mengirim email');
    }
  }

  Future<List<Inventory>> getListInventory() async {
    final url = Uri.parse('$baseUrl/list/inventory');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse.containsKey('data') && jsonResponse['data'] is List) {
        final inventoryList = <Inventory>[];
        final data = jsonResponse['data'];
        for (var item in data) {
          if (item is Map<String, dynamic>) {
            final inventory = Inventory(
              id: item['id'].toString(),
              blueGas: item['blueGas'].toString(),
              brightGas: item['brightGas'].toString(),
              gasIjo: item['gasIjo'].toString(),
              createdAt: _parseDateTime(item['created_at']),
            );
            inventoryList.add(inventory);
          }
        }
        return inventoryList;
      } else {
        throw Exception('Format respons tidak valid');
      }
    } else {
      final errorMessage = response.body;
      throw Exception(errorMessage);
    }
  }

  DateTime _parseDateTime(String dateString) {
    final dateFormat = DateFormat('EEE, dd MMM yyyy HH:mm:ss z');
    return dateFormat.parse(dateString);
  }
}
