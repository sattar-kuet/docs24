import 'package:flutter/material.dart';
import 'package:docs24/page/Welcome/Provider/welcomeProvider.dart';
import 'package:provider/provider.dart';

import '../../components/logo.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => WelcomeProvider(),
      child: Consumer<WelcomeProvider>(builder: (context, stateAction, _) {
        return const Scaffold(
          body: Center(
            child: Logo(),
          ),
        );
      }),
    );
  }
}
