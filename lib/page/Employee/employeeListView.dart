import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:docs24/page/Employee/Model/employeeModel.dart';
import 'package:docs24/page/Employee/Provider/employeeListProvider.dart';
import 'package:docs24/page/Home/components/MenuDrawer.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EmployeeListView extends StatelessWidget {
  const EmployeeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EmployeeListProvider>(
      create: (context) => EmployeeListProvider()..getEmployeeList(),
      child: Consumer<EmployeeListProvider>(
        builder: (context, stateAction, __) {
          List<EmployeeModel> employees = stateAction.employeeList;

          return LoadingOverlay(
            isLoading: stateAction.isLoading,
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Employee List"),
                centerTitle: true,
              ),
              drawer: const MenuDrawer(),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/employeeManage',
                    arguments: EmployeeModel(),
                    (route) => false,
                  );
                },
                child: const Icon(Icons.add),
              ),
              body: SafeArea(
                child: SizedBox(
                  width: 100.w,
                  height: 100.h,
                  child: ListView.builder(
                    itemCount: employees.length,
                    itemBuilder: (context, index) {
                      EmployeeModel employee = employees[index];
                      print(employee);
                      return Card(
                        child: ListTile(
                          title: Text('Name: ${employee.name}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Email: ${employee.email}'),
                              Text('Phone: ${employee.countryCode}${employee.phone}'),
                              Text('Position: ${employee.position}'),
                            ],
                          ),
                          trailing: TextButton(
                            child: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                '/employeeManage',
                                arguments: employee,
                                (route) => false,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
