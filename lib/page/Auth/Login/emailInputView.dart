import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:docs24/components/inputBox.dart';
import 'package:docs24/page/Auth/Login/Provider/passwordRecoveryProvider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EmailInputView extends StatelessWidget {
  const EmailInputView({super.key});

  @override
  Widget build(BuildContext context) {
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
                              "Verify yourself",
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
                            controller: stateAction.emailController,
                            helperText: '',
                            hintText: 'Enter your account email',
                            isNumber: false,
                            type: TextInputType.emailAddress,
                            onChange: (String value) =>
                                Provider.of<PasswordRecoveryProvider>(context,
                                        listen: false)
                                    .btnEnableAction(),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/login', (route) => false);
                            },
                            child: Text(
                              "Back to login? Click here",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 12.sp,
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
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
                                      .checkEmail(context,
                                          email: stateAction
                                              .emailController.value.text)
                                  : null,
                              child: Text(
                                "Verify",
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
