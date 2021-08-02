import 'dart:convert';

import 'package:http/http.dart' as http;

Future getdata(url) async {
 
   try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        print("DATA FETCHED SUCCESSFULLY");
        var result = jsonDecode(response.body);
        print(result["prediction"]);
        return result["prediction"];
      }
    } catch (e) {
      print("EXCEPTION OCCURRED: $e");
      return null;
  
}
}