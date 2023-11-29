// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tasky_app/screens/add_task_screen.dart';
import 'package:tasky_app/screens/home_screen.dart';
import 'package:tasky_app/screens/notes_scren.dart';
import 'package:tasky_app/screens/profile_screen.dart';
import 'package:tasky_app/screens/todays_task_screen.dart';

class MainScreen extends StatefulWidget {
  int currntIndex;
  MainScreen({
    super.key,
    required this.currntIndex,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pageScreen = [
    const HomeScreen(),
    const TodaysTaskScreen(),
    const AddTaskProjectScreen(),
    const NotesScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageScreen.elementAt(widget.currntIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: SizedBox(
          width: 50,
          height: 50,
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
            onPressed: () {
              onTapItem(2);
            },
            child: const Icon(
              Icons.add,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 60,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 4,
            elevation: 0,
            color: Theme.of(context).colorScheme.primary.withOpacity(.5),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      onTapItem(0);
                    },
                    icon: Icon(
                      Icons.home,
                      size: 22,
                      color: widget.currntIndex == 0
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      onTapItem(1);
                    },
                    icon: Icon(
                      Icons.calendar_month,
                      color: widget.currntIndex == 1
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.onBackground,
                      size: 22,
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  IconButton(
                    onPressed: () {
                      onTapItem(3);
                    },
                    icon: Icon(
                      Icons.note,
                      color: widget.currntIndex == 3
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.onBackground,
                      size: 22,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      onTapItem(4);
                    },
                    icon: Icon(
                      Icons.person,
                      color: widget.currntIndex == 4
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.onBackground,
                      size: 22,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTapItem(index) {
    setState(() {
      widget.currntIndex = index;
    });
  }
}
