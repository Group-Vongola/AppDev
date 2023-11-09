//as a provider to conform the interface in different platform/software
import 'package:flutter_application_1/services/auth/auth_user.dart';

abstract class AuthProvider{
  Future<void>initialize();
  
  //to get the current user
  AuthUser? get currentUser;

  Future<AuthUser> logIn(
    {
      required String email,
      required String password,
    }
  );
  Future<AuthUser> createUser(
    {
      required String email,
      required String password,
    }
  );
  Future<void> logOut();
  Future<void> sendEmailVerification();

}