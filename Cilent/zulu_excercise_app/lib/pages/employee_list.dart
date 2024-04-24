import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zulu_excercise_app/model/employee_model.dart';
import 'package:zulu_excercise_app/services/employee_list_service.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({Key? key}) : super(key: key);

  @override
  _EmployeeListPageState createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  late Future<List<Employee>> _employeeList;

  @override
  void initState() {
    super.initState();
    _loadEmployeeList();
  }

  void _loadEmployeeList() {
    _employeeList = ListService.getEmployeeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
         await ListService.addEmployee("Logesh", "2017-04-15", true);
          // setState(() {
          // _loadEmployeeList();
          // });
          // Reload the employee list after adding a new employee
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        title: Text("Employee List"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey.shade300,
      ),
      body: FutureBuilder<List<Employee>>(
        future: _employeeList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final List<Employee> list = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final employee = list[index];
                final isLongTermActiveEmployee = employee.active &&
                    DateTime.now().difference(employee.joinDate).inDays >= 1825;
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: isLongTermActiveEmployee
                        ? Colors.green
                        : Colors.grey.shade300,
                  ),
                  child: ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue.shade200,
                      ),
                      child: Center(
                        child: Text(
                          "${employee.name[0]}",
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                    ),
                    title: Text(employee.name),
                    subtitle: Text(
                      'Joined: ${DateFormat('MMM d, yyyy').format(employee.joinDate)}',
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
