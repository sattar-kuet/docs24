import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mailbox/components/inputBox.dart';
import 'package:mailbox/utility/systemInfo.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import '../../../utility/helper.dart';
import '../../Home/components/MenuDrawer.dart';
import 'Provider/profile_provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => ProfileProvider()..initialization(),
        child: Consumer<ProfileProvider>(builder: (context, stateAction, __) {
          return LoadingOverlay(
              isLoading: stateAction.isLoading,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text(
                    "Personal Profile",
                  ),
                  centerTitle: true,
                ),
                drawer: const MenuDrawer(),
                body: SafeArea(
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
                                height: 1.h,
                              ),
                              InputBox(
                                controller: stateAction.name,
                                helperText: '',
                                hintText: 'Full Name',
                                isNumber: false,
                                type: TextInputType.name,
                                onChange: (String value) =>
                                    Provider.of<ProfileProvider>(context,
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
                                  Provider.of<ProfileProvider>(context,
                                          listen: false)
                                      .btnEnableAction();
                                },
                              ),
                              if (stateAction.ISOcountryCode.isNotEmpty)
                                IntlPhoneField(
                                  controller: stateAction.phone,
                                  decoration: const InputDecoration(
                                    labelText: 'Phone',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                  initialCountryCode:
                                      stateAction.ISOcountryCode,
                                  onChanged: (phone) {
                                    Provider.of<ProfileProvider>(context,
                                            listen: false)
                                        .btnEnableAction();
                                    stateAction.countryCode = phone.countryCode;
                                    stateAction.ISOcountryCode =
                                        phone.countryISOCode;
                                  },
                                ),
                              SizedBox(
                                height: 2.h,
                              ),
                              if (SystemInfo.getIsBusinessProfile == true &&
                                  stateAction.initialPosition.isNotEmpty)
                                Align(
                                  child: Container(
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      child: EasyAutocomplete(
                                        initialValue:
                                            stateAction.initialPosition,
                                        decoration: const InputDecoration(
                                          labelText: "Position",
                                        ),
                                        suggestions: stateAction.positionList,
                                        onChanged: (value) {
                                          Provider.of<ProfileProvider>(context,
                                                  listen: false)
                                              .btnEnableAction();
                                          stateAction.position.text = value;
                                        },
                                        onSubmitted: (value) {
                                          Provider.of<ProfileProvider>(context,
                                                  listen: false)
                                              .btnEnableAction();
                                          stateAction.position.text = value;
                                        },
                                      )),
                                ),
                              SizedBox(
                                height: 2.h,
                              ),
                              SizedBox(
                                width: 60.w,
                                height: 12.w,
                                child: ElevatedButton(
                                  onPressed: stateAction.isbtnEnabl
                                      ? () => Provider.of<ProfileProvider>(
                                              context,
                                              listen: false)
                                          .profileAction(context)
                                      : null,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                        if (stateAction.isbtnEnabl) {
                                          // Return the color when the button is disabled
                                          return Colors.blue.shade200; // Change this to your desired color
                                        }
                                        // Return the color when the button is enabled
                                        return Colors.grey.shade200; // Change this to your desired color
                                      },
                                    ),
                                  ),
                                  child: Text(
                                    "Save",
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ));
        }),
      ),
    );
  }
}
