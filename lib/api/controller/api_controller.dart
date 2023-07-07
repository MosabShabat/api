import 'dart:convert';
import 'package:api/api/model/family.dart';
import 'package:http/http.dart' as http;
import '../model/post.dart';
import '../model/userController.dart';

class ApiController {
  final String BASE_URL = "https://jsonplaceholder.typicode.com/";
//mosab shabat
  Future<List<Post>> getAllPost() async {
    List<Post> l = [];
    Uri URI = Uri.parse("${BASE_URL}posts");
    http.Response response = await http.get(URI);
    if (response.statusCode == 200) {
      var array = jsonDecode(response.body);
      array.forEach((e) => l.add(Post.fromJson(e)));
      return l;
    }
    return [];
  }

  Future<Post?> getOnePost(id) async {
    Post l;
    Uri URI = Uri.parse("${BASE_URL}posts/$id");
    http.Response response = await http.get(URI);
    if (response.statusCode == 200) {
      var object = jsonDecode(response.body);
      l = Post.fromJson(object);
      return l;
    }
    return null;
  }

  Future<UserController?> GetOneUser(id) async {
    UserController l;
    Uri URI = Uri.parse("${BASE_URL}users/$id");
    http.Response response = await http.get(URI);
    if (response.statusCode == 200) {
      var object = jsonDecode(response.body);
      l = UserController.fromJson(object);
      return l;
    }
    return null;
  }

  Future<List<Familly>> getFamilyMembers({page,pc,lang,offset,row}) async {
    var parms = {
      'patientCode':pc,
      'pageNo':page,
      'offset':offset,
      'rows':row,
      'lang':lang
    };
    Uri URI = Uri.http('aiph.me:8000','/api/patient/familyMembers',parms);

    print(URI);
    List<Familly> l = [];
    http.Response response = await http.get(URI);
    if(response.statusCode == 200){
      var jsonObject = jsonDecode(response.body);
      List array = jsonObject['familyMembers'];
       array.forEach((element) {
         l.add(Familly.fromJson(element));
       });
    }
    return l;
  }
}
