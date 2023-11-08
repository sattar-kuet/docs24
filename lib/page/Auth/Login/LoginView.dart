import 'package:flutter/material.dart';
import 'package:docs24/page/Welcome/Provider/welcomeProvider.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => WelcomeProvider(),
      child: Consumer<WelcomeProvider>(builder: (context, stateAction, _) {
        return const Scaffold(
          body: Center(
            child: Text('Login page'),
          ),
        );
      }),
    );
  }
}
