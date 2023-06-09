import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:summer_home/models/exception.dart';

class Auth with ChangeNotifier {
  late String? _token;
  late String? _userId;
  late DateTime _expiryDate;
  late String _usermail;
  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  String get usermail {
    return _usermail;
  }
  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyA7wZMVCJ8cXDyyxYHGWMqsFyNSrBbrI8k');
    //this both are genrated by firebase

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      // print(response.body);
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      //if response data is not null ie it has get values do this\

      _token = responseData['idToken'];
      _userId = responseData["localId"];
      _usermail = email;
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
  //
  // Future<void> _authenticate(
  //     String email, String password, String urlSegment) async {
  //   // final url =
  //   //     Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyA7wZMVCJ8cXDyyxYHGWMqsFyNSrBbrI8k');
  //   //this both are genrated by firebase
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyA7wZMVCJ8cXDyyxYHGWMqsFyNSrBbrI8k"),
  //       body: json.encode({
  //         'email': email,
  //         'password': password,
  //         'returnSecureToken': true,
  //       }),
  //     );
  //
  //     // print(response.body);
  //      final responseData = json.decode(response.body);
  //      if (responseData['error'] != null) {
  //        throw HttpException(responseData['error']['message']);
  //      }
  //     //if response data is not null ie it has get values do this\
  //
  //      _token = responseData['idToken'];
  //      _userId = responseData["localId"];
  //      _usermail = email;
  //      _expiryDate = DateTime.now().add(
  //        Duration(
  //          seconds: int.parse(
  //            responseData['expiresIn'],
  //          ),
  //        ),
  //      );
  //
  //     notifyListeners();
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  void logOut() {
    _token = null;
    _userId = null;
    _expiryDate = DateTime.now();
    print(_token);
    notifyListeners();
  }
}
