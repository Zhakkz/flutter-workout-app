import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  String id;

  UserService.fromFirebase(User user) {
    id = user.uid;
  }
}