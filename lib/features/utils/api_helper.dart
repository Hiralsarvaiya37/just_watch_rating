import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static final http.Client _client = http.Client();

  static Map<String, String> defaultHeaders = {
    "Content-Type": "application/json",
  };

  /// ==================== GET ====================
  static Future<http.Response> get({
    required String url,
    Map<String, String>? headers,
  }) async {
    try {
      debugPrint("GET => $url");

      final response = await _client
          .get(Uri.parse(url), headers: headers ?? defaultHeaders)
          .timeout(Duration(seconds: 30));

      return _handleResponse(response);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// ==================== POST ====================
  static Future<http.Response> post({
    required String url,
    required String body,
    Map<String, String>? headers,
  }) async {
    try {
      debugPrint("POST => $url\nBody: $body");

      final response = await _client
          .post(Uri.parse(url), body: body, headers: headers ?? defaultHeaders)
          .timeout(Duration(seconds: 30));

      return _handleResponse(response);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// ==================== PUT ====================
  static Future<http.Response> put({
    required String url,
    required String body,
    Map<String, String>? headers,
  }) async {
    try {
      debugPrint("PUT => $url\nBody: $body");

      final response = await _client
          .put(Uri.parse(url), body: body, headers: headers ?? defaultHeaders)
          .timeout(Duration(seconds: 30));

      return _handleResponse(response);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// ==================== DELETE ====================
  static Future<http.Response> delete({
    required String url,
    Map<String, String>? headers,
  }) async {
    try {
      debugPrint("DELETE => $url");

      final response = await _client
          .delete(Uri.parse(url), headers: headers ?? defaultHeaders)
          .timeout(Duration(seconds: 30));

      return _handleResponse(response);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// ==================== COMMON RESPONSE HANDLER ====================
  static http.Response _handleResponse(http.Response response) {
    log("STATUS CODE: ${response.statusCode}");
    log("RESPONSE BODY: ${response.body}");

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw Exception(
        "API Error: ${response.statusCode} - ${response.reasonPhrase}",
      );
    }
  }

  /// ==================== ERROR HANDLER ====================
  static void _handleError(Object error) {
    debugPrint("API ERROR: $error");
  }
}
