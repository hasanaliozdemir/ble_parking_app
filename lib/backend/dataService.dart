import 'package:gesk_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class DataService {
  final String _url = "159.146.47.86";
  final String _port = "39140";

  Future<User> registerUser(
      String name, String password, String phone, String mail) async {
    Uri _uri = Uri.parse(_url + ":" + _port + "/setInfo/");
    Map<String, dynamic> _payloadBody = {
      "register": {
        "name": name,
        "password": password,
        "phone": phone,
        "mail": mail
      }
    };

    var _postJson = convert.jsonEncode(_payloadBody);

    var _response = await http.post(_uri, body: _postJson);

    var _responseJson = convert.jsonDecode(_response.body);

    var _user = User.fromJson(_responseJson);

    return _user;
  }
}
