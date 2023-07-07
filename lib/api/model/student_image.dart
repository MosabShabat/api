class StudentImage {
  int? id;
  String? image;
  String? studentId;
  String? imageUrl;

  StudentImage({this.id, this.image, this.studentId, this.imageUrl});

  StudentImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    if (json['student_id'] is int?) {
      studentId = json['student_id'].toString();
    }
   // studentId = json['student_id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['student_id'] = studentId;
    data['image_url'] = imageUrl;
    return data;
  }
}
