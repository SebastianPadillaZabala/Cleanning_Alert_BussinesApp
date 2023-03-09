import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestAssistant {
  static Future<dynamic> receiveRequest(String url) async {
    http.Response httpResponse = await http.get(Uri.parse(url));
    try {
      if (httpResponse.statusCode == 200) {
        String responseData = httpResponse.body;

        var decodeResponseData = jsonDecode(responseData);
        return decodeResponseData;
      } else {
        return 'ERROR AN OCCURRED, FAILED TO RESPONSE.';
      }
    } catch (exp) {
      return 'ERROR AN OCCURRED, FAILED TO RESPONSE.';
    }
  }
}
