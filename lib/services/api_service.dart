import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:users_test/config/api_config.dart';
import 'package:users_test/models/post_model.dart';
import 'package:users_test/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:users_test/services/api_status.dart';

class UserApiProvider {
  Future<Object> getAllUsers() async {
    var url = usersEndpoint;

    try {
      final response = await http
          .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return Success(response: userFromJson(utf8.decode(response.bodyBytes)));
      }
      return Failure(code: 100, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: 101, errorResponse: 'No Internet');
    } catch (e) {
      debugPrint(e.toString());
      return Failure(code: 103, errorResponse: 'Unknown Error');
    }
  }

  Future<Object> getUserPosts(int id) async {
    var url = postEndpoint + id.toString();

    try {
      final response = await http
          .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return Success(response: postFromJson(utf8.decode(response.bodyBytes)));
      }
      return Failure(code: 100, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: 101, errorResponse: 'No Internet');
    } catch (e) {
      debugPrint(e.toString());
      return Failure(code: 103, errorResponse: 'Unknown Error');
    }
  }
}
