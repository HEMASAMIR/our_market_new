part of 'authentication_cubit.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

//LOGIN UP STATES

final class LoginSuccess extends AuthenticationState {}

final class LoginLoading extends AuthenticationState {}

final class LoginError extends AuthenticationState {
  final String message;

  LoginError(this.message);
}

//SIGN UP STATES
final class SignUpSuccess extends AuthenticationState {}

final class SignUpLoading extends AuthenticationState {}

final class SignUpError extends AuthenticationState {
  final String message;

  SignUpError(this.message);
}
//SIGN IN WITH GOOGLE STATES

final class GoogleSignInSuccess extends AuthenticationState {}

final class GoogleSignInLoading extends AuthenticationState {}

final class GoogleSignInError extends AuthenticationState {}

//LOG OUT STATES

final class LogoutLoading extends AuthenticationState {}

final class LogoutSuccess extends AuthenticationState {}

final class LogoutError extends AuthenticationState {}

//RESET PASSWORD  STATES

final class PasswordResetLoading extends AuthenticationState {}

final class PasswordResetSuccess extends AuthenticationState {}

final class PasswordResetError extends AuthenticationState {}

//ADD USER DATE  STATES

final class UserDataAddedLoading extends AuthenticationState {}

final class UserDataAddedSuccess extends AuthenticationState {}

final class UserDataAddedError extends AuthenticationState {}

//GET USER DATA  STATES


final class GetUserDataLoading extends AuthenticationState {}

final class GetUserDataSuccess extends AuthenticationState {}

final class GetUserDataError extends AuthenticationState {}
