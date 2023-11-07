import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';

//immutable->all fields in the class or subclass must be constant
@immutable
class AuthUser{
  //optional string
  final String? email;
  final bool isEmailVerified;
  const AuthUser({
    required this.email, 
    required this.isEmailVerified,
  });

  //factory initializer, use the constructor in line 8
  //this is to limit the exposure of properties of firebase's user
  factory AuthUser.fromFirebase(User user) => AuthUser(
    email: user.email,
    isEmailVerified: user.emailVerified,
  );

}