import 'dart:convert';
import 'dart:io';
import 'package:api/api/model/ApiImageResplose.dart';
import 'package:api/api/model/student_image.dart';
import 'package:api/controller/api_helper.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../model/api_response.dart';
import 'api_setting.dart';

class StudentApiController with ApiHelper {
  final String BASE_URL = "http://demo-api.mr-dev.tech/api/students/auth/";

  Future<APIResponse> register({email, password, full_name, gender}) async {
    Uri uri = Uri.parse("${BASE_URL}$registerUrl");
    http.post(uri);
    var data = {
      'email': email,
      'password': password,
      'full_name': full_name,
      'gender': gender
    };

    http.Response response = await http.post(uri, body: data);

    return APIResponse.fromJson(jsonDecode(response.body));
  }

  Future<APIResponse> login({email, password}) async {
    Uri uri = Uri.parse("${BASE_URL}$loginUrl");
    http.post(uri);
    var data = {
      'email': email,
      'password': password,
    };
    http.Response response = await http.post(uri, body: data);

    return APIResponse.fromJson(jsonDecode(response.body));
  }

  Future<APIResponse> forgotPassword({required String email}) async {
    Uri uri = Uri.parse("${BASE_URL}$forgetPassword");
    var response = await http.post(uri, body: {'email': email});

    return APIResponse.fromJson(jsonDecode(response.body));
  }

  Future<APIResponse> resetPassword({
    required String email,
    required String code,
    required String password,
  }) async {
    Uri uri = Uri.parse("${BASE_URL}$forgetPassword");
    var response = await http.post(uri, body: {
      'email': email,
      'code': code,
      'password': password,
      'password_confirmation': password,
    });

    return APIResponse.fromJson(jsonDecode(response.body));
  }

  Future<List<StudentImage>> getStudentImage() async {
    List<StudentImage> l = [];
    Uri URI = Uri.parse("http://demo-api.mr-dev.tech/api/student/images");
    http.Response response = await http.get(URI, headers: {
      HttpHeaders.authorizationHeader: "Bearer ${GetStorage().read('token')}",
      HttpHeaders.acceptCharsetHeader: "application/json"
    });
    if (response.statusCode == 200) {
      var array = jsonDecode(response.body);
      array['data'].forEach((e) => l.add(StudentImage.fromJson(e)));
      return l;
    }
    return [];
  }

  Future<APIImageResponse?> uploadImage(String path) async {
    Uri URI = Uri.parse("http://demo-api.mr-dev.tech/api/student/images");

    http.MultipartRequest request = http.MultipartRequest("POST", URI);
    request.files.add(await http.MultipartFile.fromPath("image", path));
    request.headers[HttpHeaders.authorizationHeader] =
        "Bearer ${GetStorage().read('token')}";
    request.headers[HttpHeaders.acceptCharsetHeader] = "application/json";
    // request.fields[''] = value;
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 400) {
      var body = await response.stream.transform(utf8.decoder).first;
      print(body);
      var jsonResponse = jsonDecode(body);
      return APIImageResponse.fromJson(jsonResponse);
    }
    return null;
  }

//http://demo-api.mr-dev.tech/api/students/auth/logout
  Future<APIResponse> logout() async {
    Uri uri = Uri.parse("http://demo-api.mr-dev.tech/api/students/auth/logout");
    var response = await http.get(uri, headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 401) {
      await GetStorage().erase();
      var jsonResponse = jsonDecode(response.body);
      return APIResponse(
          message: response.statusCode == 200
              ? jsonResponse['message']
              : 'Logged out successfully',
          status: true);
    }
    return failedResponse;
  }
}
