import 'package:api/api/model/user.dart';

class APIResponse {
  bool? status;
  String? message;
  User? object;
  int? code;

  APIResponse({this.status, this.message, this.object, this.code});

  APIResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['object'] != null) {
      object = User.fromJson(json['object']);
    }
    if (json['code'] != null) {
      code = json['code'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['object'] = object;
    data['code'] = code;
    return data;
  }
}
