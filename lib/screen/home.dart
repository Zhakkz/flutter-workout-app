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
    return Container(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text('Fitness'),
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
        body: sectionIndex == 0 ? WorkoutsList():ActiveWorkouts(),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'My Workouts'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Find Worouts'),
          ],
          unselectedItemColor: Colors.black26,
          backgroundColor: Colors.white,
          currentIndex: sectionIndex,
          onTap: (int index){
            setState(() {sectionIndex = index;});
          },
        ),
      ),
    );
  }
}
