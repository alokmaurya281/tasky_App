// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tasky_app/apis/authentication.dart';
import 'package:tasky_app/screens/auth/login_screen.dart';
import 'package:tasky_app/utils/dialogs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const Drawer(),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () async {
              Dialogs.showProgressIndicator(context);
              await Authentication.signout(context);
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const LoginScreen();
              }));
            },
            child: const Text('logout'),
          ),
          Text(Authentication.user.toString()),
        ],
      ),
    );
  }
}
