class Imagee {
  int? id;
  String? image;
  String? info;
  String? userId;
  String? visible;

  Imagee({this.id, this.image, this.info, this.userId, this.visible});

  Imagee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    info = json['info'];
    userId = json['user_id'];
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['info'] = info;
    data['user_id'] = userId;
    data['visible'] = visible;
    return data;
  }
}
