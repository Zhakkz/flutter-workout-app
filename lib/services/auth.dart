import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit/domains/UserService.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  signWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      print(result);
      return UserService.fromFirebase(user);
    } on FirebaseAuthException catch  (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      return null;
    }
  }

  Future<UserService> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return UserService.fromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future logout() async {
    await _fAuth.signOut();
  }

  Stream<UserService> get currentUser {
    return _fAuth.authStateChanges().map((User user) => user != null ? UserService.fromFirebase(user):null );
  }

}