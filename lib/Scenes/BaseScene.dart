import 'package:bloc_app/Scenes/Scene1.dart';
import 'package:bloc_app/Scenes/Scene2.dart';
import 'package:bloc_app/Scenes/Scene3.dart';
import 'package:flutter/material.dart';

class BaseScene extends StatefulWidget {
  @override
  _BaseSceneState createState() => _BaseSceneState();
}

class _BaseSceneState extends State<BaseScene> {
  final _pageController = PageController(initialPage: 0, keepPage: true);
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          Scene1(),
          Scene2(),
          Scene3(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              label: 'Cubit', icon: Icon(Icons.account_circle)),
          BottomNavigationBarItem(label: 'Bloc', icon: Icon(Icons.map)),
          BottomNavigationBarItem(
              label: 'Riverpod', icon: Icon(Icons.campaign)),
        ],
        onTap: (index) {
          setState(() {
            _currentTab = index;
          });
          _pageController.jumpToPage(index);
        },
        currentIndex: _currentTab,
      ),
    );
  }
}
