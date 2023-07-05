import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../model/user.dart';
import 'barterscreen.dart';
import 'owneritemscreen.dart';
import 'profiletabscreen.dart';

class MainScreen extends StatefulWidget {
    final User user;
  const MainScreen({super.key, required this.user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
   late List<Widget> tabchildren;
  int _currentIndex = 0;
  String maintitle = "Barter";

  @override
  void initState() {
    super.initState();
    //\print(widget.user.name);
    print("Barterscreen");
    tabchildren = [
      BarterScreen(
        user: widget.user,
      ),
      OwnerItemScreen(user: widget.user),
      ProfileTabScreen(user: widget.user),
    ];
  }
 @override
  void dispose() {
    super.dispose();
    print("dispose");
  }


 @override
  Widget build(BuildContext context) {
   
    return Scaffold(
     
      body: tabchildren[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.swap_horiz,
                ),
                label: "Barter"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.card_giftcard_outlined,
                ),
                label: "Owner"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "Profile"),
          ]),
    );
  }

  void onTabTapped(int value) {
    setState(() {
      _currentIndex = value;
      if (_currentIndex == 0) {
        maintitle = "Barter";
      }
      if (_currentIndex == 1) {
        maintitle = "Owner";
      }
      if (_currentIndex == 2) {
        maintitle = "Profile";
      }
    });
  }
}