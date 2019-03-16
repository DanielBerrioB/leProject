import "package:http/http.dart" as http;
import "dart:async";
import "dart:convert";

/// This class represents the call from an API.
class HttpResponse {
  /// This function return a Future String
  /// which will be used to get the elements
  /// ignore: slash_for_doc_comments
  /// from the JSON.
  Future<List> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/albums?userId=4"),
        headers: {"Accept": "application/json"});
    return jsonDecode(response.body);
  }
}
