import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:luit_dealer/core/error/server_exception.dart';
import 'package:luit_dealer/core/local/local_repo.dart';
import 'package:luit_dealer/core/services/api_urls.dart';
import 'package:http_parser/http_parser.dart';
import 'package:luit_dealer/features/auth/viewModel/user_view_model.dart';
import 'package:mime/mime.dart';

class HttpWrapper {
  static Future<String?> token() async {
    String? token = await LocalRepo.fetchLocalData('token');
    return token;
  }

  static Future<Map<String, String>> header() async {
    if (await token() == null) {
      return {
        'content-type': 'application/json',
      };
    } else {
      return {
        'content-type': 'application/json',
        'Authorization': 'Bearer ${await token()}'
      };
    }
  }

  //   : {'content-type': 'application/json', 'Authorization': 'Bearer $token'};

  static Future<http.Response> getRequest(String value) async {
    try {
      final Uri url = Uri.parse(base_url + value);
      final res = await http.get(url, headers: await header());
      return res;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  static Future<http.Response> postRequest(String value, Object? body) async {
    try {
      Logger().w(body);
      final Uri url = Uri.parse(base_url + value);
      final res =
          await http.post(url, body: jsonEncode(body), headers: await header());
      return res;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  static multipartRequest(
      {required String endpoint,
      required Map<String, String> fields,
      required List<Map<String, String>> imagePaths}) async {
    try {
      final Uri url = Uri.parse(base_url + endpoint);
      final req = await http.MultipartRequest('POST', url);
      req.headers['Authorization'] = 'Bearer ${await token()}';

      req.fields.addAll(fields);
      if (imagePaths.isNotEmpty) {
        for (var image in imagePaths) {
          for (var entry in image.entries) {
            final String key = entry.key;
            final String path = entry.value;
            final String? mimeType = lookupMimeType(path);

            if (mimeType != null) {
              final List<String> mimeTypeParts = mimeType.split('/');
              final filereq = await http.MultipartFile.fromPath(
                key,
                path,
                contentType: MediaType(mimeTypeParts[0], mimeTypeParts[1]),
              );
              req.files.add(filereq);
            }
          }
        }
      }
      final streamedResponse = await req.send();
      Logger().w(streamedResponse.statusCode);
      final res = await streamedResponse.stream.bytesToString();
      final data = jsonDecode(res);
      Logger().w('Response-------> $data');
      if (streamedResponse.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  static Widget networkImageRequest(String src) {
    try {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          src,
          //   fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              );
            }
          },
          errorBuilder: (context, error, stackTrace) => Image.asset(
            'assets/icons/image 15.png',
            fit: BoxFit.cover,
          ),
        ),
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
