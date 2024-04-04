part of 'wlecome_cubit.dart';

sealed class WelcomeState extends Equatable {
  const WelcomeState();

  @override
  List<Object> get props => [];
}

final class WelcomeInitial extends WelcomeState {}

final class HomeState extends WelcomeState {}

final class LoginState extends WelcomeState {}

final class ExtendedProfileState extends WelcomeState {}

final class MessageState extends WelcomeState {}

final class BusinessProfile extends WelcomeState {}
