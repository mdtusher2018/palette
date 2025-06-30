import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:palette/utils/api_endpoints.dart';
import 'package:palette/utils/helper.dart';
import 'local_storage_service.dart';

class ApiService {
  LocalStorageService _localStorageService = LocalStorageService();

  ApiService();

  Future<Map<String, String>> _getHeaders() async {
    final token = await _localStorageService.getToken();

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      "SignUpToken": "signUpToken $token",
      "Forget-password": "Forget-password $token",
    };
  }

  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? extraHeader,
  }) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}$endpoint');

    final headers = await _getHeaders();

    final response = await http.get(
      url,
      headers: (extraHeader != null) ? extraHeader : headers,
    );
    log(response.body);
    return _processResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}$endpoint');

    final headers = await _getHeaders();

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    return _processResponse(response);
  }

  Future<dynamic> patch(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}$endpoint');

    final headers = await _getHeaders();

    final response = await http.patch(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    return _processResponse(response);
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}$endpoint');
    final headers = await _getHeaders();

    final response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    return _processResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}$endpoint');
    final headers = await _getHeaders();

    final response = await http.delete(url, headers: headers);

    return _processResponse(response);
  }

  Future<dynamic> postMultipart({
    required String url,
    required Map<String, String> fields,
    File? imageFile,
    File? videoFile,
  }) async {
    var uri = Uri.parse(ApiEndpoints.baseUrl + url);

    var request = http.MultipartRequest('POST', uri);
    final headers = await _getHeaders();

    request.fields.addAll(fields);

    if (imageFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          contentType: MediaType('image', getMimeSubtype(imageFile.path)),
        ),
      );
    }

    if (videoFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'video',
          videoFile.path,
          contentType: MediaType('video', getMimeSubtype(videoFile.path)),
        ),
      );
    }

    request.headers.addAll(headers);

    var response = await request.send();
    final resBody = await response.stream.bytesToString();

    final statusCode = response.statusCode;
    log(resBody);
    if (statusCode >= 200 && statusCode < 300) {
      return json.decode(resBody);
    } else {
      if (statusCode == 409) {
        throw Exception('Review already submitted. Only one allowed.');
      }
      throw Exception('Failed to post feedback: ${response.statusCode}');
    }
  }

  dynamic _processResponse(http.Response response) {
    final statusCode = response.statusCode;
    final responseBody =
        response.body.isNotEmpty ? jsonDecode(response.body) : null;
    if (statusCode >= 200 && statusCode < 300) {
      return responseBody;
    } else {
      throw ApiException(
        statusCode,
        responseBody?['message'] ?? 'Unknown error',
      );
    }
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException(this.statusCode, this.message);

  @override
  String toString() => 'ApiException: $statusCode - $message';
}
