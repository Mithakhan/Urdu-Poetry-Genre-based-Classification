
import 'package:http/http.dart' as http;

class Poetry {
  final String data;
  final String label;

  Poetry({required this.data, required this.label});

  factory Poetry.fromJson(Map<String, dynamic> json) {
    return Poetry(
      data: json['Data'],
      label: json['Label'],
    );
  }
}

Future<Poetry> makeprediction(String data) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:12345/predict/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'Data': data,
    }),
  );
  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Poetry.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to make prediction.');
  }
}
