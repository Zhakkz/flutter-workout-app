import 'package:firebase_core/firebase_core.dart';
import 'package:fit/domains/UserService.dart';
import 'package:fit/screen/auth.dart';
import 'package:fit/screen/home.dart';
import 'package:fit/screen/landing.dart';
import 'package:fit/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaxFitApp());
}

class MaxFitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserService>.value(
        value: AuthService().currentUser,
        child: MaterialApp(
          title: 'Max fitness',
          theme: ThemeData(
              primaryColor: Color.fromRGBO(50, 65, 85, 1),
              textTheme: TextTheme(title: TextStyle(color: Colors.white))),
          home: LandingPage(),
        ));
  }
}
