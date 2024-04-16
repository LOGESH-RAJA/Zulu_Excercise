import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zulu_excercise_app/model/employee_model.dart';
import 'package:zulu_excercise_app/services/employee_list_service.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({super.key});

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){},
        child: Icon(Icons.add)),
        backgroundColor: Colors.grey.shade400,
        appBar: AppBar(
      
          title: Text("Employee List"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.grey.shade300,
        ),
        body: FutureBuilder(
            future: ListService.getEmployeeList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<Employee> list = snapshot.data;
                return ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final employee = snapshot.data![index];
                    final isLongTermActiveEmployee = employee.active &&
                        DateTime.now().difference(employee.joinDate).inDays >=
                            1825; // 5 years = 1825 days
                    return Container(
                      margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: isLongTermActiveEmployee
                                ? Colors.green
                                : Colors.grey.shade300),
                        child: ListTile(
                          leading: Container(child: Center(child: Text("${employee.name[0]}",style: TextStyle(fontSize: 35),)),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.shade200
                          )),
                          title: Text(employee.name),
                          subtitle: Text(
                              'Joined: ${DateFormat('MMM d, yyyy').format(employee.joinDate)}'),
                        ));
                  },
                );
              }
            }));
  }
}
