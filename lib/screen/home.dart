import 'package:fit/domains/workout.dart';
import 'package:fit/services/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text('Fitness'),
          leading: Icon(Icons.fitness_center),
          actions: [
            FlatButton.icon(
              onPressed: () { AuthService().logout(); },
              icon: Icon(Icons.exit_to_app, color: Colors.white,),
              label: SizedBox.shrink(),
            )
          ],
        ),
        body: WorkoutsList(),
      ),
    );
  }
}

class WorkoutsList extends StatelessWidget {
  final workouts = <Workout>[
    Workout(
        title: 'Test1',
        author: 'Person1',
        description: 'Test Wokout1',
        level: 'level1'),
    Workout(
        title: 'Test2',
        author: 'Person2',
        description: 'Test Wokout2',
        level: 'level2'),
    Workout(
        title: 'Test3',
        author: 'Person3',
        description: 'Test Wokout3',
        level: 'level3'),
    Workout(
        title: 'Test4',
        author: 'Person4',
        description: 'Test Wokout4',
        level: 'level1'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: ListView.builder(
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(color: Colors.amber[500]),
                  child: ListTile(
                    leading: Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.fitness_center),
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  width: 1, color: Colors.orange[100]))),
                    ),
                    title: Text(
                      workouts[index].title,
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing: Icon(
                      Icons.arrow_right,
                    ),
                    subtitle: subtitles(context, workouts[index]),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

Widget subtitles(BuildContext context, Workout workout) {
  var color = Colors.grey;
  double indicatorLevel = 0;

  switch (workout.level) {
    case 'level1':
      color = Colors.green;
      indicatorLevel = 0.33;
      break;
    case 'level2':
      color = Colors.purple;
      indicatorLevel = 0.66;
      break;
    case 'level3':
      color = Colors.red;
      indicatorLevel = 0.99;
      break;
    default:
  }

  return Row(
    children: <Widget>[
      Expanded(
        flex: 5,
        child: LinearProgressIndicator(
          backgroundColor: Colors.white,
          value: indicatorLevel,
          valueColor: AlwaysStoppedAnimation(color),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(
        flex: 3,
        child: Text(
          workout.level,
          style: TextStyle(color: Colors.white),
        ),
      )
    ],
  );
}
