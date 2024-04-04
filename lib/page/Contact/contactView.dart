import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mailbox/components/inputBox.dart';
import 'package:mailbox/page/Contact/Model/contactModel.dart';
import 'package:mailbox/page/Contact/Provider/contactProvider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../utility/helper.dart';
import '../Home/components/MenuDrawer.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    ContactModel args =
        ModalRoute.of(context)!.settings.arguments as ContactModel;

    return ChangeNotifierProvider(
      create: (context) => ContactProvider()..existingContactInitialize(args),
      child: Consumer<ContactProvider>(builder: (context, stateAction, __) {
        return LoadingOverlay(
          isLoading: stateAction.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Contact Mangement",
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
                            Provider.of<ContactProvider>(context, listen: false)
                                .btnEnableaction(),
                      ),
                      InputBox(
                        controller: stateAction.email,
                        helperText: stateAction.emailStateText,
                        hintText: 'Email',
                        isNumber: false,
                        type: TextInputType.emailAddress,
                        onChange: (String value) {
                          if (isValidEmail(value)) {
                            stateAction.updateEmailState('Valid Email', true);
                          } else {
                            stateAction.updateEmailState(
                                'Invalid Email', false);
                          }
                          Provider.of<ContactProvider>(context, listen: false)
                              .btnEnableaction();
                        },
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
                          Provider.of<ContactProvider>(context, listen: false)
                              .btnEnableaction();
                          stateAction.countryCode = phone.countryCode;
                          stateAction.countryISOCode = phone.countryISOCode;
                        },
                      ),
                      InputBox(
                        controller: stateAction.companyName,
                        helperText: '',
                        hintText: 'Company Name',
                        type: TextInputType.text,
                        onChange: (String value) =>
                            Provider.of<ContactProvider>(context, listen: false)
                                .btnEnableaction(),
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
                              : () => Provider.of<ContactProvider>(context,
                                      listen: false)
                                  .contactCreateORupdate(context),
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
