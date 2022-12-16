import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final String? email;
  final bool isEmailVerfied;
  const AuthUser(this.email, this.isEmailVerfied);

  factory AuthUser.fromFirebase(User user) => AuthUser(
        user.email,
        user.emailVerified,
      );
}
