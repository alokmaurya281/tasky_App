import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasky_app/firebase_options.dart';
import 'package:tasky_app/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await intializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        colorScheme: const ColorScheme.light(
          background: Colors.white,
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
      themeMode: ThemeMode.dark,
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
          backgroundColor: Color.fromARGB(255, 57, 11, 57),
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
      home: const WelcomeScreen(),
    );
  }
}

// intialize app

intializeApp() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
