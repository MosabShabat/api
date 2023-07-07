import 'dart:convert';
import 'package:api/api/model/image.dart';
import 'package:http/http.dart' as http;

class ImageApiController {
  Future<List<Imagee>> getImage() async {
      List<Imagee> l = [];
      Uri URI = Uri.parse("http://demo-api.mr-dev.tech/api/users/2/images");
      http.Response response = await http.get(URI);
      if (response.statusCode == 200) {
        var array = jsonDecode(response.body);
        array['data'].forEach((e) => l.add(Imagee.fromJson(e)));
        return l;
      }
      return [];
    }
}