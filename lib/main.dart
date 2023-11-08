import 'package:flutter/material.dart';
import 'package:docs24/router/router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'page/Auth/Login/Provider/loginProvider.dart';
import 'page/BusinessProfile/Provider/businessProfileProvider.dart';
import 'page/SendMail/Provider/sendMailProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ItScholarbd());
}

class ItScholarbd extends StatelessWidget {
  const ItScholarbd({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BusinessProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SendMailProvider(),
        )
      ],
      child: Sizer(
        builder: (context, __, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: Routers.getPages,
            initialRoute: '/',
          );
        },
      ),
    );
  }
}
