import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mailbox/page/Auth/Login/LoginView.dart';
import 'package:mailbox/page/Welcome/Logic/wlecome_cubit.dart';
import '../../components/logo.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => WelcomeCubit()..initialize(),
        child: BlocListener<WelcomeCubit, WelcomeState>(
          listener: (context, state) {
            print("____________listner call_____________");
            if (state is HomeState) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/emailLog',
                (route) => false,
              );
            } else if (state is ExtendedProfileState) {
              // Future.delayed(
              //   const Duration(seconds: 0),
              //   () =>
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/extendedProfile',
                (route) => false,
                // ),
              );
            } else if (state is MessageState) {
              // Future.delayed(
              //   const Duration(seconds: 0),
              //   () =>
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/message',
                (route) => false,
                // ),
              );
            } else if (state is BusinessProfile) {
              // Future.delayed(
              //   const Duration(seconds: 0),
              //   () =>
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/businessProfile',
                (route) => false,
                // ),
              );
            } else if (state is LoginState) {
              // Future.delayed(
              //   const Duration(seconds: 0),
              //   () =>
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/login',
                (route) => false,
              );
              // );
            }
          },
          child: const Center(
            child: Logo(),
          ),
        ),
      ),
    );
  }
}
