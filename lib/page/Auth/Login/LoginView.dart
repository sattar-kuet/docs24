import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mailbox/components/inputBox.dart';
import 'package:mailbox/page/Auth/Login/Provider/loginProvider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../components/logo.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      body: ChangeNotifierProvider<LoginProvider>.value(
        value: LoginProvider(),
        child: Consumer<LoginProvider>(builder: (context, stateAction, __) {
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
                          const Align(
                            child: Logo(),
                          ),
                          Align(
                            child: Text(
                              "Login to Send mail",
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
                            hintText: 'Enter your valid email',
                            isNumber: false,
                            type: TextInputType.emailAddress,
                            onChange: (String value) =>
                                Provider.of<LoginProvider>(context,
                                        listen: false)
                                    .btnEnableAction(),
                          ),
                          InputBox(
                            controller: stateAction.passwordController,
                            helperText: 'Passwords must contain at least six',
                            hintText: 'Password',
                            isNumber: false,
                            type: TextInputType.emailAddress,
                            action: TextInputAction.done,
                            onChange: (String value) =>
                                Provider.of<LoginProvider>(context,
                                        listen: false)
                                    .btnEnableAction(),
                            isPassword: true,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/emailInput', (route) => false);
                            },
                            child: Text(
                              "Forgote Password? Recover Now",
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
                                  ? () => Provider.of<LoginProvider>(context,
                                          listen: false)
                                      .loginAction(context,
                                          email: stateAction
                                              .emailController.value.text,
                                          password: stateAction
                                              .passwordController.value.text)
                                  : null,
                              child: Text(
                                "Login",
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
                                  '/register', (route) => false);
                            },
                            child: Text(
                              "Don't you have Account? Create Account",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 12.sp,
                                    color: Theme.of(context).primaryColor,
                                  ),
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
