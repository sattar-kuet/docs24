import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mailbox/repository/account_status.dart';
import 'package:mailbox/utility/APIRoot.dart';
import 'package:mailbox/utility/systemInfo.dart';
import 'package:http/http.dart' as http;
part 'wlecome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit() : super(WelcomeInitial());

  void initialize() async {
    await dbNameAction();
    await loginStatusCheckAction();
  }

  Future<void> dbNameAction() async {
    http.Response response =
        await ApiRoot.request({}, url: 'db_name', isEmpty: true);
    final body = json.decode(response.body)['result'];
    if (body['status'] == true) {
      // debugPrint("----- DB name get data -----");
      print("_________1________");
      SystemInfo.setDBName('app_db');
    }
  }

  Future<void> loginStatusCheckAction() async {
    if (SystemInfo.getToken != null) {
      http.Response response = await ApiRoot.request(
        {},
        url: 'session/check',
        isEmpty: true,
      );
      final body = json.decode(response.body)['result'];

      if (body['status'] == true) {
        dynamic profileStatus = await AccountStatus.userStateCheckAction();

        if (profileStatus['is_business_account'] == false) {
          if (profileStatus['is_complete']) {
            emit(HomeState());
          } else {
            emit(ExtendedProfileState());
          }
        } else if (profileStatus['is_complete']) {
          if (profileStatus['status'] == "approved") {
            emit(HomeState());
          } else if (profileStatus['status'] == "email_verification_pending") {
            emit(LoginState());
          } else {
            emit(MessageState());
          }
        } else {
          emit(BusinessProfile());
        }
      } else {
        emit(LoginState());
      }
    } else {
      print("_________2________");
      emit(LoginState());
      print(state);
    }
  }

  // Future<bool> profileStateCheckAction() async {
  //   http.Response response = await ApiRoot.request(
  //     {
  //       "uid": SystemInfo.getUid,
  //     },
  //     url: 'client/profile/status',
  //   );

  //   final body = json.decode(response.body)['result'];
  //   return body['is_complete'];
  // }
}
