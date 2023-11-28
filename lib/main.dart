import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasky_app/apis/authentication.dart';
import 'package:tasky_app/screens/auth/login_screen.dart';
import 'package:tasky_app/screens/home_screen.dart';
import 'package:tasky_app/screens/welcome_screen.dart';
import 'package:tasky_app/utils/intialize_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await InitializeApp.intialize();
  runApp(
    MyApp(shared: prefs),
  );
}

class MyApp extends StatelessWidget {
  final shared;
  const MyApp({super.key, required this.shared});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isWelcome = shared.getBool('isWelcome') ?? true;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        colorScheme: const ColorScheme.light(
          background: Color.fromARGB(255, 230, 232, 255),
          primary: Color.fromARGB(255, 65, 14, 160),
          onPrimary: Colors.black,
          secondary: Color.fromARGB(255, 140, 140, 140),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: const Color.fromARGB(255, 65, 14, 160),
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
            size: 24,
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          // backgroundColor: Color.fromARGB(255, 57, 11, 57),
        ),
        useMaterial3: true,
        primaryColor: const Color.fromRGBO(95, 55, 225, 1),
      ),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        colorScheme: const ColorScheme.dark(
          background: Color.fromARGB(255, 57, 11, 57),
          primary: Color.fromARGB(255, 67, 215, 245),
          onBackground: Colors.white,
          onPrimary: Colors.white,
          secondary: Color.fromARGB(255, 182, 182, 182),
        ),
        drawerTheme: const DrawerThemeData(),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
            size: 24,
          ),
          backgroundColor: Color.fromARGB(255, 32, 29, 32),
          elevation: 5,
          // backgroundColor: Color.fromARGB(255, 57, 11, 57),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: const Color.fromARGB(255, 67, 215, 245),
          ),
        ),
        useMaterial3: true,
        primaryColor: const Color.fromRGBO(95, 55, 225, 1),
      ),
      home: isWelcome
          ? WelcomeScreen(
              shared: shared,
            )
          : Authentication.user != null
              ? const HomeScreen()
              : const LoginScreen(),
    );
  }
}
