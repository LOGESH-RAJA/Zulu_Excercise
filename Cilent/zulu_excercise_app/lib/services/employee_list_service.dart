import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zulu_excercise_app/model/employee_model.dart';

class ListService {
  static const String BASE_URL = "http://172.16.97.201:3000/api/";

  static Future<List<Employee>> getEmployeeList() async {
    final response = await http.get(Uri.parse("${BASE_URL}get_list"));

    try {
      if (response.statusCode == 200) {
        final dynamic jsonData = jsonDecode(response.body);
        if (jsonData != null && jsonData['employee_list'] != null) {
          final List<dynamic> employeeListData = jsonData['employee_list'];
          return employeeListData.map((e) => Employee.fromJson(e)).toList();
        } else {
          throw Exception('Employee list data is null or empty');
        }
      } else {
        throw Exception(
            'Failed to fetch employee list: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching employee list: $e');
      throw Exception('Failed to fetch employee list');
    }
  }

  // ignore: non_constant_identifier_names
  static Future<void> addEmployee(
      String name, String joinDate, bool active) async {
    // Construct the request body using the parameters
    Map<String, dynamic> body = {
      "name": name.toString(),
      "joinDate": joinDate.toString(),
      "active": active.toString(), // Convert boolean to string representation
    };

    try {
      final response = await http.post(
        Uri.parse("http://172.16.97.201:3000/api/add_employee"),
        body: jsonEncode({"name": name, "joinDate": joinDate, "active": active}),
         headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        print("Employee added successfully");
        print(body);
      } else {
        throw Exception('Failed to add employee: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding employee: $e');
      throw Exception('Failed to add employee');
    }
  }
}
