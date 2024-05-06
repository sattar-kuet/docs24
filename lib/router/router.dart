import 'package:flutter/material.dart';
import 'package:mailbox/page/Auth/Login/LoginView.dart';
import 'package:mailbox/page/Auth/Login/newPasswordView.dart';
import 'package:mailbox/page/Auth/Register/email_verify_view.dart';
import 'package:mailbox/page/Auth/Register/register_view.dart';
import 'package:mailbox/page/BusinessProfile/businessProfileView.dart';
import 'package:mailbox/page/Employee/employeeListView.dart';
import 'package:mailbox/page/Employee/employeeView.dart';

import 'package:mailbox/page/Home/HomeView.dart';
import 'package:mailbox/page/Home/JobDetailView.dart';
import 'package:mailbox/page/Home/JobView.dart';
import 'package:mailbox/page/Home/jobApplyView.dart';
import 'package:mailbox/page/Welcome/WelcomeView.dart';
import 'package:mailbox/page/Welcome/messageView.dart';

import '../page/Auth/Login/emailInputView.dart';
import '../page/Auth/Register/profile_view.dart';
import '../page/BusinessProfile/businessProfileEdit.dart';
import '../page/BusinessProfile/extendedProfileEdit.dart';
import '../page/BusinessProfile/extendedProfileView.dart';
import '../page/Contact/contactListView.dart';
import '../page/Contact/contactView.dart';
import '../page/SendMail/sendMailView.dart';
import '../page/quote/screens/quote_input.dart';
import '../utility/systemInfo.dart';

class Routers {
  static Map<String, Widget Function(BuildContext)> getPages = {
    "/": (_) {
      if (SystemInfo.getUid == null) {
        return const WelcomeView();
      } else if (SystemInfo.getIsBusinessProfile == false &&
          SystemInfo.getIsOwner == true) {
        return const JobView();
      } else {
        return const HomeView();
      }
    },
    '/emailLog': (_) => const HomeView(),
    '/welcome': (_) => const WelcomeView(),
    '/jobDetail': (_) => const JobDetailView(),
    '/jobApply': (_) => const JobApplyView(),
    '/register': (_) => const RegisterView(),
    '/login': (_) => const LoginView(),
    '/profile': (_) => const ProfileView(),
    '/emailInput': (_) => const EmailInputView(),
    '/newPassword': (_) => const NewPasswordView(),
    '/verifyemail': (_) => const EmailVerify(),
    '/businessProfile': (_) => const BusinessProfileView(),
    '/extendedProfile': (_) => const ExtendedProfileView(),
    '/extendedProfileEdit': (_) => const ExtendedProfileEdit(),
    '/businessProfileEdit': (_) => const BusinessProfileEdit(),
    '/contactList': (_) => const ContactListView(),
    '/contactManage': (_) => const ContactView(),
    '/employeeList': (_) => const EmployeeListView(),
    '/employeeManage': (_) => const EmployeeView(),
    '/message': (_) => const MessageView(),
    '/sendMail': (_) => const SendMailView(),
    '/quote_info':(_)=> const QuoteInput()
  };
}
