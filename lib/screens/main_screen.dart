// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';
import 'package:tasky_app/screens/add_project_screen.dart';
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
              actionModalBottomSheet();
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
        height: 70,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 4,
          elevation: 5,
          color: Theme.of(context).colorScheme.primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  onTapItem(0);
                },
                icon: Icon(
                  Icons.home,
                  size: widget.currntIndex == 0 ? 24 : 22,
                  color: widget.currntIndex == 0
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).colorScheme.secondary,
                ),
              ),
              IconButton(
                onPressed: () {
                  onTapItem(1);
                },
                icon: Icon(
                  Icons.calendar_month,
                  color: widget.currntIndex == 1
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).colorScheme.secondary,
                  size: widget.currntIndex == 1 ? 24 : 22,
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              IconButton(
                onPressed: () {
                  onTapItem(2);
                },
                icon: Icon(
                  Icons.note,
                  color: widget.currntIndex == 2
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).colorScheme.secondary,
                  size: widget.currntIndex == 2 ? 24 : 22,
                ),
              ),
              IconButton(
                onPressed: () {
                  onTapItem(3);
                },
                icon: Icon(
                  Icons.person,
                  color: widget.currntIndex == 3
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).colorScheme.secondary,
                  size: widget.currntIndex == 3 ? 24 : 22,
                ),
              )
            ],
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

  void actionModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 180,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: ListView(
                children: [
                  Text(
                    'Choose Action',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const AddProjectScreen();
                          }));
                        },
                        child: Text(
                          'Add Project',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const AddTaskProjectScreen();
                          }));
                        },
                        child: Text(
                          'Add Task',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
