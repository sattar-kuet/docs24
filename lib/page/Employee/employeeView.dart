import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mailbox/components/inputBox.dart';
import 'package:mailbox/page/Employee/Model/employeeModel.dart';
import 'package:mailbox/page/Employee/Provider/employeeProvider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../Home/components/MenuDrawer.dart';

class EmployeeView extends StatelessWidget {
  const EmployeeView({super.key});

  @override
  Widget build(BuildContext context) {
    EmployeeModel args =
        ModalRoute.of(context)!.settings.arguments as EmployeeModel;
    // print("args ?????");
    // print(args);
    return ChangeNotifierProvider(
      create: (context) => EmployeeProvider()
        ..existingEmployeeInitialize(args)
        ..initializePositionListAction(),
      child: Consumer<EmployeeProvider>(builder: (context, stateAction, __) {
        return LoadingOverlay(
          isLoading: stateAction.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Employee Mangement",
              ),
              centerTitle: true,
            ),
            drawer: const MenuDrawer(),
            body: SafeArea(
                child: SizedBox(
              width: 100.w,
              height: 100.h,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                      InputBox(
                        controller: stateAction.name,
                        helperText: '',
                        hintText: 'Name',
                        isNumber: false,
                        type: TextInputType.text,
                        onChange: (String value) =>
                            Provider.of<EmployeeProvider>(context,
                                    listen: false)
                                .btnEnableaction(),
                      ),
                      InputBox(
                        controller: stateAction.email,
                        helperText: '',
                        hintText: 'Email',
                        isNumber: false,
                        type: TextInputType.emailAddress,
                        onChange: (String value) =>
                            Provider.of<EmployeeProvider>(context,
                                    listen: false)
                                .btnEnableaction(),
                      ),
                      IntlPhoneField(
                        controller: stateAction.phone,
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        initialCountryCode: stateAction.countryISOCode,
                        onChanged: (phone) {
                          Provider.of<EmployeeProvider>(context, listen: false)
                              .btnEnableaction();
                          
                          stateAction.countryCode = phone.countryCode;
                          stateAction.countryISOCode = phone.countryISOCode;
                        },
                      ),
                      Align(
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            child: EasyAutocomplete(
                              initialValue: stateAction.position.text,
                              decoration: const InputDecoration(
                                labelText: "Position",
                              ),
                              suggestions: stateAction.positionList,
                              onChanged: (value) {
                                Provider.of<EmployeeProvider>(context,
                                        listen: false)
                                    .btnEnableaction();
                                stateAction.position.text = value;
                              },
                              onSubmitted: (value) {
                                Provider.of<EmployeeProvider>(context,
                                        listen: false)
                                    .btnEnableaction();
                                stateAction.position.text = value;
                              },
                            )),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        width: 70.w,
                        height: 10.w,
                        child: ElevatedButton(
                          onPressed: !stateAction.btnEnable
                              ? null
                              : () => Provider.of<EmployeeProvider>(context,
                                      listen: false)
                                  .employeeCreateORupdate(context),
                          child: Text(
                            "Save",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                    ],
                  ),
                ),
              ),
            )),
          ),
        );
      }),
    );
  }
}
