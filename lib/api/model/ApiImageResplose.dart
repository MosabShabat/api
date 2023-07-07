import 'package:api/api/model/student_image.dart';

class APIImageResponse {
  bool? status;
  String? message;
  StudentImage? object;

  APIImageResponse({this.status, this.message, this.object});

  APIImageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    object = json['object'] != null
        ? new StudentImage.fromJson(json['object'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (object != null) {
      data['object'] = object!.toJson();
    }
    return data;
  }
}

class Object {
  String? image;
  int? studentId;
  int? id;
  String? imageUrl;

  Object({this.image, this.studentId, this.id, this.imageUrl});

  Object.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    studentId = json['student_id'];
    id = json['id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = image;
    data['student_id'] = studentId;
    data['id'] = id;
    data['image_url'] = imageUrl;
    return data;
  }
}
