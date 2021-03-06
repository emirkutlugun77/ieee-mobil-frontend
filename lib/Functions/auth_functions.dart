import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_app/UI/auth/login.dart';
import 'package:my_app/UI/models/user.dart';
import 'package:my_app/UI/profile/new_register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

const baseUri = 'https://ancient-falls-28306.herokuapp.com/';
final translator = GoogleTranslator();

Future<dynamic> loginUser(String email, String password) async {
  var response = await http.post(Uri.parse(baseUri + 'v1/auth/login'),
      body: {'email': email, 'password': password});
  if (response.statusCode == 200) {
    var decodedData = jsonDecode(response.body);
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', decodedData['token']);

    var token = prefs.getString('token');

    User user = await getMe(token!);
    return user;
  } else {
    var errorMessage;
    await translator
        .translate(
            jsonDecode(response.body)['errors'] != null
                ? jsonDecode(response.body)['errors'].length >= 1
                    ? jsonDecode(response.body)['errors'][0]
                    : 'Böyle bir hesap bulunamadı'
                : 'Giriş Hatası',
            from: 'en',
            to: 'tr')
        .then((value) => errorMessage = value.text);

    return errorMessage;
  }
}

Future<dynamic> registerUser(String name, String surname, Education education,
    String email, String password) async {
  try {
    var response =
        await http.post(Uri.parse(baseUri + 'v1/auth/register'), body: {
      'email': email,
      'name': name,
      'surname': surname,
      'education[university]': education.university,
      'education[department]': education.department,
      'education[year]': education.year.toString(),
      'password': password
    });
    var decodedData = jsonDecode(response.body);
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', decodedData['token']);

    User user = await getMe(decodedData['token']);
    prefs.setString('id', user.id);
    prefs.setBool('logged', true);
    return user;
  } catch (e) {}
}

Future forgotPassword(String email) async {
  var response = await http.post(Uri.parse(baseUri + 'v1/auth/password/forgot'),
      body: {'email': email});

  if (response.statusCode != 200) {
    return false;
  } else {
    return true;
  }
}

Future checkMailToken(String mailToken) async {
  var response =
      await http.get(Uri.parse(baseUri + 'v1/auth/password/$mailToken'));
  if (response.statusCode != 200) {
    return false;
  } else {
    return true;
  }
}

Future resetPassword(String newPassword, String token) async {
  var response = await http.post(Uri.parse(baseUri + 'v1/auth/password/reset'),
      body: {'mailTokenId': token, 'password': password});

  if (response.statusCode != 200) {
    return false;
  } else {
    return true;
  }
}

Future getMe(String token) async {
  var response = await http.get(Uri.parse(baseUri + 'v1/users/me'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
  if (response.statusCode == 400) {
  } else {
    var decodedData = jsonDecode(response.body);

    return User.fromJson(decodedData['user']);
  }
}

Future getUser(String id) async {
  var response = await http.get(Uri.parse(baseUri + 'v1/users/$id'));
  if (response.statusCode == 400) {
  } else {
    var decodedData = jsonDecode(response.body);

    return User.fromJson(decodedData['user']);
  }
}

Future<dynamic> registerUserToClub(
    num serialNum,
    String name,
    DateTime birthDate,
    String email,
    String faculty,
    String department,
    String phoneNumber,
    bool wantToGetEmail,
    int receiptNumber) async {
  try {
    var response =
        await http.post(Uri.parse(baseUri + 'v1/auth/register-new'), body: {
      'serialNumber': '10',
      'name': name,
      'faculty': faculty,
      'department': department,
      'registerDate': DateTime.now().toString(),
      'birthDate': birthDate.toString(),
      'email': email,
      'phoneNo': phoneNumber,
      'wantToGetEmail': wantToGetEmail.toString(),
      'receiptNumber': receiptNumber.toString(),
    });
    print(response.statusCode);
    return response.statusCode;
  } catch (e) {
    print(e);
    return e;
  }
}
