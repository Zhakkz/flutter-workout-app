import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fit/components/active-workouts.dart';
import 'package:fit/components/workouts-list.dart';
import 'package:fit/services/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomaPageState createState() => _HomaPageState();
}

class _HomaPageState extends State<HomePage> {
  int sectionIndex = 0;

  @override
  Widget build(BuildContext context) {
    var  navigationBar = CurvedNavigationBar(
      items: <Widget>[
        Icon(Icons.fitness_center),
        Icon(Icons.search),
      ],
      index: sectionIndex,
      height: 50,
      onTap: (int index) => setState(() => sectionIndex = index),
    );
    return Container(
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            title: Text(sectionIndex == 0 ? 'Workout' : "Search Workout"),
            leading: Icon(Icons.fitness_center),
            actions: [
              FlatButton.icon(
                onPressed: () {
                  AuthService().logout();
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
                label: SizedBox.shrink(),
              )
            ],
          ),
          body: sectionIndex == 0 ? WorkoutsList() : ActiveWorkouts(),
          bottomNavigationBar: navigationBar
      ),
    );
  }
}
