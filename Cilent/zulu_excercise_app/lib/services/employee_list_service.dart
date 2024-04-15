import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zulu_excercise_app/model/employee_model.dart';

class ListService {
  static const String BASE_URL = "http://172.16.208.186/api/";

  static Future<List<Employee>> getEmployeeList() async {
    final response = await http.get(Uri.parse("${BASE_URL}get_list"));

    try {
      if (response.statusCode == 200) {
        final List<dynamic> jsonData =
            jsonDecode(response.body)['employee_list'];
   

        return jsonData.map((e) => Employee.fromJson(e)).toList();
      } else {
        throw Exception(
            'Failed to fetch employee list: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching employee list: $e');
      throw Exception('Failed to fetch employee list');
    }
  }
}
