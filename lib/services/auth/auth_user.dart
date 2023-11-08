import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';

//immutable->all fields in the class or subclass must be constant
@immutable
class AuthUser{
  final String id;
  //optional string if use ?
  final String email;
  final bool isEmailVerified;
  const AuthUser({
    required this.id,
    required this.email, 
    required this.isEmailVerified,
  });

  //factory initializer, use the constructor in line 8
  //this is to limit the exposure of properties of firebase's user
  factory AuthUser.fromFirebase(User user) => AuthUser(
    id: user.uid,
    email: user.email!,
    isEmailVerified: user.emailVerified,
  );

}