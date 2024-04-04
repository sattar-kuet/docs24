import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mailbox/components/inputBox.dart';
import 'package:mailbox/page/Auth/Register/Provider/register_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import '../../../components/logo.dart';
import '../../../utility/helper.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  void dispose() {
    Provider.of<RegisterProvider>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider.value(
        value: RegisterProvider()..getPositionListAction(),
        child: Consumer<RegisterProvider>(builder: (context, stateAction, __) {
          return LoadingOverlay(
            isLoading: stateAction.isLoading,
            child: SafeArea(
              child: SizedBox(
                width: 100.w,
                height: 100.h,
                child: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 3.h,
                          ),
                          const Align(
                            child: Logo(),
                          ),
                          Align(
                            child: Text(
                              "Join us to Send mail",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          InputBox(
                            controller: stateAction.name,
                            helperText: '',
                            hintText: 'Full Name',
                            isNumber: false,
                            type: TextInputType.name,
                            onChange: (String value) =>
                                Provider.of<RegisterProvider>(context,
                                        listen: false)
                                    .btnEnableAction(),
                          ),
                          InputBox(
                            controller: stateAction.email,
                            helperText: stateAction.emailStateText,
                            hintText: 'Enter your valid email',
                            isNumber: false,
                            type: TextInputType.emailAddress,
                            onChange: (String value) {
                              if (isValidEmail(value)) {
                                stateAction.updateEmailState(
                                    'Valid Email', true);
                              } else {
                                stateAction.updateEmailState(
                                    'Invalid Email', false);
                              }
                              Provider.of<RegisterProvider>(context,
                                      listen: false)
                                  .btnEnableAction();
                            },
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          IntlPhoneField(
                            controller: stateAction.phone,
                            decoration: const InputDecoration(
                              labelText: 'Phone',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                            initialCountryCode: stateAction.ISOcountryCode,
                            onChanged: (phone) {
                              Provider.of<RegisterProvider>(context,
                                      listen: false)
                                  .btnEnableAction();
                              stateAction.countryCode = phone.countryCode;
                              stateAction.ISOcountryCode = phone.countryISOCode;
                            },
                          ),
                          InputBox(
                            controller: stateAction.password,
                            helperText: 'Passwords must contain at least six',
                            hintText: 'password',
                            isNumber: false,
                            type: TextInputType.emailAddress,
                            onChange: (String value) =>
                                Provider.of<RegisterProvider>(context,
                                        listen: false)
                                    .btnEnableAction(),
                            isPassword: true,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          // Container for the account_type radio input
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Account Type",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: "personal",
                                      groupValue: stateAction.accountType,
                                      onChanged: (value) {
                                        Provider.of<RegisterProvider>(context,
                                                listen: false)
                                            .btnEnableAction();
                                        stateAction.updateAccountType(value!);
                                      },
                                    ),
                                    const Text("Personal"),
                                    const SizedBox(
                                        width:
                                            20), // Adjust the spacing between radio buttons
                                    Radio<String>(
                                      value: "business",
                                      groupValue: stateAction.accountType,
                                      onChanged: (value) {
                                        Provider.of<RegisterProvider>(context,
                                                listen: false)
                                            .btnEnableAction();
                                        stateAction.updateAccountType(value!);
                                      },
                                    ),
                                    const Text("Business"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (stateAction.accountType == 'business')
                            Align(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                child: EasyAutocomplete(
                                  decoration: const InputDecoration(
                                    labelText: "Position",
                                  ),
                                  suggestions: stateAction.positionList,
                                  onChanged: (value) {
                                    Provider.of<RegisterProvider>(context,
                                            listen: false)
                                        .btnEnableAction();
                                    stateAction.position.text = value;
                                  },
                                  onSubmitted: (value) {
                                    Provider.of<RegisterProvider>(context,
                                            listen: false)
                                        .btnEnableAction();
                                    stateAction.position.text = value;
                                  },
                                ),
                              ),
                            ),

                          SizedBox(
                            height: 2.h,
                          ),
                          SizedBox(
                            width: 60.w,
                            height: 12.w,
                            child: ElevatedButton(
                              onPressed: stateAction.isbtnEnabl
                                  ? () => Provider.of<RegisterProvider>(context,
                                          listen: false)
                                      .registerAction(context)
                                  : null,
                              child: Text(
                                "Join Us",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/login', (route) => false);
                            },
                            child: Text(
                              "Do you have already Account? Login",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 12.sp,
                                      color: Theme.of(context).primaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
