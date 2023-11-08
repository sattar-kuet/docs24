import 'package:flutter/material.dart';
import '../page/Auth/Login/LoginView.dart';
import '../page/Auth/Login/newPasswordView.dart';
import '../page/Auth/Register/email_verify_view.dart';
import '../page/Auth/Register/register_view.dart';
import '../page/BusinessProfile/businessProfileView.dart';
import '../page/Employee/employeeListView.dart';
import '../page/Employee/employeeView.dart';

import '../page/Home/HomeView.dart';
import '../page/Home/JobDetailView.dart';
import '../page/Home/JobView.dart';
import '../page/Home/jobApplyView.dart';
import '../page/Welcome/WelcomeView.dart';
import '../page/Welcome/messageView.dart';

import '../page/Auth/Login/emailInputView.dart';
import '../page/Auth/Register/profile_view.dart';
import '../page/BusinessProfile/businessProfileEdit.dart';
import '../page/BusinessProfile/extendedProfileEdit.dart';
import '../page/BusinessProfile/extendedProfileView.dart';
import '../page/Contact/contactListView.dart';
import '../page/Contact/contactView.dart';
import '../page/SendMail/sendMailView.dart';
import '../utility/systemInfo.dart';

class Routers {
  static Map<String, Widget Function(BuildContext)> getPages = {
    "/": (_) => const LoginView(),
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
  };
}
