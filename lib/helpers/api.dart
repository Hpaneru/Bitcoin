import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiHelper {
  Future<List> getUsers() async {
    http.Response response = await http
        .get(Uri.encodeFull("https://api.coinlore.com/api/tickers"), headers: {"Accept": "application/json"});
    print(response.body);
    return json.decode(response.body)["data"];
  }
}
