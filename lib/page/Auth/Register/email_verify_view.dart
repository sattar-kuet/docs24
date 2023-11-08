import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'Provider/email_verify_provider.dart';

class EmailVerify extends StatelessWidget {
  const EmailVerify({super.key});

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context)!.settings.arguments as Map;
    return ChangeNotifierProvider(
      create: (context) => EmailVerifyProvider(),
      child: Consumer<EmailVerifyProvider>(builder: (context, stateAction, __) {
        return LoadingOverlay(
          isLoading: stateAction.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Email Verify"),
              centerTitle: false,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 9.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 12.sp),
                          text:
                              "Check your email (mail) for verification code. Enter code to continue"
                                  .replaceAll("(mail)", "(${route['email']})"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  OTPTextField(
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 10.w,
                    style: const TextStyle(fontSize: 17),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.underline,
                    onChanged: (value) =>
                        Provider.of<EmailVerifyProvider>(context, listen: false)
                            .initOtpAction(value),
                    onCompleted: (pin) =>
                        Provider.of<EmailVerifyProvider>(context, listen: false)
                            .initOtpAction(pin),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  SizedBox(
                    width: 40.w,
                    height: 5.h,
                    child: ElevatedButton(
                      onPressed: stateAction.otp.isNotEmpty
                          ? () {
                              Provider.of<EmailVerifyProvider>(context,
                                      listen: false)
                                  .otpVerifyAction(
                                context,
                                email: route['email'],
                                otp: stateAction.otp,
                                password: route['password'],
                                purpose: route['purpose']
                              );
                            }
                          : null,
                      child: Text(
                        "Verify",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 15.sp,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
