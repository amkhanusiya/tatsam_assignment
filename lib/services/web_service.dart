import 'dart:convert';

import 'package:tatsam_assignment/models/country.dart';
import 'package:http/http.dart' as http;

class WebService {
  Future<Map<String, dynamic>> fetchCountries(int offset) async {
    final url = "https://api.first.org/data/v1/countries?offset=$offset";
    print(url);
    final response = await http.get(url);
    // print(response.body);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final Map<String, dynamic> json = body["data"];
      // print(json);
      final _response = Map<String, dynamic>();
      _response['countries'] =
          json.keys.map((key) => Country.fromJson(key, json[key])).toList();
      _response['offset'] = body["offset"];
      _response['limit'] = body["limit"];
      _response['total'] = body["total"];
      return _response;
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
