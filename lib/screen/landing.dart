import 'package:fit/domains/UserService.dart';
import 'package:fit/screen/auth.dart';
import 'package:fit/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserService user = Provider.of<UserService>(context);

    final bool isLoginedIn = user != null ? true:false;

    return isLoginedIn? HomePage() : AuthorizationPage();
  }
}