import 'dart:math';

import 'package:fit/components/LoadingIndicator.dart';
import 'package:fit/domains/UserService.dart';
import 'package:fit/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:fit/components/LoadingIndicator.dart';


class AuthorizationPage extends StatefulWidget {
  AuthorizationPage({Key key}) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _email;
  String _password;
  bool showLogin = true;

  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Padding(
        padding: EdgeInsets.only(top: 200),
        child: Container(
          child: Align(
            child: Text(
              'Max fit',
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      );
    }

    Widget _input(Icon icon, String hint, TextEditingController controller,
        bool obscure) {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          style: TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
              hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white30),
              hintText: hint,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 3)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54, width: 1)),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: IconTheme(
                  data: IconThemeData(color: Colors.white),
                  child: icon,
                ),
              )),
        ),
      );
    }

    Widget _button(String text, void func()) {
      return RaisedButton(
        splashColor: Theme.of(context).primaryColor,
        highlightColor: Theme.of(context).primaryColor,
        color: Colors.white,
        child: Text(text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: 20)),
        onPressed: () {
          func();
        },
      );
    }

    Widget _form(String label, void func()) {
      return Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 10),
              child:
                  _input(Icon(Icons.email), 'EMAIL', _emailController, false),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 10),
              child: _input(
                  Icon(Icons.lock), 'PASSWORD', _passwordController, true),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: _button(label, func),
              ),
            )
          ],
        ),
      );
    }

    Widget _bottomWave() {
      return Expanded(
          child: Align(
        child: ClipPath(
          child: Container(
            color: Colors.white,
            height: 300,
          ),
          clipper: BottomWaveClipper(),
        ),
        alignment: Alignment.bottomCenter,
      ));
    }

    void _showToast(String text) {
      Fluttertoast.showToast(
          msg: text,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    void showLoadingIndicator() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                backgroundColor: Colors.black87,
                content: LoadingIndicator(),
              ));
        },
      );
    }

    void _authBtn() async {
      _email = _emailController.text;
      _password = _passwordController.text;

      showLoadingIndicator();
      print('log in action');

      if (_email.isEmpty || _password.isEmpty) {
        _showToast("Email or Password is empty!");
        return;
      }

      var user = await AuthService()
          .signWithEmailAndPassword(_email.trim(), _password.trim());

      if (user == null) {
        _showToast("Can't sign in!");
      } else {
        _passwordController.clear();
        _emailController.clear();
      }
      Navigator.of(context).pop();
    }

    void _registerBtn() {
      _email = _emailController.text;
      _password = _passwordController.text;

      if (_email.isEmpty || _password.isEmpty) {
        _showToast("Email or Password is empty!");
        return;
      }

      Future<UserService> user = AuthService()
          .registerWithEmailAndPassword(_email.trim(), _password.trim());

      if (user == null) {
        _showToast("Can't registered!");
      } else {
        _passwordController.clear();
        _emailController.clear();
      }
    }

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: <Widget>[
            _logo(),
            (showLogin
                ? Column(
                    children: <Widget>[
                      _form('Log in', _authBtn),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: GestureDetector(
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            setState(() {
                              showLogin = false;
                            });
                          },
                        ),
                      )
                    ],
                  )
                : Column(
                    children: <Widget>[
                      _form('Register', _registerBtn),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: GestureDetector(
                          child: Text(
                            'Register??',
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            setState(() {
                              showLogin = true;
                            });
                          },
                        ),
                      )
                    ],
                  )),
            _bottomWave()
          ],
        ),
        resizeToAvoidBottomPadding: false);
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height + 5);
    var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
