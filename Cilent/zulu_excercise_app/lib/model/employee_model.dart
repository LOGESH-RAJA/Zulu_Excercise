class Employee {
  final String name;
  final DateTime joinDate;
  final bool active;

  Employee({required this.name, required this.joinDate, required this.active});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        name: json["name"], joinDate: DateTime.parse(json["joinDate"]), active: json["active"]);
  }
}
