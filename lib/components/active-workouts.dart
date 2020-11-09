import 'package:flutter/cupertino.dart';

class ActiveWorkouts extends StatefulWidget {
  ActiveWorkouts({Key key}) : super(key: key);

  @override
  _ActiveWorkoutsState createState() => _ActiveWorkoutsState();
}

class _ActiveWorkoutsState extends State<ActiveWorkouts> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('active workouts'),
    );
  }
}