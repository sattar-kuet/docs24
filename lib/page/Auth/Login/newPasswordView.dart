import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mailbox/components/inputBox.dart';
import 'package:mailbox/page/Auth/Login/Provider/passwordRecoveryProvider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class NewPasswordView extends StatelessWidget {
  const NewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      extendBodyBehindAppBar: false,
      body: ChangeNotifierProvider(
        create: (context) => PasswordRecoveryProvider(),
        child: Consumer<PasswordRecoveryProvider>(
            builder: (context, stateAction, __) {
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            child: Text(
                              "Reset Your Password",
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
                            controller: stateAction.passwordController,
                            helperText: '',
                            hintText: 'Enter New Password',
                            isNumber: false,
                            type: TextInputType.emailAddress,
                            isPassword: true,
                            onChange: (String value) =>
                                Provider.of<PasswordRecoveryProvider>(context,
                                        listen: false)
                                    .btnEnableAction(),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          InputBox(
                            controller: stateAction.confirmPasswordController,
                            helperText: '',
                            hintText: 'Confirm New Password',
                            isNumber: false,
                            type: TextInputType.emailAddress,
                            isPassword: true,
                            onChange: (String value) =>
                                Provider.of<PasswordRecoveryProvider>(context,
                                        listen: false)
                                    .btnEnableAction(),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            width: 60.w,
                            height: 12.w,
                            child: ElevatedButton(
                              onPressed: stateAction.isbtnEnabl
                                  ? () => Provider.of<PasswordRecoveryProvider>(
                                              context,
                                              listen: false)
                                          .updatePassword(
                                        context,
                                        stateAction
                                            .passwordController.value.text,
                                        route['email'],
                                      )
                                  : null,
                              child: Text(
                                "Submit",
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
          );
        }),
      ),
    );
  }
}
