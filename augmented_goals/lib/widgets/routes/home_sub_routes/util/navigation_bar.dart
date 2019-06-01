import 'package:augmented_goals/widgets/routes/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationBar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => NavigationBarState();
}

class NavigationBarState extends State<NavigationBar>{

  void onTabTapped(int value) {
    var state = HomePage.of(context).lastState;
    HomePage.of(context).indexBloc.updateIndex(state, value);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: onTabTapped, // new
        fixedColor: Colors.blue,
        currentIndex: HomePage.of(context).lastState.index, // new
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            title: Text(
              'Home Feed',
              style: TextStyle(color: Colors.black),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment, color: Colors.black),
            title: Text('Goals', style: TextStyle(color: Colors.black)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map, color: Colors.black),
            title: Text('Explore', style: TextStyle(color: Colors.black)),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.black),
              title: Text('Profile', style: TextStyle(color: Colors.black))),
        ]);
  }
}